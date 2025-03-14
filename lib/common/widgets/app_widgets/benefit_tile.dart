import 'package:ed_helper_web/common/widgets/pictures/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BenefitTile extends StatelessWidget {
  const BenefitTile({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 20,
      children: [
        const SvgIcons(path: "assets/svg/checkbox_icon.svg", size: 30),
        Flexible(
          child: Text(
            title,
            maxLines: 5,
            style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
