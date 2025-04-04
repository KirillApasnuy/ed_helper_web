import 'package:dio/dio.dart';
import 'package:ed_helper_web/common/widgets/dialog/error_dialog.dart';
import 'package:ed_helper_web/common/widgets/dialog/new_password_dialog.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/auth_repository.dart';
import 'package:ed_helper_web/util/device/validation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/chat_message/chat_message.dart';
import '../../../generated/l10n.dart';
import '../../../util/constants/app_colors.dart';
import '../button/text_button_type_one.dart';
import '../form_fields/form_field_type_one.dart';

final _formKey = GlobalKey<FormState>();

class VerifyResetEmail extends StatefulWidget {
  const VerifyResetEmail({super.key, this.unAuthMessage});

  final ChatMessage? unAuthMessage;

  @override
  State<VerifyResetEmail> createState() => _VerifyResetEmailState();
}

class _VerifyResetEmailState extends State<VerifyResetEmail> {
  TextEditingController codeController = TextEditingController();
  AuthRepository authRepository = AuthRepository();
  bool isLoading = false;
  Future<void> verifyEmail() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });
    Response response =
        await authRepository.getVerifyToken(codeController.text);
    print(response.data);
    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (context) => NewPasswordDialog(
                token: response.data,
              ));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(title: S.of(context).invalidCode);
          });
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
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
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
            Align(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth < 600 ? 10 : 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        S.of(context).inputCode,
                        style: GoogleFonts.montserrat(
                            fontSize: screenWidth < 600 ? 26 : 32,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      FormFieldTypeOne(
                        controller: codeController,
                        validator: ValidationService().validateEmpty,
                      ),
                      TextButtonTypeOne(
                        isLoading: isLoading,
                        text: S.of(context).continuee,
                        onPressed: verifyEmail,
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
