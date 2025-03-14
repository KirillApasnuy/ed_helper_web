import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../../../util/constants/app_colors.dart';

class ClientCard extends StatefulWidget {
  const ClientCard({super.key, this.suffixIcon});
  final Widget? suffixIcon;

  @override
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth < 900 ? 200 : 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.cardBorder,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: AppColors.cardBackground,
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).yourCard, style: GoogleFonts.montserrat(fontSize: 19, color: Colors.black, fontWeight: FontWeight.w600),),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text('**38', style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600),),
                  SvgPicture.asset("assets/svg/logos_mastercard.svg")
                ],
              )
            ],
          ),
          widget.suffixIcon ?? const SizedBox(),
        ],
      ),
    );
  }
}
