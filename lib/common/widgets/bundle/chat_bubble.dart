import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:ed_helper_web/data/repositories/chat_gpt_repositories.dart';
import 'package:ed_helper_web/data/services/chat_gpt_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/chat_message/chat_message.dart';
import '../../../generated/l10n.dart';
import '../../../util/formatters/formatter_text.dart';
import '../card/view_file.dart';

class ChatBubble extends StatefulWidget {
  final ChatMessage message;
  final String token;
  final int userId;

  ChatBubble({
    super.key,
    required this.message,
    required this.token,
    required this.userId,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final API_URL = dotenv.env['api_url']!;
  List<double> _samples = [];
  bool isSound = false;
  bool isHovered = false;
  Duration _duration = const Duration(seconds: 1);
  Duration _position = const Duration(seconds: 1);
  bool _isPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.message.audioFile != null || widget.message.audioUrl != null)
      _setupAudio();
  }

  void _setupAudio() {
    _audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });

    _audioPlayer.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _isPlaying = false;
        isSound = false;
      });
    });

    _generateRandomSamples();
  }

  void _generateRandomSamples() {
    final random = Random();
    setState(() {
      _samples = List.generate(30, (index) => random.nextDouble() * 1.4 - 0.7);
    });
  }

  void _togglePlay() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
        isSound = false;
      });
      return;
    }

    if (widget.message.audioFile?.bytes != null) {
      await _audioPlayer.play(BytesSource(widget.message.audioFile!.bytes));
    } else if (widget.message.audioUrl != null) {
      _audioPlayer.play(UrlSource(
          "$API_URL/v1/media/${widget.userId}/${widget.message.audioUrl}"));
    }

    else {
      print("No audio source available");
      return;
    }

    setState(() {
      _isPlaying = true;
      isSound = true;
    });
  }

  void _playAudio(Uint8List bytes) async {
    try {
      await _audioPlayer.play(BytesSource(widget.message.audioFile!.bytes));
      _audioPlayer.onPlayerComplete.listen((event) {
        setState(() {
          isSound = false;
        });
      });
    } catch (e) {
      print("Failed to play audio: $e");
    }
  }

  Future<void> ttsMessage() async {
    late File ttsFile;
    final pathDocumentDirectory = await getApplicationDocumentsDirectory();
    final voiceDir =
        Directory("${pathDocumentDirectory.path}/ed_helper/voice_message");

    // Создаем директорию, если её нет
    if (!voiceDir.existsSync()) {
      voiceDir.createSync(recursive: true);
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? voice = prefs.getString("voice");

    ChatGptRepositories.synthesizeSpeech(
            text: widget.message.text, voice: voice ?? "alloy")
        .then((res) {
      ChatGptService.saveSpeechToFile(res, widget.message.audioFile!.bytes)
          .then((file) async {
        ttsFile = file;
        _playAudio(await file.readAsBytes());
      });
    });
  }

  Widget buildTextWidget() {
    return SelectableRegion(
      selectionControls: materialTextSelectionControls,
      focusNode: FocusNode(),
      child: MarkdownBody(
        selectable: false,
        data: widget.message.text,
        styleSheet: MarkdownStyleSheet(
          // Стиль для заголовков
          h1: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          h2: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          h3: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          // Стиль для обычного текста
          p: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          // Стиль для жирного текста
          strong: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          // Стиль для курсивного текста
          em: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
          // Стиль для зачеркнутого текста
          del: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 16,
            decoration: TextDecoration.lineThrough,
          ),
          // Стиль для маркированных списков
          listBullet: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          // Стиль для цитат
          blockquote: GoogleFonts.montserrat(
            color: Colors.grey[700],
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
          blockquotePadding: const EdgeInsets.all(15),
          // Стиль для ссылок
          a: GoogleFonts.montserrat(
            color: Colors.blue,
            fontSize: 18,
            decoration: TextDecoration.underline,
          ),
          // Стиль для блока кода
          code: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 16,
            backgroundColor: Colors.grey[200],
          ),
          codeblockPadding: const EdgeInsets.all(15),
          blockquoteDecoration: BoxDecoration(
            color: const Color(0xff56CCFF).withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          // Стиль для фона блока кода
          codeblockDecoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onTapLink: (text, href, title) async {
          if (href != null) {
            if (await canLaunch(href)) {
              await launch(href);
            } else {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Не удалось открыть ссылку: $href'),
                    );
                  });
              // throw 'Не удалось открыть ссылку: $href';
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final safeElapsed = _position <= _duration ? _position : _duration;
    return FractionallySizedBox(
      widthFactor: widget.message.user ? 0.72 : screenWidth < 600 ? 0.95 : 0.75,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: Align(
          alignment: widget.message.user
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Transform.translate(
            offset: Offset(
                widget.message.user ?
                     60
                    : screenWidth < 600
                        ? -80
                        : -50,
                0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: widget.message.user
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: widget.message.user
                      ? const Offset(-15, 0)
                      : const Offset(74, 0),
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(20.0),
                    constraints: BoxConstraints(
                      minHeight: 70,
                      minWidth: 70,
                      maxWidth: widget.message.audioUrl != null ? screenWidth * 0.35 : screenWidth * 0.85,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 2),
                          blurRadius: 7
                        )],
                        borderRadius: (widget.message.user)
                            ? const BorderRadius.all(
                                Radius.circular(30),
                              )
                            : const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(30))),
                    child: widget.message.isLoading
                        ? const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircularProgressIndicator(
                                color: Colors.blue,
                                strokeWidth: 2,
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.message.audioFile != null ||
                                  widget.message.audioUrl != null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      icon: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          color: Color(0xff77ADED),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                        child: Icon(
                                          isSound
                                              ? Icons.stop
                                              : Icons.play_arrow,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                      onPressed: () async {
                                        _togglePlay();
                                      },
                                    ),
                                    if (screenWidth >= 650)SquigglyWaveform(
                                      samples: _samples.getRange(0, screenWidth > 900 ? 25 : 30).toList(),
                                      height: 40,
                                      width: screenWidth * 0.3 - 80,
                                      activeColor: Colors.blue,
                                      inactiveColor: Colors.grey,
                                      maxDuration: _duration == Duration.zero
                                          ? const Duration(seconds: 1)
                                          : _duration,
                                      elapsedDuration: safeElapsed,
                                      invert: true,
                                      showActiveWaveform: true,
                                    ),
                                  ],
                                ),
                              if (widget.message.text.isNotEmpty &&
                                  (widget.message.audioFile == null &&
                                      widget.message.audioUrl == null))
                                buildTextWidget(),
                              const SizedBox(height: 10),
                              if (widget.message.attachFile != null ||
                                  widget.message.imageUrl != null)
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => ViewFile(
                                              message: widget.message,
                                              token: widget.token,
                                            ));
                                  },
                                  child: Transform.translate(
                                    offset: const Offset(-15, 0),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        maxWidth: 400,
                                      ),
                                      child: ListTile(
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.message.attachFile
                                                        ?.fileName ??
                                                    widget.message.imageUrl!,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              if (widget.message.attachFile !=
                                                  null)
                                                Text(
                                                  FormatterText.formatFileSize(
                                                      widget.message.attachFile!
                                                          .bytes.length),
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                            ],
                                          ),
                                          titleAlignment:
                                              ListTileTitleAlignment.top,
                                          leading: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: widget.message
                                                              .imageUrl !=
                                                          null
                                                      ? NetworkImage(
                                                          "${API_URL}/v1/media/user/${widget.message.imageUrl}",
                                                          headers: {
                                                              "Authorization":
                                                                  "Bearer ${widget.token}"
                                                            })
                                                      : MemoryImage(widget
                                                          .message
                                                          .attachFile!
                                                          .bytes),
                                                  fit: BoxFit.cover,
                                                )),
                                          )),
                                    ),
                                  ),
                                ),
                              if (widget.message.images != null)
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 10,
                                  children: widget.message.images!.map((e) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) => ViewFile(
                                                      media:
                                                          "$API_URL/v1/media/$e",
                                                    ));
                                          },
                                          child: Image.network(
                                            "$API_URL/v1/media/$e",
                                            // URL изображения
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child; // Изображение загружено
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.blue[300],
                                                  strokeWidth: 3,
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(Icons
                                                  .error); // В случае ошибки загрузки
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                )
                            ],
                          ),
                  ),
                ),
                widget.message.user
                    ? Transform.translate(
                        offset: const Offset(0, -43),
                        child:
                            SvgPicture.asset("assets/svg/client_message.svg"),
                      )
                    : (screenWidth > 600)
                        ? Transform.translate(
                            offset: const Offset(10, -51),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.translate(
                                  offset: const Offset(0, -6),
                                  child: Container(
                                      // margin: const EdgeInsets.only(right: 10.0),
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: const BoxDecoration(
                                          color : Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: SvgPicture.asset(
                                          "assets/logo/logo.svg")),
                                ),
                                SvgPicture.asset("assets/svg/bot_message.svg", semanticsLabel: "Bot meesage",),
                              ],
                            ),
                          )
                        : SizedBox(),
                if (!widget.message.user)
                  Transform.translate(
                    offset: Offset(100, screenWidth < 600 ? 0 : -55),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isHovered ? 1.0 : 0.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => ttsMessage(),
                            icon: SvgPicture.asset("assets/svg/listen.svg"),
                          ),
                          IconButton(
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: widget.message.text));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(S.of(context).textCoped)),
                              );
                            },
                            icon: SvgPicture.asset("assets/svg/copy.svg"),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
