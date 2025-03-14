import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:ed_helper_web/common/widgets/dialog/error_dialog.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/auth_repository.dart';
import 'package:ed_helper_web/util/device/validation_service.dart';
import 'package:ed_helper_web/util/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../generated/l10n.dart';
import '../../../util/constants/app_colors.dart';
import '../button/text_button_type_one.dart';
import '../form_fields/form_field_type_one.dart';

final _formKey = GlobalKey<FormState>();

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  TextEditingController codeController = TextEditingController();
  AuthRepository authRepository = AuthRepository();

  Future<void> verifyEmail() async {
    print(codeController.text);
    Response response = await authRepository.verifyEmail(codeController.text);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response.data);
      AutoRouter.of(context).replace(HomeRoute(), onFailure: (_) => AutoRouter.of(context).push(const AppErrorRoute()));
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(title: response.data + "(${response.statusCode})");
        });
  }

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
        height: 300,
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
                      Text(
                        S.of(context).inputCode,
                        style: GoogleFonts.montserrat(
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      FormFieldTypeOne(
                        controller: codeController,
                        validator: ValidationService().validateEmpty,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButtonTypeOne(
                              text: S.of(context).register, onPressed: verifyEmail),
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
