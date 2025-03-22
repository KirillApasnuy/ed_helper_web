import 'package:auto_route/auto_route.dart';
import 'package:ed_helper_web/common/widgets/dialog/login_dialog.dart';
import 'package:ed_helper_web/common/widgets/dialog/registration_dialog.dart';
import 'package:ed_helper_web/data/models/chat_message/chat_message.dart';
import 'package:ed_helper_web/screens/welcome/widgets/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/l10n.dart';
import '../../util/routes/router.dart';

@RoutePage()
class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({super.key, this.unAuthMessage});
  final ChatMessage? unAuthMessage;
  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  bool isLogin = true;
  double _indicatorPosition = 0.0;

  void updateIsLogin(bool value) {
    setState(() {
      isLogin = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffEFFEF5),
              Color(0xffDFEBFF),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        width: screenWidth,
        height: screenHeight,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              if (screenWidth > 1000)
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 70),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 30,
                    children: [
                      GestureDetector(
                        onTap: () {
                          AutoRouter.of(context).replace(const WelcomeRoute());
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: SvgPicture.asset(
                            "assets/logo/title_logo.svg",
                            height: 50,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: SvgPicture.asset(
                          'assets/svg/arrow_back.svg',
                          width: 70,
                          height: 70,
                        ),
                      ),
                    ],
                  ),
                ),
              Center(
                child: Column(
                  mainAxisAlignment: screenWidth > 1000
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    if (screenWidth < 1000)
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: GestureDetector(
                          onTap: () {
                            AutoRouter.of(context).replace(const WelcomeRoute());
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: SvgPicture.asset(
                              "assets/logo/title_logo.svg",
                              height: 50,
                            ),
                          ),
                        ),
                      ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChatCard(
                        maxWidth: 600,
                        isPadding: false,
                        child: Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildAuthButton(
                                      S.of(context).registration, !isLogin, 1.0),
                                  _buildAuthButton(S.of(context).login, isLogin, 0.0),
                                ],
                              ),
                              isLogin
                                  ? const LoginDialog()
                                  : RegistrationDialog(
                                isLogin: isLogin,
                                onChanged: updateIsLogin,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButton(String text, bool isActive, double position) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLogin = text == S.of(context).login;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 5),

            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.black : Colors.grey,
              ),
            ),
          ),
          Container(
            height: 2,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            color: isActive ? const Color(0xff1C54B5) : Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}
