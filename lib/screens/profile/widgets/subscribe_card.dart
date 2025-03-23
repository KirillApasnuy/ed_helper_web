import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../../../util/constants/app_colors.dart';

class SubscribeCard extends StatelessWidget {
  SubscribeCard({super.key, this.isPremium = false, this.isEndSubscribed = false, required this.child});
  bool isEndSubscribed;
  bool isPremium;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: isEndSubscribed ? Colors.red : AppColors.cardBorder, width: 2),
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
            colors: isEndSubscribed ? [const Color(0xffFFECEC), const Color(0xffFFECEC)] : isPremium
                ? [const Color(0xffCCE1F8), const Color(0xffEFFEF5)]
                : [const Color(0xffF1F7FC), const Color(0xffF1F7FC)] ,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          )
        ]
      ),
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }
}
