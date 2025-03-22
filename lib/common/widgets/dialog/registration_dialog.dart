import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:ed_helper_web/common/widgets/app_widgets/switcher_type_one.dart';
import 'package:ed_helper_web/common/widgets/button/text_button_type_one.dart';
import 'package:ed_helper_web/common/widgets/dialog/verify_email.dart';
import 'package:ed_helper_web/common/widgets/form_fields/form_field_type_one.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/auth_repository.dart';
import 'package:ed_helper_web/util/device/validation_service.dart';
import 'package:ed_helper_web/util/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/chat_message/chat_message.dart';
import '../../../data/models/gpt_answer/auth/auth_model.dart';
import '../../../generated/l10n.dart';
import 'error_dialog.dart';

class RegistrationDialog extends StatefulWidget {
  RegistrationDialog(
      {super.key, required this.isLogin, required this.onChanged, this.unAuthMessage});

  bool isLogin;
  final ValueChanged<bool> onChanged;
  final ChatMessage? unAuthMessage;
  @override
  State<RegistrationDialog> createState() => _RegistrationDialogState();
}

class _RegistrationDialogState extends State<RegistrationDialog>
    with SingleTickerProviderStateMixin {
  final _key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthRepository authRepository = AuthRepository();

  final String clientId = dotenv.env['oauth_google_client_id']!;
  final String clientSecret = dotenv.env['oauth_google_secret_key']!;
  final String redirectUri = dotenv.env['oauth_google_redirect']!;

  bool isGetNews = false;
  bool isAgreement = false;
  bool isValidAgreement = true;
  bool isLoading = false;

  final String vkClientId =
  dotenv.env['oauth_vk_client_id']!; // ID VK-приложения
  final String vkRedirectUri =
  dotenv.env['oauth_vk_redirect']!; // URI VK-приложения

  @override
  void initState() {
    super.initState();
    // _initWebView();
  }

  void updateIsAgreement(bool value) {
    setState(() {
      isAgreement = value;
    });
  }

  void updateIsGetNews(bool value) {
    setState(() {
      isGetNews = value;
    });
  }

  // Future<void> _initWebView() async {
  //   await _controller.initialize();
  //   _controller.url.listen((url) {
  //     if (url.startsWith(redirectUri)) {
  //       _handleRedirect(url);
  //     }
  //   });
  //   _controller.loadUrl(
  //       "https://oauth.vk.com/authorize?client_id=$vkClientId&display=page&redirect_uri=$vkRedirectUri&scope=friends,offline&response_type=token&v=5.131");
  // }

  void _handleRedirect(String url) {
    Uri uri = Uri.parse(url);
    if (uri.fragment.contains("access_token")) {
      var params = Uri.splitQueryString(uri.fragment.substring(1));
      String accessToken = params["access_token"] ?? "";
      print("VK Access Token: $accessToken");
      // TODO: Сохранить токен и использовать его для запросов к API VK
    }
  }

  // final OAuth2Helper oAuth2Helper = OAuth2Helper(
  //   GoogleOAuth2Client(
  //       redirectUri: "http://localhost:3000/callback", customUriScheme: "http"),
  //   clientId:
  //       "706217530123-hus0vn1va1co1psvif1gtfu3hgqc180f.apps.googleusercontent.com",
  //   clientSecret: "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",
  //   scopes: ["email", "profile"],
  // );

  Future<void> _onPressedRegBtn() async {
    if (!_key.currentState!.validate()) return;

    if (!isAgreement) {
      print(isAgreement); // Логирование
      setState(() {
        isValidAgreement = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    AuthModel authModel = AuthModel(
        email: emailController.text, password: passwordController.text,
    isReceivedEmail: isGetNews,);
    Response response = await authRepository.signUp(authModel);

    try {
      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) => VerifyEmail(unAuthMessage: widget.unAuthMessage,),
        ).then((_) {
          print('VerifyEmail dialog closed'); // Логирование закрытия диалога
        });
        setState(() {
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = true;
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
        isLoading = true;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(title: e.toString());
          });
    }
  }

  Future<void> _onPressedLogBtn() async {
    setState(() {
      widget.isLogin = true;
      widget.onChanged(widget.isLogin);
    });
  }

  Future<Map<String, dynamic>?> getAccessToken(String code) async {
    final response = await http.post(
      Uri.parse("https://oauth2.googleapis.com/token"),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "client_id": clientId,
        "client_secret": clientSecret,
        "code": code,
        "grant_type": "authorization_code",
        "redirect_uri": redirectUri,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Ошибка при получении токена: ${response.body}");
      return null;
    }
  }

  Future<void> _onPressAuthGoogleBtn() async {
    HttpServer server =
    await HttpServer.bind(InternetAddress.loopbackIPv4, 3000);

    print("Сервер запущен на http://localhost:3000");

    final authUrl =
        "https://accounts.google.com/o/oauth2/auth?client_id=$clientId&redirect_uri=$redirectUri&response_type=code&scope=email%20profile";

    if (await canLaunchUrl(Uri.parse(authUrl))) {
      await launchUrl(Uri.parse(authUrl), mode: LaunchMode.externalApplication);
    }

    await for (HttpRequest request in server) {
      final queryParams = request.uri.queryParameters;
      if (queryParams.containsKey("code")) {
        final authCode = queryParams["code"];
        print("Код авторизации: $authCode");

        // Отправляем код на сервер Google для получения токена
        final token = await getAccessToken(authCode!);
        if (token != null) {
          print("Токен доступа: ${token["access_token"]}");
          server?.close();
          AutoRouter.of(context).push(HomeRoute());
        }
      }
      request.response.headers.contentType = ContentType.html;
      request.response.write(
          "<html><body><h2>Вы можете закрыть это окно</h2></body></html>");
      await request.response.close();
    }
  }

  Future<void> _onPressAuthVkBtn() async {
    final _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
    print("Сервер запущен на ${_server!.address.address}:${_server!.port}");

    _server!.listen((HttpRequest request) async {
      final uri = request.uri;
      if (uri.fragment.contains("access_token")) {
        var params = Uri.splitQueryString(uri.fragment.substring(1));
        final _accessToken = params["access_token"];
        print("VK Access Token: $_accessToken");

        AutoRouter.of(context).push(HomeRoute());

        // Отправляем HTML-ответ в браузер
        request.response
          ..headers.contentType = ContentType.html
          ..write(
              "<html><body><h1>Авторизация успешна!</h1><p>Можете закрыть это окно.</p></body></html>")
          ..close();

        setState(() {}); // Обновляем UI
        await _server?.close(); // Останавливаем сервер
      } else {
        request.response
          ..statusCode = HttpStatus.notFound
          ..write("Not Found")
          ..close();
      }
    });
    if (await canLaunch(
        "https://oauth.vk.com/authorize?client_id=$vkClientId&display=page&redirect_uri=$vkRedirectUri&scope=friends,offline&response_type=token&v=5.131")) {
      await launch(
          "https://oauth.vk.com/authorize?client_id=$vkClientId&display=page&redirect_uri=$vkRedirectUri&scope=friends,offline&response_type=token&v=5.131");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Container(
      constraints: BoxConstraints(
        maxWidth: 550, // Максимальная ширина
        minWidth: screenWidth < 600 ? screenWidth * 0.8 : 300, // Минимальная ширина
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenWidth < 600 ? 30 : 50, horizontal:screenWidth < 600 ? 0 : 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormFieldTypeOne(
                controller: emailController,
                labelText: S
                    .of(context)
                    .email,
                validator: ValidationService().validateEmail,
              ),
              const SizedBox(height: 20),
              FormFieldTypeOne(
                controller: passwordController,
                labelText: S
                    .of(context)
                    .password,
                validator: ValidationService().validatePassword,
              ),
              const SizedBox(height: 10),
              Transform.translate(
                offset: const Offset(-10, 0),
                child: Row(
                  children: [
                    SwitcherTypeOne(
                        value: isGetNews, onChanged: updateIsAgreement),
                    Flexible(
                      child: Text(S
                          .of(context)
                          .getNews,
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(-10, 0),
                child: Row(
                  children: [
                    SwitcherTypeOne(
                      value: isAgreement,
                      isValid: isValidAgreement,
                      onChanged: updateIsAgreement,
                    ),
                    Flexible(
                      child: Text(S
                          .of(context)
                          .agreement,
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    S
                        .of(context)
                        .logWith,
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
              Transform.translate(
                offset: const Offset(-10, 0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () async => await _onPressAuthGoogleBtn(),
                        icon: SvgPicture.asset(
                          "assets/logo/google.svg",
                        )),
                    IconButton(
                        onPressed: () async => {},
                        icon: SvgPicture.asset(
                          "assets/logo/vk.svg",
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/logo/yandex.svg",
                        )),
                    IconButton(
                        onPressed: () async {
                          final key = LogicalKeyboardKey.keyX.keyId;
                          final key1 = LogicalKeyboardKey.findKeyByKeyId(key);
                        },
                        icon: SvgPicture.asset(
                          "assets/logo/mail.svg",
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 8,
                children: [
                  TextButtonTypeOne(
                      text: S
                          .of(context)
                          .register,
                      onPressed: () => _onPressedRegBtn(),
                  isLoading: isLoading,),
                  Flexible(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => _onPressedLogBtn(),
                        child: Text(
                          S
                              .of(context)
                              .haveAccount,
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: screenWidth < 900 ? 14 : 16),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
