import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:ed_helper_web/common/widgets/dialog/done_dialog.dart';
import 'package:ed_helper_web/common/widgets/dialog/error_dialog.dart';
import 'package:ed_helper_web/common/widgets/form_fields/form_field_type_two.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/question_repository.dart';
import 'package:ed_helper_web/util/device/validation_service.dart';
import 'package:ed_helper_web/util/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/widgets/button/text_button_type_one.dart';
import '../../../generated/l10n.dart';
import '../../../util/constants/app_colors.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({super.key});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  final TextEditingController questionController = TextEditingController();
  final QuestionRepository _questionRepository = QuestionRepository();

  void sendQuestion() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("token") ?? "";
    if (authToken.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            title: S.of(context).youNeedToBeLoggedInToSendAQuestion,);
        }
      );
      Future.delayed(const Duration(seconds: 3), () {
        AutoRouter.of(context).popAndPush(AuthorizationRoute());
      });
    }
    if (questionController.text.isNotEmpty) {
      Response response = await _questionRepository.createQuestion(questionController.text);
      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) {
            return DoneDialog(
              title: S.of(context).questionSentSuccessfully,);
      });
    } else {
        showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(
              title: S.of(context).errorSendingQuestion,);
          });
      }
      }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        margin: EdgeInsets.all(screenWidth < 600 ? 0: 15.0),
        constraints: const BoxConstraints(minWidth: 320, maxWidth: 1200),
        padding: EdgeInsets.all(screenWidth < 600 ? 15: screenWidth < 900 ? 30 : 50),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          border: Border.all(color: AppColors.cardBorder, width: 2),
          color: AppColors.cardBackground,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 1,
            )
          ],
        ),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          direction: Axis.horizontal,
          runSpacing: 30,
          spacing: 70,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    S.of(context).haveQuestions,
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      border: Border.all(
                        color: const Color(0xff1C54B5),
                        width: 2,
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 20,
                    children: [
                      // Text(
                      //   S.of(context).support,
                      //   style: GoogleFonts.montserrat(
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.w600,
                      //       color: const Color(0xff1C54B5)),
                      // ),
                      // const SizedBox(height: 20),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        height: 200,
                        child: FormFieldTypeTwo(
                          controller: questionController,
                          hintText: S.of(context).enterYourApplicationText,
                          maxLines: 7,
                          minLines: 7,
                          isVoiceRecorder: false,
                          onFieldSubmitted: sendQuestion,
                          isViewTile: false,
                          validator: ValidationService().validateEmpty,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              constraints: const BoxConstraints(maxWidth: 190),
                              height: 48,
                              child: TextButtonTypeOne(
                                  text: S.of(context).send, onPressed: sendQuestion)),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Email",
                  style: GoogleFonts.montserrat(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: _sendEmail,
                  child: Text(
                    "Support@ED-helper.ai",
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff1C54B5)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  S.of(context).socialNetworks,
                  style: GoogleFonts.montserrat(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 15,
                  children: [
                    IconButton(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            side: BorderSide(
                              color: Color(0xff1C54B5),
                            )),
                        foregroundColor: const Color(0xff1C54B5),
                        backgroundColor: Colors.white,
                      ),
                      icon: SizedBox(
                        width: 34,
                        child: SvgPicture.asset(
                          "assets/logo/telegram_blue.svg",
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            side: BorderSide(
                              color: Color(0xff1C54B5),
                            )),
                        foregroundColor: const Color(0xff1C54B5),
                        backgroundColor: Colors.white,
                      ),
                      icon: SizedBox(
                        width: 34,
                        child: SvgPicture.asset(
                          "assets/svg/discord.svg",
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            side: BorderSide(
                              color: Color(0xff1C54B5),
                            )),
                        foregroundColor: const Color(0xff1C54B5),
                        backgroundColor: Colors.white,
                      ),
                      icon: SizedBox(
                        width: 34,
                        child: SvgPicture.asset(
                          "assets/logo/instagram_blue.svg",
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _sendEmail,
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            side: BorderSide(
                              color: Color(0xff1C54B5),
                            )),
                        foregroundColor: const Color(0xff1C54B5),
                        backgroundColor: Colors.white,
                      ),
                      icon: SizedBox(
                        width: 34,
                        child: SvgPicture.asset(
                          "assets/svg/x.svg",
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ));
  }

  void _sendEmail() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'Support@ED-helper.ai',
    );

    print('Attempting to launch: ${emailLaunchUri.toString()}'); // Логирование

    launchUrl(emailLaunchUri);
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}

class _PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    String cleanedText = newText;

    // Если текст сокращается (удаление), не навязываем старое значение
    if (newText.length <
        oldValue.text.replaceAll(RegExp(r'[^\d]'), '').length) {
      cleanedText = newText;
    }

    // Если длина текста больше 10 цифр, обрезаем
    if (cleanedText.length > 11) {
      cleanedText = cleanedText.substring(0, 11);
    }

    // Проверяем, начинается ли номер с 7 или 8
    final startsWith7 = cleanedText.startsWith('7');
    final startsWith8 = cleanedText.startsWith('8');

    final formattedText = StringBuffer();

    // Добавляем +7, если номер не начинается с 7 или 8
    if (!startsWith7 && !startsWith8 && cleanedText.isNotEmpty) {
      formattedText.write('+7 ');
    } else if (startsWith7 || startsWith8) {
      formattedText.write('+7 ');
      cleanedText = cleanedText.substring(1);
    }

    // Форматируем оставшиеся цифры
    if (cleanedText.isNotEmpty) {
      if (cleanedText.length > 3) {
        formattedText.write('(${cleanedText.substring(0, 3)}) ');
        if (cleanedText.length > 6) {
          formattedText.write('${cleanedText.substring(3, 6)} - ');
          if (cleanedText.length > 8) {
            formattedText.write('${cleanedText.substring(6, 8)} - ');
            formattedText.write(cleanedText.substring(8));
          } else {
            formattedText.write(cleanedText.substring(6));
          }
        } else {
          formattedText.write(cleanedText.substring(3));
        }
      } else {
        formattedText.write(cleanedText);
      }
    }

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
