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

import '../../../data/models/chat_message/chat_message.dart';
import '../../../data/models/gpt_answer/auth/auth_model.dart';
import '../../../generated/l10n.dart';
import '../button/text_button_type_one.dart';
import '../form_fields/form_field_type_one.dart';
import 'error_dialog.dart';

final _formKey = GlobalKey<FormState>();

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key, this.unAuthMessage});
  final ChatMessage? unAuthMessage;
  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthRepository authRepository = AuthRepository();

  bool isLoading = false;

  Future<void> _onPressedForgotPasswordBtn() async {
    showDialog(
        context: context,
        builder: (BuildContext context) => const ForgotPassword());
  }

  Future<void> _onPressedLogBtn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    }
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AuthModel authModel = AuthModel(
        email: emailController.text, password: passwordController.text);
    Response response = await authRepository.signIn(authModel);
    try {
      if (response.statusCode == 200) {

        setState(() {
          isLoading = false;
        });
        await prefs.setString('token', response.data);
        prefs.setBool("notAuth", false);
        AutoRouter.of(context).push(HomeRoute(message: widget.unAuthMessage));
      } else {

        setState(() {
          isLoading = false;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                  title:
                      response.data.toString() + " (${response.statusCode})");
            });
      }
    } catch (e) {

      setState(() {
        isLoading = false;
      });
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      constraints: BoxConstraints(
        maxWidth: 550, // Максимальная ширина
        minWidth: screenWidth < 600 ? screenWidth * 0.8 : 300, // Минимальная ширина
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenWidth < 600 ? 30 : 50, horizontal:screenWidth < 600 ? 0 : 50),
          child: Column(
            children: [
              FormFieldTypeOne(
                controller: emailController,
                labelText: S.of(context).email,
                validator: ValidationService().validateEmail,
                hintText: S.of(context).inputYourEmail,
              ),
              const SizedBox(height: 20),
              FormFieldTypeOne(
                controller: passwordController,
                labelText: S.of(context).password,
                validator: ValidationService().validatePassword,
                hintText: S.of(context).inputYourPassword,
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  TextButtonTypeOne(
                      text: S.of(context).singIn,
                      onPressed: () => _onPressedLogBtn()),
                  const SizedBox(width: 20),
                  Flexible(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => _onPressedForgotPasswordBtn(),
                        child: Text(
                          S.of(context).forgotPassword,
                          maxLines: 2,
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
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
