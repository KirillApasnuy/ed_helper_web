import 'dart:html' as html;
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:ed_helper_web/common/widgets/app_widgets/language_selector.dart';
import 'package:ed_helper_web/common/widgets/dialog/error_dialog.dart';
import 'package:ed_helper_web/data/models/chat_message/chat_model.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/ed_api_repository.dart';
import 'package:ed_helper_web/screens/home/widgets/center_chat.dart';
import 'package:ed_helper_web/screens/home/widgets/center_main_logo.dart';
import 'package:ed_helper_web/screens/home/widgets/home_side_bar.dart';
import 'package:ed_helper_web/screens/welcome/widgets/side_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/widgets/button/text_button_type_one_gradient.dart';
import '../../common/widgets/button/text_button_type_two_gradient.dart';
import '../../common/widgets/form_fields/form_field_type_two.dart';
import '../../common/widgets/pictures/svg_icons.dart';
import '../../data/models/chat_message/chat_message.dart';
import '../../data/models/chat_message/file_model.dart';
import '../../data/models/gpt_answer/api_response.dart';
import '../../data/repositories/deepgram_repository.dart';
import '../../data/repositories/ed_helper/media_repository.dart';
import '../../generated/l10n.dart';
import '../../util/device/web_audio_recorder.dart';
import '../../util/formatters/formatter_text.dart';
import '../../util/routes/router.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, this.message});

  ChatMessage? message;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final recorder = WebAudioRecorder();
  final edApiRepository = EdApiRepository();
  final chatScrollController = ScrollController();
  final _mainScrollController = ScrollController();
  final mediaRepository = MediaRepository();
  final loadingMessage = ChatMessage(
      timestamp: DateTime.now(), text: "", user: false, isLoading: true);
  final chatController = TextEditingController();
  ChatModel _chatHistory =
      ChatModel(createdAt: DateTime.now(), id: 0, title: "", messages: []);
  FileModel? attachFile;
  FileModel? audioFile;
  bool isFileAttach = false;
  bool isMenuVisible = false;
  bool isRightMenuVisible = false;
  bool isVoiceMessage = false;
  bool value = false;
  bool isExpanded = true;
  bool isChats = false;
  bool isVoiceRecorder = false;
  bool isChangeCursor = false;
  bool isUploadingMedia = false;
  String combination = "Alt + X";

  @override
  void initState() {
    super.initState();
    _initDependency();
  }

  void onSelectChat(ChatModel model) {
    setState(() {
      if (widget.message == null) {
        _chatHistory = model;
      } else {
        widget.message = null;
      }
      widget.message = null;
      isMenuVisible = false;
      isRightMenuVisible = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void setChatTitle() async {
    if (_chatHistory.title == "") {
      print(_chatHistory.messages.first.text.split(" "));
      _chatHistory.title =
          _chatHistory.messages.first.text.split(" ").getRange(0, 4).join(" ");
    }
  }

  void setChatId(int chatId) async {
    if (_chatHistory.id == 0) {
      _chatHistory.id = chatId;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (chatScrollController.hasClients) {
        chatScrollController.animateTo(
          chatScrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void cancelVoiceRecorder() {
    setState(() {
      isVoiceRecorder = false;
    });
    recorder.stopRecording();
  }

  Future<void> _initDependency() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        setState(() {
          if (widget.message != null) {
            attachFile = widget.message!.attachFile;
            audioFile = widget.message!.audioFile;
            chatController.text = widget.message!.text;
            setState(() {
              if (attachFile != null) isFileAttach = true;
              if (audioFile != null) isVoiceMessage = true;
            });
            _sendMessage();
          }
          if (_chatHistory.messages.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToBottom();
            });
          }
        });
      });
    } catch (e) {
      debugPrint("Ошибка при инициализации: $e");
    }
  }

  void _sendMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    bool _isFileAttach = isFileAttach;
    try {
      final newMessage = ChatMessage(
        timestamp: DateTime.now(),
        text: chatController.text,
        user: true,
        imageUrl: _isFileAttach ? attachFile!.fileName : null,
        audioUrl: isVoiceMessage ? audioFile!.fileName : null,
        attachFile: _isFileAttach ? attachFile : null,
        audioFile: isVoiceMessage ? audioFile : null,
      );
      if (token == null) {
        AutoRouter.of(context).push(AuthorizationRoute(unAuthMessage: newMessage));
        return;
      }
      if (_isFileAttach && attachFile == null) {
        throw Exception('attachFile is null');
      }
      if (isVoiceMessage && audioFile == null) {
        throw Exception('audioFile is null');
      }
      if (_chatHistory.messages.isNotEmpty &&
          newMessage == _chatHistory.messages.last) {
        return;
      }
      _chatHistory.messages.add(newMessage);

      _chatHistory.messages.add(loadingMessage);
      setChatTitle();
      setState(() {
        isFileAttach = false;
        chatController.clear();
      });
      _scrollToBottom();

      String _voiceTranscription = '';

      try {
        if (isVoiceMessage) {
          final blob =
              html.Blob([audioFile!.bytes], 'audio/wav'); // Указываем MIME-тип
          final file = html.File([blob], audioFile!.fileName);
          _voiceTranscription =
              await DeepgramRepository().transcribeAudio(file);
          newMessage.text = _voiceTranscription;
          print(_voiceTranscription);
        }
      } on Exception catch (e) {
        print(e);
      }
      await edApiRepository
          .sendRequest(newMessage, _chatHistory.id)
          .then((res) {
        final ApiResponse gptAnswer;
        if (res.statusCode == 409) {
          gptAnswer = ApiResponse(chatId: _chatHistory.id, message: S.of(context).youHaveExceededYourMonthlyMessageLimitOrYourSubscription);
        } else {
          gptAnswer = ApiResponse.fromJson(res.data);
        }
        final answerMessage = ChatMessage(
            timestamp: DateTime.now(),
            text: gptAnswer.message,
            user: false,
            images: gptAnswer.media);
        if (_chatHistory.messages.last.isLoading) _chatHistory.messages.removeLast();
        setState(() {
          _chatHistory.messages.add(answerMessage);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToBottom();
          });
        });
        setChatId(gptAnswer.chatId);
      }).catchError((e) {
        print(e);
        ChatMessage errorMessage = ChatMessage(
            timestamp: DateTime.now(),
            text: S.of(context).errorSendMessage,
            user: false);
        setState(() {
          _chatHistory.messages.removeLast();
          _chatHistory.messages.add(errorMessage);
          _scrollToBottom();
        });
      });
      isVoiceMessage = false;
      setState(() {
        _scrollToBottom();
      });
    } catch (e) {
      print(e);
      throw Exception(e);
    }

    isFileAttach = false;
    chatController.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    // if (_messages.isNotEmpty) overMessage();
  }

  Future<void> _startRecording() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      AutoRouter.of(context).push(AuthorizationRoute());
      return;
    }
    setState(() {
      isVoiceRecorder = true;
      isVoiceMessage = true;
    });
    chatController.clear();
    try {
      recorder.startRecording();
    } catch (e) {
      print("Failed to start recording: $e");
      final snackBar = SnackBar(
        content: Text(
          S.of(context).notConnectMicrophone,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _stopRecording() async {

    print("Stopping recording");

    // Обновляем состояние
    setState(() {
      isVoiceRecorder = false;
    });
    Uint8List? bytes;
    try {
      // Останавливаем запись и получаем данные
      bytes = await recorder.stopRecording();
      print(bytes!.length);

      // Создаем модель файла
      final fileName =
          "${DateFormat("yyyy_MM_dd_HH_mm_ss").format(DateTime.now())}.wav";
      print(fileName);
      audioFile = FileModel(fileName, bytes);
      setState(() {});
      // Создаем Blob и File
      final blob = html.Blob([bytes], 'audio/wav'); // Указываем MIME-тип
      final file = html.File([blob], audioFile!.fileName);

      // Загружаем файл на сервер
      _uploadMedia(file, audioFile!.fileName).then((_) {
        // Отправляем сообщение (если нужно)
        _sendMessage();
      });
      print("File created and upload started");

    } catch (e) {
      print("Failed to stop recording: $e");
    }
  }

  Future<void> _onPressAttachBtn() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      AutoRouter.of(context).push(AuthorizationRoute());
      return;
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: S.of(context).chooseFile,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'gif'],
    );

    if (result != null && result.files.isNotEmpty) {
      // Получаем байты файла
      attachFile =
          FileModel(result.files.first.name, result.files.first.bytes!);
      if (attachFile != null) {
        setState(() {
          isFileAttach = true;
          // Создаем URL для отображения изображения
        });
        final blob = html.Blob([attachFile!.bytes]);
        final file = html.File([blob], attachFile!.fileName);
        _uploadMedia(file, attachFile!.fileName);
      }
    }
  }

  Future<void> _uploadMedia(html.File file, String fileName) async {
    setState(() {
      isUploadingMedia = true;
    });
    print(fileName);
    try {
      StreamedResponse response;
      if (fileName.endsWith(".wav")) {
        response = await mediaRepository.uploadFile(file, fileName);
      } else {
        response = await mediaRepository.uploadFile(file, fileName);
      }
      print("Upload response: ${response.statusCode}");
      print("Upload response: ${await response.stream.bytesToString()}");
      if (response.statusCode == 200) {
        setState(() {
          isUploadingMedia = false;
        });
      } else {
        setState(() {
          isUploadingMedia = false;
          isFileAttach = false;
        });
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                  title:
                      S.of(context).errorUploadingFilePleaseTryAgain);
            });
      }
    } catch (e) {
      setState(() {
        isUploadingMedia = false;
        isFileAttach = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(
                title: S.of(context).errorUploadingFilePleaseTryAgain);
          });
    }
  }

  @override
  Scaffold build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.png"), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Align(
              alignment: _chatHistory.messages.isEmpty ? Alignment.topCenter : Alignment.bottomCenter,
              child: _chatHistory.messages.isEmpty
                  ? CenterMainLogo(combination: combination)
                  : CenterChat(
                      chatScrollController: chatScrollController,
                      messages: _chatHistory.messages,
                    ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: 300,
                width: screenWidth,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child:
                  SingleChildScrollView(
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 800,
                        minWidth: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (!isFileAttach) Transform.translate(
                            offset: const Offset(0, 10),
                            child: isVoiceRecorder
                                ? IconButton(
                                onPressed: cancelVoiceRecorder,
                                icon: SvgPicture.asset(
                                  "assets/svg/trash.svg",
                                  alignment: Alignment.center,
                                  width: 30,
                                  height: 30,
                                ))
                                : IconButton(
                                onPressed: _onPressAttachBtn,
                                icon: SvgPicture.asset(
                                  "assets/svg/attach_icon.svg",
                                  alignment: Alignment.center,
                                  width: 30,
                                  height: 30,
                                )),
                          ),
                          Expanded(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                FormFieldTypeTwo(
                                  controller: chatController,
                                  hintText: S.of(context).inputTextForSearch,
                                  maxLines: 5,
                                  minLines: 1,
                                  onFieldSubmitted: _sendMessage,
                                  onChanged: () async {
                                    setState(() {});
                                  },
                                  listTile: isFileAttach
                                      ? ListTile(
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          attachFile?.fileName ?? S.of(context).noFileSelected,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          attachFile != null
                                              ? FormatterText.formatFileSize(attachFile!.bytes.length)
                                              : S.of(context).noFileSelected,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    titleAlignment: ListTileTitleAlignment.top,
                                    leading: SizedBox(
                                      width: screenWidth > 500 ? 100 : 50,
                                      height: screenWidth > 500 ? 100 : 50,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.memory(
                                          attachFile!.bytes,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          attachFile = null; // Очищаем файл
                                          isFileAttach = false;
                                        });
                                      },
                                      icon: SvgPicture.asset("assets/svg/trash.svg"),
                                    ),
                                  )
                                      : Container(),
                                  isViewTile: isFileAttach,
                                  isVoiceRecorder: isVoiceRecorder,
                                ),
                                Positioned(
                                  right: 10,
                                  bottom: 5,
                                  child: chatController.text.isEmpty
                                      ? const SizedBox(
                                    width: 0,
                                    height: 0,
                                  )
                                      : IconButton(
                                      onPressed: _sendMessage,
                                      icon: SvgPicture.asset(
                                        "assets/svg/send_message.svg",
                                        alignment: Alignment.center,
                                        width: 25,
                                        height: 25,
                                      )),
                                )
                              ],
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(0, 10),
                            child: GestureDetector(
                              onLongPressStart: (_) async {
                                setState(() {
                                  if (!isVoiceRecorder) _startRecording();
                                });
                              },
                              child: isVoiceRecorder
                                  ? IconButton(
                                  onPressed: _stopRecording,
                                  icon: SvgPicture.asset(
                                    "assets/svg/send_message.svg",
                                    alignment: Alignment.center,
                                    width: 30,
                                    height: 30,
                                  ))
                                  : IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    "assets/svg/microphone.svg",
                                    alignment: Alignment.center,
                                    width: 30,
                                    height: 30,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xffF1F7FC),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 1,
                    )
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.only(left: isMenuVisible ? 300 : 0),
                      child: screenWidth > 500 ? Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 10,
                        children: [
                          GestureDetector(
                              onTap: () {
                                isMenuVisible = !isMenuVisible;
                                setState(() {});
                              },
                              child: const MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: SvgIcons(
                                      path: "assets/svg/menu.svg",
                                      size: 50))),
                          if (!(screenWidth < 700 && isMenuVisible))
                            SizedBox(
                              height: 50,
                              child: TextButtonTypeTwoGradient(
                                  text: S.of(context).home,
                                  onPressed: () {
                                    AutoRouter.of(context).push(const WelcomeRoute());
                                  }),
                            ),
                        ],
                      ) :  (!isMenuVisible)  ? Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: GestureDetector(
                          onTap: () {
                            AutoRouter.of(context).push(const WelcomeRoute());
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: SvgPicture.asset(
                              "assets/logo/title_logo.svg",
                              height: screenWidth < 600?  50: 70,
                            ),
                          ),
                        ),
                      ) : null,
                    ),
                    screenWidth > 500 ?
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        // spacing: 20,
                        children: [
                          IconButton(onPressed: () {

                            AutoRouter.of(context)
                                .push(const ProfileRoute());
                          }, icon: const SvgIcons(
                              path: "assets/svg/profile_icon.svg",
                              size: 40), style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),),
                          LanguageSelector(),
                        ],
                      ) : Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: IconButton(onPressed: () {
                          setState(() {
                            isRightMenuVisible = !isRightMenuVisible;
                          });
                        }, icon: SvgPicture.asset(
                          "assets/svg/title_menu.svg",
                          height: 50,
                        ), style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),),

                      ),
                    // const SizedBox(width: 10,)
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: isMenuVisible ? 0 : -300,
              top: 0,
              bottom: 0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  HomeSideBar(
                    isExpanded: isExpanded,
                    onSelectChat: onSelectChat,
                    isHomeRoute: true,
                  ),
                  if (isMenuVisible)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isMenuVisible = !isMenuVisible;
                        });
                      },
                      child: Container(
                        width: screenWidth,
                        height: screenHeight - 70,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              right: !isRightMenuVisible ? -300 : 0,
              top: 0,
              bottom: 0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // if (isMenuVisible)
                  if (isRightMenuVisible) GestureDetector(
                    onTap: () {
                      setState(() {
                        isRightMenuVisible = !isRightMenuVisible;
                      });
                    },
                    child: Container(
                      width: screenWidth,
                      height: screenHeight,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                  SideBar(scrollController: _mainScrollController,
                      isVisible: isRightMenuVisible, onSelectChat: onSelectChat),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
