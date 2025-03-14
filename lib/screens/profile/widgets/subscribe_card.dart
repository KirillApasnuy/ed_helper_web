import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../../../util/constants/app_colors.dart';

class SubscribeCard extends StatelessWidget {
  SubscribeCard({super.key, this.isPremium = false, required this.child});

  bool isPremium;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.cardBorder, width: 2),
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
            colors: isPremium
                ? [const Color(0xffCCE1F8), const Color(0xffEFFEF5)]
                : [const Color(0xffF1F7FC), const Color(0xffF1F7FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }
}
