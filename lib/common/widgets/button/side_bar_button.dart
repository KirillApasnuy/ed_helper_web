import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideBarButton extends StatelessWidget {
  const SideBarButton(
      {super.key,
      required this.text,
      required this.prefixIcon,
      required this.onPressed});

  final String text;
  final Widget prefixIcon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        overlayColor: Colors.blue,
        surfaceTintColor: Colors.white,
        // side: const BorderSide(color: Colors.blue, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          prefixIcon,
          Text(
            text,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
