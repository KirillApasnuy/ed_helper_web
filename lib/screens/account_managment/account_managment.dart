import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:ed_helper_web/common/widgets/button/text_button_type_two.dart';
import 'package:ed_helper_web/common/widgets/dialog/done_dialog.dart';
import 'package:ed_helper_web/common/widgets/form_fields/form_field_type_one.dart';
import 'package:ed_helper_web/data/models/user/user_model.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/widgets/button/text_button_type_one_gradient.dart';
import '../../common/widgets/button/text_button_type_two_gradient.dart';
import '../../common/widgets/dialog/error_dialog.dart';
import '../../common/widgets/pictures/svg_icons.dart';
import '../../generated/l10n.dart';
import '../../util/constants/app_colors.dart';
import '../../util/routes/router.dart';
import '../welcome/widgets/side_bar.dart';

@RoutePage()
class AccountManagementScreen extends StatefulWidget {
  AccountManagementScreen({super.key, this.authUser});

  UserModel? authUser;

  @override
  State<AccountManagementScreen> createState() =>
      _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ScrollController _mainScrollController = ScrollController();
  final UserRepository _userRepository = UserRepository();
  bool isMenuVisible = false;

  void updateUser() async {
    widget.authUser!.email = _emailController.text;
    Response response = await _userRepository.updateUser(widget.authUser!);
    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (context) {
            return DoneDialog(title: S.of(context).updateSuccessfully);
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(title: S.of(context).updateFailed);
          });
    }
  }

  void deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response response = await _userRepository.deleteUser(widget.authUser!.id);
    if (response.statusCode == 200) {
      prefs.clear();
      showDialog(
          context: context,
          builder: (context) {
            return DoneDialog(title: S.of(context).deleteSuccessfully);
          });
      AutoRouter.of(context).replace(const WelcomeRoute());
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(title: S.of(context).deleteFailed);
          });
    }
  }

  Future<void> _initializeUser() async {
    if (widget.authUser == null) {
      AutoRouter.of(context).back();
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    _initializeUser();
    if (widget.authUser != null) {
      _emailController.text = widget.authUser!.email;
      _passwordController.text = "********";
    }
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
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Transform.translate(
                offset: const Offset(-290, 0),
                child: Image.asset(
                  "assets/logo_back_transparet.png",
                  fit: BoxFit.cover,
                  width: 800,
                  height: 800,
                ),
              ),
            ),
            if (widget.authUser != null)
              Align(
                alignment: Alignment.center,
                  child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                margin: const EdgeInsets.all(10),
                child: Column(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100,),
                    Text(S.of(context).accountManagement,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),

                    const SizedBox(height: 20),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      runSpacing: 8,
                      spacing: 50,
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxWidth: 450),
                            child: FormFieldTypeOne(
                              controller: _emailController,
                              labelText: S.of(context).email,
                            )),
                        Container(
                          height: 50,
                          constraints: const BoxConstraints(maxWidth: 450),
                          child: TextButtonTypeTwo(
                            mainAxisSize: screenWidth > 600 ? MainAxisSize.min: MainAxisSize.max,
                              text: S.of(context).edit, onPressed: updateUser),
                        )
                      ],
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      runSpacing: 8,
                      spacing: 50,

                      children: [
                        Container(
                            constraints: const BoxConstraints(maxWidth: 450),
                            child: FormFieldTypeOne(
                              controller: _passwordController,
                              labelText: S.of(context).password,
                            )),
                        Container(
                          height: 50,
                          constraints: const BoxConstraints(maxWidth: 450),
                          child: TextButtonTypeTwo(
                              mainAxisSize: screenWidth > 600 ? MainAxisSize.min: MainAxisSize.max,
                              text: S.of(context).edit, onPressed: updateUser),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      runAlignment: WrapAlignment.start,
                      alignment: WrapAlignment.start,
                      runSpacing: 8,
                      spacing: 50,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).deleteAccountAndAllData,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenWidth < 900 ? 20 : 25),
                            ),
                            Text(
                              S.of(context).thisActionIsIrreversible,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: screenWidth < 900 ? 17 : 20),
                            ),
                          ],
                        ),
                        SizedBox(
                            width: screenWidth < 900 ? 200 : 250,
                            height: 50,
                            child: TextButtonTypeTwo(
                                text: S.of(context).deleteAccount,
                                onPressed: deleteUser)),
                      ],
                    ),
                  ],
                ),
              )),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Container(
                  height: 70,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.boxTitleFill,
                    border: Border.all(
                        color: AppColors.boxTitleBorder, width: 2),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(60)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // _mainScrollController.animateTo(0,
                          //     duration: const Duration(milliseconds: 500),
                          //     curve: Curves.easeOut);
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: SvgPicture.asset(
                            "assets/logo/title_logo.svg",
                            height: 50,
                          ),
                        ),
                      ),
                      screenWidth > 600
                          ? Row(mainAxisSize: MainAxisSize.min, children: [
                              SizedBox(
                                height: 55,
                                child: TextButtonTypeOneGradient(
                                    text: S.of(context).home,
                                    onPressed: () {
                                     AutoRouter.of(context).push(HomeRoute());
                                    }),
                              ),
                              SizedBox(
                                height: 55,
                                child: TextButtonTypeTwoGradient(
                                    text: S.of(context).chat,
                                    onPressed: () {
                                      AutoRouter.of(context)
                                          .push(HomeRoute());
                                    }),
                              ),
                              GestureDetector(
                                onTap: () {
                                  AutoRouter.of(context)
                                      .push(const ProfileRoute());
                                },
                                child: const MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: SvgIcons(
                                      path:
                                          "assets/svg/select_profile_icon.svg",
                                      size: 40),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  AutoRouter.of(context)
                                      .push(const ProfileRoute());
                                },
                                child: const MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: SvgIcons(
                                      path: "assets/svg/land.svg",
                                      size: 40),
                                ),
                              ),
                            ])
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  isMenuVisible = !isMenuVisible;
                                  print(isMenuVisible);
                                });
                              },
                              child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: SvgPicture.asset(
                                    "assets/svg/title_menu.svg",
                                    height: 40,
                                  )),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            if (screenWidth > 550)Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 70),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    'assets/svg/arrow_back.svg',
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              right: !isMenuVisible ? -300 : 0,
              top: 0,
              bottom: 0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // if (isMenuVisible)
                  if (isMenuVisible)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isMenuVisible = !isMenuVisible;
                        });
                      },
                      child: Container(
                        width: screenWidth,
                        height: screenHeight,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  SideBar(
                      scrollController: _mainScrollController,
                      isVisible: isMenuVisible),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
