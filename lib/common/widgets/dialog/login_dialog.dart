import 'package:auto_route/auto_route.dart';
import 'package:ed_helper_web/common/widgets/dialog/forgot_password.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/auth_repository.dart';
import 'package:ed_helper_web/util/device/validation_service.dart';
import 'package:ed_helper_web/util/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/gpt_answer/auth/auth_model.dart';
import '../../../generated/l10n.dart';
import '../button/text_button_type_one.dart';
import '../form_fields/form_field_type_one.dart';
import 'error_dialog.dart';

final _formKey = GlobalKey<FormState>();

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthRepository authRepository = AuthRepository();

  Future<void> _onPressedForgotPasswordBtn() async {
    AutoRouter.of(context).pop();
    showDialog(
        context: context,
        builder: (BuildContext context) => const ForgotPassword());
  }

  Future<void> _onPressedLogBtn() async {
    if (!_formKey.currentState!.validate()) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AuthModel authModel = AuthModel(
        email: emailController.text, password: passwordController.text);
    Response response = await authRepository.signIn(authModel);
      print(response.data);
    try {
      if (response.statusCode == 200) {
        print(response.data);
        await prefs.setString('token', response.data);
        AutoRouter.of(context).push(HomeRoute());
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                  title:
                      response.data.toString() + " (${response.statusCode})");
            });
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(title: response.data.toString() + " (${response.statusCode})");
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 550),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
          child: Column(
            children: [
              FormFieldTypeOne(
                controller: emailController,
                labelText: S.of(context).email,
                validator: ValidationService().validateEmail,
              ),
              const SizedBox(height: 20),
              FormFieldTypeOne(
                controller: passwordController,
                labelText: S.of(context).password,
                validator: ValidationService().validatePassword,
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  TextButtonTypeOne(
                      text: S.of(context).singIn,
                      onPressed: () => _onPressedLogBtn()),
                  const SizedBox(width: 20),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => _onPressedForgotPasswordBtn(),
                      child: Text(
                        S.of(context).forgotPassword,
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
