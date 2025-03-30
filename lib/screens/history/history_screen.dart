import 'package:auto_route/auto_route.dart';
import 'package:ed_helper_web/data/models/transaction.dart';
import 'package:ed_helper_web/data/models/user/user_model.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/widgets/app_widgets/language_selector.dart';
import '../../common/widgets/button/text_button_type_one_gradient.dart';
import '../../common/widgets/button/text_button_type_two_gradient.dart';
import '../../common/widgets/card/history_card.dart';
import '../../common/widgets/pictures/svg_icons.dart';
import '../../generated/l10n.dart';
import '../../util/constants/app_colors.dart';
import '../../util/routes/router.dart';
import '../welcome/widgets/side_bar.dart';

@RoutePage()
class HistoryScreen extends StatefulWidget {
  HistoryScreen({super.key, this.authUser});

  UserModel? authUser;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ScrollController _mainScrollController = ScrollController();
  final TransactionRepository _transactionRepository = TransactionRepository();
  List<Transaction> history = [];
  bool isMenuVisible = false;

  Future<void> _initializeUser() async {
    // widget.authUser = await userRepository.getUser();
    if (widget.authUser == null) {
      // Если пользователь не загружен, перенаправляем на ProfileRate

      AutoRouter.of(context).back();
    } else {
      setState(() {});
    }
  }

  void _initializeHistory() async {
    history = await _transactionRepository.getTransactions() ?? [];
    setState(() {});
    if (history.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(S.of(context).historyIsEmpty),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  @override
  void initState() {
    _initializeUser();
    _initializeHistory();
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
        child: Stack(
          children: [
            Positioned(
              left: -200,
              top: -50,
              child: Image.asset(
                "assets/logo_back_transparet.png",
                fit: BoxFit.fitHeight,
                width: 700,
                height: 700,
              ),
            ),
            if (widget.authUser != null)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: screenWidth < 600 ? 90 : 120,
                    ),
                    Text(
                      S.of(context).historyOperation,
                      style: GoogleFonts.montserrat(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: screenWidth < 600 ? 10 : 30,
                    ),
                    if (history.isNotEmpty)
                      SizedBox(
                        height: screenHeight - (screenWidth < 600 ? 140 : 186),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    history.map((Transaction transaction) {
                                  return HistoryCard(transaction: transaction);
                                }).toList()),
                          ),
                        ),
                      )
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
                                          AutoRouter.of(context)
                                              .push(HomeRoute());
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
                    if (screenWidth > 600)
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
    );
  }
}
