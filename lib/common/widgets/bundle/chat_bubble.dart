import 'dart:io';
import 'dart:math';
import 'dart:html' as html;
import 'package:http/http.dart' as http;

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
    required this.message, required this.token, required this.userId,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final String API_URL = dotenv.env['api_url']!;
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
    if (widget.message.audioFile != null || widget.message.audioUrl != null) _setupAudio();
  }



  void _setupAudio() {

    _audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d; // Обновляем _duration при изменении длительности аудио
      });
    });

    _audioPlayer.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        print("asd");
        _isPlaying = false;
        isSound = false;
        // _position = Duration(milliseconds: 1); // Сбрасываем позицию
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

    // Если есть audioFile.bytes, используем их
    if (widget.message.audioFile?.bytes != null) {
      await _audioPlayer.play(BytesSource(widget.message.audioFile!.bytes));
    } else if (widget.message.audioUrl != null) {

      _audioPlayer.play(UrlSource("$API_URL/v1/media/${widget.userId}/${widget.message.audioUrl}"));
    }
    // Если audioFile.bytes нет, но есть audioUrl, используем его

    // Если оба источника отсутствуют, ничего не делаем
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final safeElapsed = _position <= _duration ? _position : _duration;
    return MouseRegion(
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
        alignment:
            widget.message.user ? Alignment.centerRight : Alignment.centerLeft,
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
                  maxWidth: widget.message.user
                      ? screenWidth * 0.4
                      : screenWidth * 0.5,
                  minWidth: widget.message.isLoading ? 70 : 180,
                  minHeight: 70,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
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
                          if (widget.message.audioFile != null || widget.message.audioUrl != null)
                            Row(
                              children: [
                                IconButton(
                                  icon: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: const BoxDecoration(
                                      color: Color(0xff77ADED),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                    ),
                                    child: Icon(
                                      isSound ? Icons.stop : Icons.play_arrow,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  onPressed: () async {
                                    _togglePlay();
                                  },
                                ),
                                const SizedBox(width: 10),
                                SquigglyWaveform(
                                  samples: _samples,
                                  height: 40,
                                  width: screenWidth * 0.20,
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
                              (widget.message.audioFile == null && widget.message.audioUrl == null))
                            SelectableRegion(
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
                                    color: const Color(0xff56CCFF)
                                        .withOpacity(0.5),
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
                                              title: Text(
                                                  'Не удалось открыть ссылку: $href'),
                                            );
                                          });
                                      // throw 'Не удалось открыть ссылку: $href';
                                    }
                                  }
                                },
                              ),
                            ),
                          const SizedBox(height: 10),
                          if (widget.message.attachFile != null || widget.message.imageUrl != null)
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
                                child: ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.message.attachFile?.fileName ?? widget.message.imageUrl!,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        if (widget.message.attachFile != null)
                                          Text(
                                            FormatterText.formatFileSize(widget
                                                .message
                                                .attachFile!
                                                .bytes
                                                .length),
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                      ],
                                    ),
                                    titleAlignment: ListTileTitleAlignment.top,
                                    leading: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: widget.message.imageUrl !=
                                                   null
                                                ?
                                            NetworkImage(
                                                    "${API_URL}/v1/media/user/${widget.message.imageUrl}",
                                                    headers: {
                                                      "Authorization":
                                                            "Bearer ${widget.token}"
                                                    })
                                                : MemoryImage(widget
                                                    .message.attachFile!.bytes),
                                            fit: BoxFit.cover,
                                          )),
                                    )),
                              ),
                            ),
                          if (widget.message.images != null)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 10,
                              children: widget.message.images!.map((e) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => ViewFile(
                                                  media: "$API_URL/v1/media/$e",
                                                ));
                                      },
                                      child: Image.network(
                                        "$API_URL/v1/media/$e", // URL изображения
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child; // Изображение загружено
                                          return Center(
                                            child: CircularProgressIndicator(
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
                    offset: Offset(0, -43),
                    child: SvgPicture.asset("assets/svg/client_message.svg"),
                  )
                : Transform.translate(
                    offset: const Offset(0, -51),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.translate(
                          offset: const Offset(0, -6),
                          child: Container(
                              margin: const EdgeInsets.only(right: 10.0),
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: SvgPicture.asset("assets/logo/logo.svg")),
                        ),
                        SvgPicture.asset("assets/svg/bot_message.svg"),
                      ],
                    ),
                  ),
            if (!widget.message.user)
              Transform.translate(
                offset: const Offset(100, -55),
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
                            SnackBar(content: Text(S.of(context).textCoped)),
                          );
                        },
                        icon: SvgPicture.asset("assets/svg/copy.svg"),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
