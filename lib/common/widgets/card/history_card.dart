import 'package:ed_helper_web/data/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({super.key, required this.transaction});
  final Transaction transaction;
  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 20,),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(
          color: const Color(0xFF141414).withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 10),
        )]
      ),
      constraints: const BoxConstraints(
        minHeight: 80,
        maxWidth: 700
      ),
      padding: EdgeInsets.symmetric(horizontal: screenWidth < 500 ? 10 : 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 10,
        children: [
          Text("${widget.transaction.amount} руб", style: GoogleFonts.montserrat(fontSize: screenWidth < 900 ?14 : 16, fontWeight: FontWeight.w600),),
          Flexible(child: Text(widget.transaction.name, style: GoogleFonts.montserrat(fontSize: screenWidth < 900 ? 14 : 16, fontWeight: FontWeight.w400),)),
          Text("${widget.transaction.date.toString().substring(0, 10)}", style: GoogleFonts.montserrat(fontSize: screenWidth < 900 ? 14 : 16, fontWeight: FontWeight.w500),),
          Transform.scale(
            scale: screenWidth < 900 ? 0.7 : 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("**33", style: GoogleFonts.montserrat(fontSize: screenWidth < 900 ? 18: 20, fontWeight: FontWeight.w600),),
                SvgPicture.asset("assets/svg/logos_mastercard.svg")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
