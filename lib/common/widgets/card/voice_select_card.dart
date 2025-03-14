import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../../../util/constants/app_colors.dart';

class VoiceSelectCard extends StatefulWidget {
  const VoiceSelectCard({super.key, required this.title,});
  final String title;
  @override
  State<VoiceSelectCard> createState() => _VoiceSelectCardState();
}

class _VoiceSelectCardState extends State<VoiceSelectCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth < 900 ? 220 : 320,
      height: screenWidth < 900 ? 160 : 260,
      decoration: BoxDecoration(
        border:
        Border.all(color: AppColors.cardBorder, width: 2),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.montserrat(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
