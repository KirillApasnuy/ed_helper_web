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
      margin: const EdgeInsets.only(top: 20,),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      constraints: BoxConstraints(
        minHeight: 80,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${widget.transaction.amount} руб", style: GoogleFonts.montserrat(fontSize: screenWidth < 900 ?14 : 16, fontWeight: FontWeight.w400),),
          const SizedBox(
            width: 10,
          ),
          Flexible(child: Text(widget.transaction.name, style: GoogleFonts.montserrat(fontSize: screenWidth < 900 ? 14 : 16, fontWeight: FontWeight.w400),)),
          const SizedBox(
            width: 10,
          ),
          Text("${widget.transaction.date.toString().substring(0, 10)}", style: GoogleFonts.montserrat(fontSize: screenWidth < 900 ? 14 : 16, fontWeight: FontWeight.w400),),
          const SizedBox(
            width: 10,
          ),
          Transform.scale(
            scale: screenWidth < 900 ? 0.7 : 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("**${widget.transaction.paymentCardNumber.toString().substring(17, 19)}", style: GoogleFonts.montserrat(fontSize: screenWidth < 900 ? 18: 20, fontWeight: FontWeight.w600),),
                SvgPicture.asset("assets/svg/logos_mastercard.svg")
              ],
            ),
          )
        ],
      ),
    );
  }
}
