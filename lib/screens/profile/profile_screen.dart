import 'package:auto_route/auto_route.dart';
import 'package:ed_helper_web/common/widgets/button/text_button_type_two.dart';
import 'package:ed_helper_web/common/widgets/dialog/error_dialog.dart';
import 'package:ed_helper_web/data/models/user/user_model.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/user_repository.dart';
import 'package:ed_helper_web/screens/profile/widgets/subscribe_card.dart';
import 'package:ed_helper_web/util/constants/app_colors.dart';
import 'package:ed_helper_web/util/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/widgets/button/text_button_type_one_gradient.dart';
import '../../common/widgets/button/text_button_type_two_gradient.dart';
import '../../common/widgets/pictures/svg_icons.dart';
import '../../generated/l10n.dart';
import '../welcome/widgets/side_bar.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _mainScrollController = ScrollController();
  final UserRepository userRepository = UserRepository();
  bool notAuth = true;
  bool isMenuVisible = false;
  UserModel? authUser;

  void userUpdate(UserModel user) {
    authUser = user;
    setState(() {});
  }

  Future<void> _onPressSubscribeManagmentBtn() async {
    if (authUser != null) {
      AutoRouter.of(context)
          .push(RatesRoute(authUser: authUser!, onUserChanged: userUpdate));
    } else {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
                title: S.of(context).yourAccountIsNotConnected,
              ));
    }
  }

  Future<void> _onPressAccountManagmantBtn() async {
    if (authUser != null) {
      AutoRouter.of(context).push(AccountManagementRoute(authUser: authUser!));
    } else {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
                title: S.of(context).yourAccountIsNotConnected,
              ));
    }
  }

  Future<void> _initializeUser() async {
    authUser = await userRepository.getUser();
    if (authUser == null) {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
                title: S.of(context).errorLoadingUser,
              ));
    }
    setState(() {});
  }

  @override
  void initState() {
    _initializeUser();
    super.initState();
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
              notAuth ? Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 300,),
                    Icon(Iconsax.)
                  ],
                ),
              ) : Center(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 1200,
                  ),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 120),
                      Text(
                        S.of(context).profileTitle,
                        style: GoogleFonts.montserrat(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.pink),
                        child: Center(
                          child: Text(
                            authUser != null
                                ? authUser!.email.split("")[0].toUpperCase()
                                : "o",
                            style: GoogleFonts.montserrat(
                                fontSize: 40,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                          constraints: const BoxConstraints(
                              minWidth: 300, maxHeight: 200),
                          child: SubscribeCard(
                            isPremium: true,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (authUser != null)
                                  Text(
                                    (authUser?.subscription != null)
                                        ? authUser!.subscription!.enTitle
                                        : S.of(context).youDontHaveATariff,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                // if (authUser != null &&
                                //     authUser!.subscribeState == "SUBSCRIBED")
                                const SizedBox(
                                  height: 10,
                                ),
                                // if (authUser != null &&
                                //     authUser!.subscribeState == "SUBSCRIBED")
                                Text(
                                  S.of(context).nowTariff,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 460,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButtonTypeTwo(
                              text: S.of(context).subsribeManagment,
                              onPressed: () async =>
                                  _onPressSubscribeManagmentBtn(),
                              borderColor: AppColors.cardBorder,
                              suffixIcon: SvgPicture.asset(
                                  "assets/svg/arrow_right.svg"),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextButtonTypeTwo(
                              text: S.of(context).accountManagment,
                              onPressed: () async =>
                                  _onPressAccountManagmantBtn(),
                              borderColor: AppColors.cardBorder,
                              suffixIcon: SvgPicture.asset(
                                  "assets/svg/arrow_right.svg"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 70,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
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
                                AutoRouter.of(context).push(HomeRoute());
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
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                        SizedBox(
                                          height: 55,
                                          child: TextButtonTypeOneGradient(
                                              text: S.of(context).home,
                                              onPressed: () {
                                                AutoRouter.of(context).pop();
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
                                                .replace(const ProfileRoute());
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
                                                .replace(const ProfileRoute());
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
                      if (screenWidth > 500) Row(
                        children: [
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
                      )
                    ],
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
      ),
    );
  }
}
