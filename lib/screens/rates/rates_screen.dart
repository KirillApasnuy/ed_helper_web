import 'package:auto_route/auto_route.dart';
import 'package:ed_helper_web/common/widgets/app_widgets/toggle_button.dart';
import 'package:ed_helper_web/common/widgets/button/text_button_type_one.dart';
import 'package:ed_helper_web/common/widgets/dialog/canceled_subscribe.dart';
import 'package:ed_helper_web/data/models/user/user_model.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/user_repository.dart';
import 'package:ed_helper_web/screens/profile/widgets/subscribe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../common/widgets/app_widgets/language_selector.dart';
import '../../common/widgets/button/text_button_type_one_gradient.dart';
import '../../common/widgets/button/text_button_type_two.dart';
import '../../common/widgets/button/text_button_type_two_gradient.dart';
import '../../common/widgets/pictures/svg_icons.dart';
import '../../generated/l10n.dart';
import '../../util/constants/app_colors.dart';
import '../../util/routes/router.dart';
import '../welcome/widgets/side_bar.dart';

@RoutePage()
class RatesScreen extends StatefulWidget {
  RatesScreen({super.key, this.authUser, this.onUserChanged});

  UserModel? authUser;
  final Function(UserModel)? onUserChanged;

  @override
  State<RatesScreen> createState() => _RatesScreenState();
}

class _RatesScreenState extends State<RatesScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _mainScrollController = ScrollController();
  final UserRepository userRepository = UserRepository();
  bool isYearBilling = true;
  bool isMenuVisible = false;
  bool isEndSubscription = false;
  late final formattedDate;

  Future<void> _onPressHistoryBtn() async {
    AutoRouter.of(context).push(HistoryRoute(authUser: widget.authUser!));
  }

  Future<void> _onPressCanceledSubscribeBtn() async {
    showDialog(
        context: context,
        builder: (_) => CanceledSubscribe(
            onUserChange: (user) {
              setState(() {
                widget.authUser = user;
                widget.onUserChanged!(user);
              });
            },
            authUser: widget.authUser!));
  }

  Future<void> _initializeUser() async {
    if (widget.authUser == null) {
      AutoRouter.of(context).back();
    } else {
      if (widget.authUser!.paidEndDate != null) {
        if (DateTime.parse(widget.authUser!.paidEndDate!)
                .isBefore(DateTime.now()) ||
            widget.authUser!.subscription!.limitGenerations <
                widget.authUser!.countGenerationInLastMonth) {
          final dateString = widget.authUser!.paidEndDate!;
          final parsedDate = DateTime.parse(dateString);
          formattedDate = DateFormat('dd.MM.yyyy').format(parsedDate);
          setState(() {
            isEndSubscription = true;
          });
        }
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    _initializeUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
              if (widget.authUser != null)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 120,
                      ),
                      screenHeight <= 850
                          ? SizedBox(height: screenHeight * 0.02)
                          : const SizedBox(height: 40),
                      Text(
                        S.of(context).subsribeManagment,
                        style: GoogleFonts.montserrat(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      screenHeight <= 850
                          ? SizedBox(height: screenHeight * 0.02)
                          : const SizedBox(height: 40),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).nowTariff,
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 20,
                            runSpacing: 20,
                            children: [
                              Container(
                                  constraints: const BoxConstraints(
                                      minWidth: 300, maxHeight: 200),
                                  child: SubscribeCard(
                                    isEndSubscribed: isEndSubscription,
                                    isPremium: widget
                                            .authUser!.subscription?.premium ??
                                        false,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,

                                      spacing: 8,
                                      children: [
                                        Text(
                                          (widget.authUser!.subscription !=
                                                  null)
                                              ? widget.authUser!.subscription!
                                                  .enTitle
                                              : S
                                                  .of(context)
                                                  .youDontHaveATariff,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        if (widget.authUser!.subscribeState !=
                                            "UNSUBSCRIBED")
                                          if (widget.authUser!.subscribeState !=
                                              "UNSUBSCRIBED")
                                            Text(
                                              S.of(context).nowTariff,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                        if (isEndSubscription)
                                          (widget.authUser!.subscription!
                                                      .limitGenerations <
                                                  widget.authUser!
                                                      .countGenerationInLastMonth)
                                              ? Text(
                                                  S.of(context).theGenerationLimitHasBeenExhausted,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              : Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      S.of(context).activeUntil,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    Text(
                                                      formattedDate,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                      ],
                                    ),
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                spacing: 10,
                                children: [
                                  SizedBox(
                                    width: screenWidth < 900 ? 250 : 300,
                                    child: TextButtonTypeTwo(
                                      onPressed: () async =>
                                          _onPressCanceledSubscribeBtn(),
                                      text: S.of(context).cancelSubscribe,
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth < 900 ? 250 : 300,
                                    child: TextButtonTypeOne(
                                        text: S.of(context).historyOperation,
                                        onPressed: () async =>
                                            _onPressHistoryBtn()),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          screenHeight <= 800
                              ? SizedBox(height: screenHeight * 0.02)
                              : const SizedBox(height: 30),
                          Text(
                            S.of(context).anotherRates,
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          screenHeight <= 780
                              ? SizedBox(height: screenHeight * 0.02)
                              : const SizedBox(height: 20),
                          ToggleContainer(
                            isYearBilling: isYearBilling,
                            onUserChanged: (user) {
                              setState(() {
                                widget.authUser = user;
                                widget.onUserChanged!(user);
                              });
                            },
                            authUser: widget.authUser!,
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ],
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
                                AutoRouter.of(context).replace(HomeRoute());
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
                                                AutoRouter.of(context)
                                                    .popUntilRouteWithName(
                                                        HomeRoute.name);
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
                                        LanguageSelector()
                                      ])
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isMenuVisible = !isMenuVisible;
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
                      if (screenWidth > 500)
                        Row(
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
