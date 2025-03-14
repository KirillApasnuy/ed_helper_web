import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../../../util/constants/app_colors.dart';
import '../button/text_button_type_one.dart';
import '../form_fields/form_field_type_one.dart';

final _formKey = GlobalKey<FormState>();

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double size = screenWidth < screenHeight
        ? screenWidth
        : screenHeight; // Выбираем меньший размер
    double containerSize = size >= 600 ? 600 : (size <= 500 ? 500 : size);
    return Dialog(
      child: Container(
        width: 600,
        height: 400,
        decoration: BoxDecoration(
            color: AppColors.backgroundScreen,
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            S.of(context).recoveryPassword,
                            style: GoogleFonts.montserrat(
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Text(
                            S.of(context).inputEmail,
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      FormFieldTypeOne(
                        controller: emailController,
                        labelText: S.of(context).email,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButtonTypeOne(
                              text: S.of(context).sendEmail, onPressed: () {}),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.backgroundScreen),
                    onPressed: () => Navigator.pop(context),
                    icon: SvgPicture.asset(
                      "assets/svg/delete_icon.svg",
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
