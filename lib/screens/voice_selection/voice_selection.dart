import 'package:auto_route/auto_route.dart';
import 'package:ed_helper_web/common/widgets/card/voice_select_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../../util/constants/app_colors.dart';

@RoutePage()
class VoiceSelectionScreen extends StatefulWidget {
  const VoiceSelectionScreen({super.key});

  @override
  State<VoiceSelectionScreen> createState() => _VoiceSelectionScreenState();
}

class _VoiceSelectionScreenState extends State<VoiceSelectionScreen> {
  ScrollController scrollController = ScrollController();
  String nowVoiceTitle = "Нет озвучки";
  List<String> voices = [
    "alloy",
    "ash",
    "coral",
    "echo",
    "fable",
    "onyx",
    "nova",
    "sage",
    "shimmer"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDependencies();
  }

  Future<void> initDependencies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    nowVoiceTitle = prefs.getString("voice") ?? "Нет озвучки";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: AppColors.backgroundScreen),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Stack(
                children: [
                  Container(
                    height: 500,
                    width: 500,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/logo_background_1.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 600,
                    width: 600,
                    // color: AppColors.backgroundScreen.withOpacity(0.95),
                  ),
                ],
              ),
            ),
            Positioned(
              right: -100,
              bottom: -100,
              child: Stack(
                children: [
                  Container(
                    height: 500,
                    width: 500,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/logo_background_2.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: screenWidth,
                height: screenHeight,
                color: AppColors.backgroundScreen.withOpacity(0.95),
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    'assets/svg/arrow_back.svg',
                    width: 70,
                    height: 70,
                  ),
                )),
            Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  S.of(context).voiceSelection,
                  style: GoogleFonts.montserrat(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                    width: screenWidth < 900 ? 600 : 800,
                    child: Scrollbar(
                      controller: scrollController,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: scrollController,
                        child: Row(children: [
                          Container(
                            width: screenWidth < 900 ? 220 : 320,
                            height: screenWidth < 900 ? 160 : 260,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.cardBorder, width: 2),
                              borderRadius: BorderRadius.circular(30),
                              color: AppColors.cardBackground,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  nowVoiceTitle,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              // Добавляем карточку "Нет озвучки", если текущий голос не равен "Нет озвучки"
                              if (nowVoiceTitle != "Нет озвучки")
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () async {

                                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                                          prefs.remove("voice");
                                          setState(() {
                                            nowVoiceTitle = "Нет озвучки";
                                          });
                                        },
                                        child: const VoiceSelectCard(
                                          title: "Нет озвучки",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),

                              // Список голосов
                              ...voices.map((voice) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () async {

                                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                                          prefs.setString("voice", voice);
                                          setState(() {
                                            nowVoiceTitle = voice;
                                          });
                                        },
                                        child: VoiceSelectCard(title: voice),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        ]),
                      ),
                    ))
              ],
            )),
          ],
        ),
      ),
    );
  }
}
