import 'package:ed_helper_web/common/widgets/pictures/svg_icons.dart';
import 'package:ed_helper_web/data/models/features_card_model.dart';
import 'package:ed_helper_web/screens/welcome/widgets/preferens_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreferensFeatersCard extends StatelessWidget {
  const PreferensFeatersCard({super.key, required this.cardModel});

  final FeaturesCardModel cardModel;

  @override
  Widget build(BuildContext context) {
    return PreferensCard(
        child: Container(
      constraints: const BoxConstraints(
        maxWidth: 260,
        maxHeight: 300,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgIcons(path: "assets/svg/${cardModel.imageUrl}", size: 60),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            cardModel.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            cardModel.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ));
  }
}
