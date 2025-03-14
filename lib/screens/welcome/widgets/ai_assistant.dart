import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';

class AiAssistant extends StatelessWidget {
  const AiAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset('assets/svg/headline_substrate.svg', alignment: Alignment.center, width: screenWidth < 900 ? 300 : null,),
        Text(S.of(context).aiAssistant, style: GoogleFonts.geologica(fontSize: screenWidth > 900 ? 45 : 30, color: Colors.white, fontWeight: FontWeight.w600),),
      ],
    );
  }
}
