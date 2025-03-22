import 'package:dio/dio.dart';
import 'package:ed_helper_web/common/widgets/dialog/verify_reset_email.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/auth_repository.dart';
import 'package:ed_helper_web/util/device/validation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../../../util/constants/app_colors.dart';
import '../button/text_button_type_one.dart';
import '../form_fields/form_field_type_one.dart';
import 'error_dialog.dart';

final _formKey = GlobalKey<FormState>();

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final authRepository = AuthRepository();
  bool isLoading = false;

  void verifyEmail() async {
    setState(() {
      isLoading = true;
    });
    Response response =
        await authRepository.verifyResetEmail(emailController.text);
    print(response.data);
    if (response.statusCode == 200) {
      showDialog(context: context, builder: (context) => VerifyResetEmail());
    } else {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
                title: S.of(context).accountNotFound,
              ));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      insetPadding: const EdgeInsets.all(8),
      child: Container(
        width: 600,
        decoration: BoxDecoration(
            color: AppColors.backgroundScreen,
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50, left: 50, right: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 8,
                  children: [
                    Column(
                      children: [
                        Text(
                          S.of(context).recoveryPassword,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontSize: screenWidth < 600 ? 25 : 32,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Text(
                          S.of(context).inputEmail,
                          style: GoogleFonts.montserrat(
                              fontSize: screenWidth < 600 ? 18 : 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    FormFieldTypeOne(
                      controller: emailController,
                      labelText: S.of(context).email,
                      validator: ValidationService().validateEmail,
                    ),
                    TextButtonTypeOne(
                        isLoading: isLoading,
                        text: S.of(context).sendEmail,
                        onPressed: verifyEmail)
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
