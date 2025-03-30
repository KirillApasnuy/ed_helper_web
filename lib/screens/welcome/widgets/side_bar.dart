import 'package:auto_route/auto_route.dart';
import 'package:ed_helper_web/common/widgets/app_widgets/language_selector.dart';
import 'package:ed_helper_web/common/widgets/pictures/svg_icons.dart';
import 'package:ed_helper_web/screens/home/widgets/home_side_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/widgets/button/text_button_type_two_gradient.dart';
import '../../../data/models/chat_message/chat_model.dart';
import '../../../generated/l10n.dart';
import '../../../util/routes/router.dart';

class SideBar extends StatefulWidget {
  final ScrollController scrollController;

  final Function(ChatModel)? onSelectChat;
  bool isVisible;

  SideBar({
    super.key,
    required this.scrollController,
    required this.isVisible,
    this.onSelectChat,
  });

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
        width: 300,
        height: screenHeight,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 250,
                  height: 50,
                  child: TextButtonTypeTwoGradient(
                      backgroundColor: const Color(0xff1C54B5),
                      textColor: Colors.white,
                      text: S.of(context).home,
                      onPressed: () {
                        AutoRouter.of(context).push(HomeRoute());
                        widget.isVisible = false;
                        setState(() {});
                      })),
              SizedBox(
                  width: 250,
                  height: 50,
                  child: TextButtonTypeTwoGradient(
                      text: S.of(context).chat,
                      onPressed: () {
                        AutoRouter.of(context).push(HomeRoute());
                        widget.isVisible = false;
                        setState(() {});
                      })),
              Container(
                margin: const EdgeInsets.all(5),
                width: 240,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    AutoRouter.of(context).push(const ProfileRoute());
                    widget.isVisible = false;
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      overlayColor: Colors.blue,
                      padding: EdgeInsets.zero,
                      shadowColor: Colors.transparent),
                  child: SvgIcons(
                    path: "assets/svg/profile_icon.svg",
                    size: 40,
                    suffixIcon: Text(
                      S.of(context).profile,
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(5),
                  width: 240,
                  height: 40,
                  child: LanguageSelector(
                    isLong: true,
                  )),
              if (widget.onSelectChat != null)
                HomeSideBar(
                  isExpanded: true,
                  onSelectChat: widget.onSelectChat!,
                  isHomeRoute: false,
                )
            ],
          ),
        ),
      ),
    );
  }
}
