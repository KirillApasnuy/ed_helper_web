import 'package:ed_helper_web/util/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AutowiredButton extends StatefulWidget {
  const AutowiredButton(
      {super.key, required this.onPressed, required this.title});

  final Function(String) onPressed;
  final String title;

  @override
  State<AutowiredButton> createState() => _AutowiredButtonState();
}

class _AutowiredButtonState extends State<AutowiredButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () => widget.onPressed(widget.title),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.autowiredButtonBackground,
            overlayColor: AppColors.cardBorder,
          ),
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style:
                GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),

          )),
    );
  }
}
