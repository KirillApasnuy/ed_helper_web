import 'package:auto_route/auto_route.dart';
import 'package:ed_helper_web/common/widgets/button/text_button_type_one_gradient.dart';
import 'package:ed_helper_web/common/widgets/pictures/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/widgets/button/text_button_type_two_gradient.dart';
import '../../../generated/l10n.dart';
import '../../../util/routes/router.dart';

class SideBar extends StatefulWidget {
  final ScrollController scrollController;
  bool isVisible;
  SideBar({
    super.key, required this.scrollController, required this.isVisible,
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
          child: Column(
            children: [
              SizedBox(
                  width: 250,
                  child: TextButtonTypeOneGradient(
                      text: S.of(context).home, onPressed: () {
                    widget.scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
                    widget.isVisible = false;
                    setState(() {});
                  })),
              SizedBox(
                  width: 250,
                  child: TextButtonTypeTwoGradient(
                      text: S.of(context).chat, onPressed: () {
                        AutoRouter.of(context).push(HomeRoute());
                        widget.isVisible = false;
                        setState(() {});
                  })),
              GestureDetector(
                onTap: () {
                  AutoRouter.of(context).push(const ProfileRoute());
                  widget.isVisible = false;
                  setState(() {});
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 170,
                    child: SvgIcons(
                        path: "assets/svg/profile_icon.svg",
                        size: 40, suffixIcon: Text(S.of(context).profile, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w500),),),

                  ),
                ),
              ),
              SizedBox(
                  width: 170,
                  child: SvgIcons(path: "assets/svg/land.svg", size: 40, suffixIcon: Text(S.of(context).language, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w500)))),
            ],
          ),
        ),
      ),
    );
  }
}
