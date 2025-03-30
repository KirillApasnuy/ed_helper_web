import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextProgCard extends StatelessWidget {
  const TextProgCard({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xff1C54B5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          color: Colors.white, // Цвет текста
          fontSize: screenWidth < 600 ? 16 : 18.5,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
