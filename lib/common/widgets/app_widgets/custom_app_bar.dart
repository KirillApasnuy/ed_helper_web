import 'package:auto_route/auto_route.dart';
import 'package:ed_helper_web/common/widgets/pictures/svg_icons.dart';
import 'package:flutter/material.dart';

import '../../../util/routes/router.dart';
import '../button/text_button_type_one_gradient.dart';
import '../button/text_button_type_two_gradient.dart';

class CustomAppBar extends StatefulWidget{
  CustomAppBar({super.key, required this.isVisible});
  bool isVisible;
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            children: [
              GestureDetector(
                  onTap: () {
                      widget.isVisible = !widget.isVisible;
                    setState(() {
                    });
                  },
                  child: const MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: SvgIcons(path: "assets/svg/menu.svg", size: 50))),
              TextButtonTypeOneGradient(
                  text: "Главная",
                  onPressed: () {
                    AutoRouter.of(context).replace(const WelcomeRoute());
                  }),
              TextButtonTypeTwoGradient(
                  text: "Чат",
                  onPressed: () {
                    AutoRouter.of(context).push(HomeRoute());
                  }),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            // spacing: 20,
            children: [
              GestureDetector(
                onTap: () {
                  AutoRouter.of(context).push(const ProfileRoute());
                },
                child: const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SvgIcons(
                      path: "assets/svg/profile_icon.svg",
                      size: 40),
                ),
              ),
              GestureDetector(
                onTap: () {
                  AutoRouter.of(context).push(const ProfileRoute());
                },
                child: const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SvgIcons(
                      path: "assets/svg/land.svg", size: 40),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
