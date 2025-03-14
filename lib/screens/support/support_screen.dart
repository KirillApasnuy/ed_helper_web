import 'package:auto_route/auto_route.dart';
import 'package:ed_helper_web/common/widgets/button/text_button_type_one.dart';
import 'package:ed_helper_web/common/widgets/form_fields/form_field_type_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/l10n.dart';
import '../../util/constants/app_colors.dart';

@RoutePage()
class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    TextEditingController _numberController = TextEditingController();
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
                    color: AppColors.backgroundScreen.withOpacity(0.95),
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
                  Container(
                    height: 600,
                    width: 600,
                    color: AppColors.backgroundScreen.withOpacity(0.95),
                  ),
                ],
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
              children: [
                Text(
                  S.of(context).support,
                  style: GoogleFonts.montserrat(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Container(
                    margin: const EdgeInsets.all(15.0),
                    width: screenWidth < 1000 ? 600 : 1000,
                    constraints: const BoxConstraints(
                      minWidth: 320,
                    ),
                    padding: EdgeInsets.all(screenWidth < 900 ? 20 : 50),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      border: Border.all(color: AppColors.cardBorder, width: 2),
                      color: AppColors.cardBackground,
                    ),
                    child: screenWidth < 1000
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).warningWithCanceledSubscribe,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 500,
                                    height: 150,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        border: Border.all(
                                          color: const Color(0xff1C54B5),
                                          width: 2,
                                        )),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).support,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xff1C54B5)),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 250,
                                              child: FormFieldTypeOne(
                                                controller: _numberController,
                                                hintText:
                                                    "+7 (_ _ _) - _ _ - _ _",
                                                inputFormatters: [
                                                  _PhoneNumberInputFormatter(),
                                                  LengthLimitingTextInputFormatter(
                                                      23)
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Transform.translate(
                                              offset: const Offset(0, 5),
                                              child: SizedBox(
                                                  width: 190,
                                                  height: 48,
                                                  child: TextButtonTypeOne(
                                                      text: S.of(context).send,
                                                      onPressed: () {})),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 500,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Email",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SelectableText(
                                      "Support@ED-helper.ai",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff1C54B5)),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Text(
                                      S.of(context).socialNetworks,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          onPressed: () => {},
                                          style: ElevatedButton.styleFrom(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                side: BorderSide(
                                                  color: Color(0xff1C54B5),
                                                )),
                                            foregroundColor:
                                                const Color(0xff1C54B5),
                                            backgroundColor: Colors.white,
                                          ),
                                          icon: SizedBox(
                                            width: 34,
                                            child: SvgPicture.asset(
                                              "assets/logo/telegram_blue.svg",
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 14,
                                        ),
                                        IconButton(
                                          onPressed: () => {},
                                          style: ElevatedButton.styleFrom(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                side: BorderSide(
                                                  color: Color(0xff1C54B5),
                                                )),
                                            foregroundColor:
                                                const Color(0xff1C54B5),
                                            backgroundColor: Colors.white,
                                          ),
                                          icon: SizedBox(
                                            width: 34,
                                            child: SvgPicture.asset(
                                              "assets/logo/watsapp_blue.svg",
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 14,
                                        ),
                                        IconButton(
                                          onPressed: () => {},
                                          style: ElevatedButton.styleFrom(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                side: BorderSide(
                                                  color: Color(0xff1C54B5),
                                                )),
                                            foregroundColor:
                                                const Color(0xff1C54B5),
                                            backgroundColor: Colors.white,
                                          ),
                                          icon: SizedBox(
                                            width: 34,
                                            child: SvgPicture.asset(
                                              "assets/logo/vk_blue.svg",
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 14,
                                        ),
                                        IconButton(
                                          onPressed: () => {},
                                          style: ElevatedButton.styleFrom(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                side: BorderSide(
                                                  color: Color(0xff1C54B5),
                                                )),
                                            foregroundColor:
                                                const Color(0xff1C54B5),
                                            backgroundColor: Colors.white,
                                          ),
                                          icon: SizedBox(
                                            width: 34,
                                            child: SvgPicture.asset(
                                              "assets/logo/instagram_blue.svg",
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).haveQuestions,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 500,
                                    height: 150,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        border: Border.all(
                                          color: const Color(0xff1C54B5),
                                          width: 2,
                                        )),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).support,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xff1C54B5)),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 250,
                                              child: FormFieldTypeOne(
                                                controller: _numberController,
                                                hintText:
                                                    "+7 (_ _ _) - _ _ - _ _",
                                                inputFormatters: [
                                                  _PhoneNumberInputFormatter(),
                                                  LengthLimitingTextInputFormatter(
                                                      23)
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Transform.translate(
                                              offset: const Offset(0, 5),
                                              child: SizedBox(
                                                  width: 190,
                                                  height: 48,
                                                  child: TextButtonTypeOne(
                                                      text: S.of(context).send,
                                                      onPressed: () {})),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Support@ED-helper.ai",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff1C54B5)),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    S.of(context).socialNetworks,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () => {},
                                        style: ElevatedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              side: BorderSide(
                                                color: Color(0xff1C54B5),
                                              )),
                                          foregroundColor:
                                              const Color(0xff1C54B5),
                                          backgroundColor: Colors.white,
                                        ),
                                        icon: SizedBox(
                                          width: 34,
                                          child: SvgPicture.asset(
                                            "assets/logo/telegram_blue.svg",
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 14,
                                      ),
                                      IconButton(
                                        onPressed: () => {},
                                        style: ElevatedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              side: BorderSide(
                                                color: Color(0xff1C54B5),
                                              )),
                                          foregroundColor:
                                              const Color(0xff1C54B5),
                                          backgroundColor: Colors.white,
                                        ),
                                        icon: SizedBox(
                                          width: 34,
                                          child: SvgPicture.asset(
                                            "assets/logo/watsapp_blue.svg",
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 14,
                                      ),
                                      IconButton(
                                        onPressed: () => {},
                                        style: ElevatedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              side: BorderSide(
                                                color: Color(0xff1C54B5),
                                              )),
                                          foregroundColor:
                                              const Color(0xff1C54B5),
                                          backgroundColor: Colors.white,
                                        ),
                                        icon: SizedBox(
                                          width: 34,
                                          child: SvgPicture.asset(
                                            "assets/logo/vk_blue.svg",
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 14,
                                      ),
                                      IconButton(
                                        onPressed: () => {},
                                        style: ElevatedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              side: BorderSide(
                                                color: Color(0xff1C54B5),
                                              )),
                                          foregroundColor:
                                              const Color(0xff1C54B5),
                                          backgroundColor: Colors.white,
                                        ),
                                        icon: SizedBox(
                                          width: 34,
                                          child: SvgPicture.asset(
                                            "assets/logo/instagram_blue.svg",
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ))
              ],
            )),
          ],
        ),
      ),
    );
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
