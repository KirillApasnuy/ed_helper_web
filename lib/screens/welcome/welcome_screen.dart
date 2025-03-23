import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:ed_helper_web/common/widgets/app_widgets/language_selector.dart';
import 'package:ed_helper_web/common/widgets/button/autowired_button.dart';
import 'package:ed_helper_web/common/widgets/button/text_button_type_one.dart';
import 'package:ed_helper_web/data/services/user_service.dart';
import 'package:ed_helper_web/screens/welcome/widgets/ai_assistant.dart';
import 'package:ed_helper_web/screens/welcome/widgets/background_logos.dart';
import 'package:ed_helper_web/screens/welcome/widgets/chat_card.dart';
import 'package:ed_helper_web/screens/welcome/widgets/preferens_card.dart';
import 'package:ed_helper_web/screens/welcome/widgets/preferens_featers_card.dart';
import 'package:ed_helper_web/screens/welcome/widgets/question_card.dart';
import 'package:ed_helper_web/screens/welcome/widgets/review_card.dart';
import 'package:ed_helper_web/screens/welcome/widgets/text_prog_card.dart';
import 'package:ed_helper_web/util/constants/app_colors.dart';
import 'package:ed_helper_web/util/constants/welcome_screen_lists.dart';
import 'package:ed_helper_web/util/routes/router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../common/widgets/app_widgets/dot_indicator.dart';
import '../../common/widgets/button/text_button_type_one_gradient.dart';
import '../../common/widgets/button/text_button_type_two_gradient.dart';
import '../../common/widgets/dialog/error_dialog.dart';
import '../../common/widgets/form_fields/form_field_type_two.dart';
import '../../common/widgets/pictures/svg_icons.dart';
import '../../data/models/chat_message/chat_message.dart';
import '../../data/models/chat_message/file_model.dart';
import '../../data/repositories/ed_helper/media_repository.dart';
import '../../generated/l10n.dart';
import '../../util/device/web_audio_recorder.dart';
import '../../util/formatters/formatter_text.dart';
import 'widgets/side_bar.dart';

@RoutePage()
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _mainScrollController = ScrollController();
  final recorder = WebAudioRecorder();
  final chatScrollController = ScrollController();
  final UserService userService = UserService();
  TextEditingController chatController = TextEditingController();
  late Timer _timer;
  late VideoPlayerController _controller;
  final mediaRepository = MediaRepository();
  int _currentIndex = 0;
  bool isFileAttach = false;
  FileModel? attachFile;
  FileModel? audioFile;
  bool isMenuVisible = false;
  bool isVoiceMessage = false;
  bool value = false;
  bool isExpanded = true;
  bool isChats = false;
  bool isVoiceRecorder = false;
  bool isChangeCursor = false;
  bool isUploadingMedia = false;
  bool _isPlaying = false;
  bool _showPlayButton = true;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _initialize();
    _scrollController.addListener(() {
      final pageIndex =
          (_scrollController.offset / MediaQuery.of(context).size.width)
              .round();
      if (pageIndex != _currentIndex) {
        setState(() {
          _currentIndex = pageIndex;
        });
      }
    });
    _controller = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4")
      ..initialize().then((_) {
        // После инициализации обновляем состояние, чтобы отобразить первый кадр
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _timer.cancel();
    super.dispose();
  }
  void _initialize() async {
    print("Starting verification");
    if (!(await _verifyAuth())) {
      try {
        userService.newUserWithIp();
      } on Exception catch (e) {
        print(e);
      }
      print("Verified");
    }
  }
  Future<bool> _verifyAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);
    if (token == null || token == "") {
      return false;
    }
    return true;
  }

  Future<void> _startRecording() async {
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

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: "Выберите файл",
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
              return const ErrorDialog(
                  title:
                      "Ошибка выгрузки медиафайла на сервер. Попробуйте еще раз.");
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
            return const ErrorDialog(
                title: "Ошибка выгрузки медиафайла. Попробуйте еще раз.");
          });
    }
  }

  void cancelVoiceRecorder() {
    setState(() {
      isVoiceRecorder = false;
    });
    recorder.stopRecording();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (_currentIndex < 2) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _scrollToPage(_currentIndex);
    });
  }

  void _scrollToPage(int index) {
    _scrollController.animateTo(
      index * MediaQuery.of(context).size.width,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onDotTapped(int index) {
    _scrollToPage(index);
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _mainScrollController,
            child: Container(
              padding: const EdgeInsets.only(top: 90),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xffEFFEF5),
                  Color(0xffd0e6fb),
                  Color(0xffDFEBFF),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              constraints: BoxConstraints(
                  minHeight: screenHeight, minWidth: screenWidth),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  const BackgroundLogos(),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth < 600 ? 10 : 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth < 600 ? 0 : 20,
                              vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    runAlignment: WrapAlignment.start,
                                    children: [
                                      const AiAssistant(),
                                      Text(
                                        S.of(context).forWorkingWith,
                                        style: GoogleFonts.geologica(
                                            fontSize:
                                                screenWidth > 900 ? 45 : 30,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        S
                                            .of(context)
                                            .neuralNetworksAndAdvancedSoftware,
                                        style: GoogleFonts.geologica(
                                            fontSize:
                                                screenWidth > 900 ? 45 : 30,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ]),
                              ),
                              const SizedBox(height: 30),
                              ChatCard(
                                  isViewLogo: false,
                                  child: Flexible(
                                    child: Column(
                                      children: [
                                        Text(
                                          S.of(context).hiThereMyNameIsEd,
                                          style: GoogleFonts.geologica(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 800),
                                          child: Text(
                                            S
                                                .of(context)
                                                .askMeAnythingAboutComplexSoftwareAndNeuralNetworksillHelp,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 10,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.geologica(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 50),
                                        SingleChildScrollView(
                                          child: Container(
                                            constraints: const BoxConstraints(
                                              maxWidth: 800,
                                              minWidth: 0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                if (!isFileAttach)
                                                  Transform.translate(
                                                    offset: const Offset(0, 10),
                                                    child: isVoiceRecorder
                                                        ? IconButton(
                                                            onPressed:
                                                                cancelVoiceRecorder,
                                                            icon: SvgPicture
                                                                .asset(
                                                              "assets/svg/trash.svg",
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 30,
                                                              height: 30,
                                                            ))
                                                        : IconButton(
                                                            onPressed:
                                                                _onPressAttachBtn,
                                                            icon: SvgPicture
                                                                .asset(
                                                              "assets/svg/attach_icon.svg",
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 30,
                                                              height: 30,
                                                            )),
                                                  ),
                                                Expanded(
                                                  child: Stack(
                                                    children: [
                                                      FormFieldTypeTwo(
                                                        controller:
                                                            chatController,
                                                        hintText: S
                                                            .of(context)
                                                            .inputTextForSearch,
                                                        maxLines: 5,
                                                        minLines: 3,
                                                        onFieldSubmitted:
                                                            _sendMessage,
                                                        onChanged: () async {
                                                          setState(() {});
                                                        },
                                                        listTile: isFileAttach
                                                            ? ListTile(
                                                                title: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      attachFile
                                                                              ?.fileName ??
                                                                          S.of(context).noFileSelected,
                                                                      style: GoogleFonts.montserrat(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    Text(
                                                                      attachFile !=
                                                                              null
                                                                          ? FormatterText.formatFileSize(attachFile!
                                                                              .bytes
                                                                              .length)
                                                                          : S
                                                                              .of(context)
                                                                              .noFileSelected,
                                                                      style: GoogleFonts.montserrat(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  ],
                                                                ),
                                                                titleAlignment:
                                                                    ListTileTitleAlignment
                                                                        .top,
                                                                leading:
                                                                    SizedBox(
                                                                  width:
                                                                      screenWidth >
                                                                              500
                                                                          ? 100
                                                                          : 50,
                                                                  height:
                                                                      screenWidth >
                                                                              500
                                                                          ? 100
                                                                          : 50,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    child: Image
                                                                        .memory(
                                                                      attachFile!
                                                                          .bytes,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      attachFile =
                                                                          null; // Очищаем файл
                                                                      isFileAttach =
                                                                          false;
                                                                    });
                                                                  },
                                                                  icon: SvgPicture
                                                                      .asset(
                                                                          "assets/svg/trash.svg"),
                                                                ),
                                                              )
                                                            : Container(),
                                                        isViewTile:
                                                            isFileAttach,
                                                        isVoiceRecorder:
                                                            isVoiceRecorder,
                                                      ),
                                                      Positioned(
                                                        right: 10,
                                                        bottom: 5,
                                                        child: chatController
                                                                .text.isEmpty
                                                            ? const SizedBox(
                                                                width: 0,
                                                                height: 0,
                                                              )
                                                            : IconButton(
                                                                onPressed:
                                                                    _sendMessage,
                                                                icon: SvgPicture
                                                                    .asset(
                                                                  "assets/svg/send_message.svg",
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
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
                                                    onLongPressStart:
                                                        (_) async {
                                                      setState(() {
                                                        if (!isVoiceRecorder)
                                                          _startRecording();
                                                      });
                                                    },
                                                    child: isVoiceRecorder
                                                        ? IconButton(
                                                            onPressed:
                                                                _stopRecording,
                                                            icon: SvgPicture
                                                                .asset(
                                                              "assets/svg/send_message.svg",
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 30,
                                                              height: 30,
                                                            ))
                                                        : IconButton(
                                                            onPressed: () {},
                                                            icon: SvgPicture
                                                                .asset(
                                                              "assets/svg/microphone.svg",
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 30,
                                                              height: 30,
                                                            )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 1000),
                                          child: Wrap(
                                            direction: Axis.horizontal,
                                            alignment: WrapAlignment.center,
                                            children: WelcomeScreenLists()
                                                .buttonTitles()
                                                .map((title) {
                                              return AutowiredButton(
                                                onPressed: (text) {
                                                  chatController.text = text;
                                                  setState(() {});
                                                },
                                                title: title,
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(height: 90),
                              Row(children: [
                                Text(
                                  S.of(context).edHelperFeatures,
                                  style: GoogleFonts.geologica(
                                      fontSize: screenWidth > 900 ? 40 : 25,
                                      fontWeight: FontWeight.w400),
                                ),
                              ]),
                              const SizedBox(height: 30),
                              Center(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: screenWidth < 600 ? 10 : 16,
                                  runSpacing: screenWidth < 600 ? 10 : 16,
                                  children: WelcomeScreenLists()
                                      .features()
                                      .map((cardModel) {
                                    return PreferensFeatersCard(
                                        cardModel: cardModel);
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(height: 30),
                              PreferensCard(
                                  child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgIcons(
                                          path: "assets/svg/computer.svg",
                                          size: screenWidth < 600 ? 70 : 110),
                                    ],
                                  ),
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      Text(
                                          S
                                              .of(context)
                                              .straighttothepointInstructionsOnlyPreciseStepsForWorkingWithComplexSoftware,
                                          textAlign: TextAlign.center,
                                          maxLines: 10,
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18)),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  Container(
                                    constraints:
                                        const BoxConstraints(maxWidth: 1000),
                                    child: Wrap(
                                      spacing: screenWidth < 600 ? 10 : 16,
                                      runSpacing: screenWidth < 600 ? 10 : 16,
                                      direction: Axis.horizontal,
                                      alignment: WrapAlignment.center,
                                      children: WelcomeScreenLists.appTitles
                                          .map((title) {
                                        return TextProgCard(text: title);
                                      }).toList(),
                                    ),
                                  )
                                ],
                              )),
                              const SizedBox(height: 30),
                              PreferensCard(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgIcons(
                                            path: "assets/svg/brain.svg",
                                            size: screenWidth < 600 ? 70 : 110),
                                      ],
                                    ),
                                    Container(
                                        constraints: const BoxConstraints(
                                            maxWidth: 1050),
                                        width: screenWidth > 1050 ? 1050 : null,
                                        child: Text(
                                            S
                                                .of(context)
                                                .assistanceInTrainingAVarietyOfNeuralNetworksAvailableOn,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18))),
                                    const SizedBox(height: 30),
                                    Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 1000),
                                      child: Wrap(
                                        spacing: screenWidth < 600 ? 10 : 16,
                                        runSpacing: screenWidth < 600 ? 10 : 16,
                                        direction: Axis.horizontal,
                                        alignment: WrapAlignment.center,
                                        children: WelcomeScreenLists.aiNames
                                            .map((title) {
                                          return TextProgCard(text: title);
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              Center(
                                child: Container(
                                  height: 50,
                                  constraints: const BoxConstraints(
                                    maxWidth: 350,
                                  ),
                                  child: TextButtonTypeOne(
                                    mainAxisSize: MainAxisSize.min,
                                    text: S.of(context).downloadApp,
                                    onPressed: () {},
                                    suffix: const SvgIcons(
                                        path: "assets/logo/windows.svg",
                                        size: 20),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    screenWidth < 1000
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 15),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                              border: Border.all(
                                                  color: Colors.blue
                                                      .withOpacity(0.5),
                                                  width: 3),
                                            ),
                                            child: Wrap(
                                              children: [
                                                Text(
                                                    S.of(context).learnHowToUse,
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.blue
                                                                .withOpacity(
                                                                    0.5))),
                                              ],
                                            ),
                                          )
                                        : SvgPicture.asset(
                                            "assets/svg/video_part.svg"),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              MouseRegion(
                                onEnter: (_) =>
                                    setState(() => _showPlayButton = true),
                                onExit: (_) =>
                                    setState(() => _showPlayButton = false),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      if (_controller.value.isInitialized)
                                        AspectRatio(
                                          aspectRatio:
                                              _controller.value.aspectRatio,
                                          child: VideoPlayer(_controller),
                                        )
                                      else
                                        CircularProgressIndicator(
                                          color: AppColors.cardBorder,
                                        ),
                                      Visibility(
                                        visible: _showPlayButton ||
                                            !_controller.value.isPlaying,
                                        child: IconButton(
                                          color: const Color(0xff77ADED),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff77ADED),
                                          ),
                                          icon: SizedBox(
                                            width: screenWidth < 500 ? 45 : 100,
                                            height:
                                                screenWidth < 500 ? 45 : 100,
                                            child: Icon(
                                              _controller.value.isPlaying
                                                  ? Iconsax.pause_circle5
                                                  : Iconsax.play_cricle5,
                                              size: screenWidth < 500 ? 40 : 80,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: _togglePlayPause,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 60),
                              Row(children: [
                                Text(
                                  S.of(context).customersReviews,
                                  style: GoogleFonts.geologica(
                                      fontSize: screenWidth > 900 ? 40 : 25,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                              const SizedBox(height: 30),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller: _scrollController,
                                child: Row(
                                  children: WelcomeScreenLists()
                                      .reviews()
                                      .map((review) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: ReviewCard(reviews: review),
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(height: 20),
                              DotIndicator(
                                itemCount:
                                    WelcomeScreenLists().reviews().length,
                                currentIndex: _currentIndex,
                                onDotTapped: _onDotTapped,
                              ),
                              const SizedBox(height: 60),
                              Row(children: [
                                Text(
                                  S.of(context).contacts,
                                  style: GoogleFonts.geologica(
                                      fontSize: screenWidth > 900 ? 40 : 25,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                              const SizedBox(height: 30),
                              const QuestionCard(),
                              const SizedBox(height: 100),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _mainScrollController.animateTo(0,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeOut);
                                    },
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: SvgPicture.asset(
                                        "assets/logo/title_logo.svg",
                                        height: screenWidth < 600 ? 50 : 70,
                                      ),
                                    ),
                                  ),
                                  Text(
                                      "©${DateTime.now().year} ${S.of(context).allRightsResevered}",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: const Color(0xff1C54B5))),
                                ],
                              ),
                              const SizedBox(height: 100),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 70,
              margin: EdgeInsets.symmetric(
                  vertical: 10, horizontal: screenWidth < 600 ? 5 : 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.boxTitleFill,
                border: Border.all(color: AppColors.boxTitleBorder, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(60)),
              ),
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _mainScrollController.animateTo(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut);
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: SvgPicture.asset(
                        "assets/logo/title_logo.svg",
                        height: 50,
                      ),
                    ),
                  ),
                  screenWidth > 600
                      ? Row(mainAxisSize: MainAxisSize.min, children: [
                          SizedBox(
                            height: 55,
                            child: TextButtonTypeOneGradient(
                                text: S.of(context).home,
                                onPressed: () {
                                  _mainScrollController.animateTo(0,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeOut);
                                }),
                          ),
                          SizedBox(
                            height: 55,
                            child: TextButtonTypeTwoGradient(
                                text: S.of(context).chat,
                                backgroundColor: Colors.transparent,
                                onPressed: () {
                                  AutoRouter.of(context).push(HomeRoute());
                                }),
                          ),
                          GestureDetector(
                            onTap: () {
                              AutoRouter.of(context).push(const ProfileRoute());
                            },
                            child: const MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: SvgIcons(
                                  path: "assets/svg/profile_icon.svg",
                                  size: 40),
                            ),
                          ),
                          LanguageSelector(),
                        ])
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              isMenuVisible = !isMenuVisible;
                              print(isMenuVisible);
                            });
                          },
                          child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: SvgPicture.asset(
                                "assets/svg/title_menu.svg",
                                height: 40,
                              )),
                        ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            right: !isMenuVisible ? -300 : 0,
            top: 0,
            bottom: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // if (isMenuVisible)
                if (isMenuVisible)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMenuVisible = !isMenuVisible;
                      });
                    },
                    child: Container(
                      width: screenWidth,
                      height: screenHeight,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                SideBar(
                    scrollController: _mainScrollController,
                    isVisible: isMenuVisible),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    ChatMessage message = ChatMessage(
      timestamp: DateTime.now(),
      text: chatController.text,
      user: true,
      audioFile: audioFile,
      attachFile: attachFile,
    );
    AutoRouter.of(context).push(HomeRoute(message: message));
    setState(() {
      isFileAttach = false;
      isVoiceMessage = false;
    });
    chatController.clear();
  }
}
