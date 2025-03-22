import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:ed_helper_web/common/widgets/dialog/done_dialog.dart';
import 'package:ed_helper_web/common/widgets/dialog/error_dialog.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/auth_repository.dart';
import 'package:ed_helper_web/util/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../../../util/constants/app_colors.dart';
import '../../../util/device/validation_service.dart';
import '../button/text_button_type_one.dart';
import '../form_fields/form_field_type_one.dart';

final _formKey = GlobalKey<FormState>();

class NewPasswordDialog extends StatefulWidget {
  const NewPasswordDialog({super.key, required this.token});

  final String token;

  @override
  State<NewPasswordDialog> createState() => _NewPasswordDialogState();
}

class _NewPasswordDialogState extends State<NewPasswordDialog> {
  final passwordController = TextEditingController();
  final authRepository = AuthRepository();
  bool isLoading = false;

  void setNewPassword() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      isLoading = false;
    });
    Response response = await authRepository.resetPassword(
        passwordController.text, widget.token);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) =>
            DoneDialog(title: S.of(context).passwordChangedSuccessfully),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) =>
            ErrorDialog(title: S.of(context).somethingWentWrong),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Dialog(
      insetPadding: EdgeInsets.all(8),
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
                        S.of(context).inputNewPassword,

                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontSize: screenWidth < 600 ? 26 : 32,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      FormFieldTypeOne(
                        controller: passwordController,
                        validator: ValidationService().validatePassword,
                      ),
                      TextButtonTypeOne(
                        isLoading: isLoading,
                        text: S.of(context).set,
                        onPressed: setNewPassword,
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
