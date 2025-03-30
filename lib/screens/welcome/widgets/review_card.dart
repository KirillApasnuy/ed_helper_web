import 'package:ed_helper_web/common/widgets/pictures/svg_icons.dart';
import 'package:ed_helper_web/data/models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({super.key, required this.reviews});
  final ReviewModel reviews;
  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 420,
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
        ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(child: Image.asset(widget.reviews.avatarUrl, width: 50,
          semanticLabel: "select",)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.reviews.name, style: GoogleFonts.montserrat(fontSize: 18),),
                  Text(widget.reviews.description, style: GoogleFonts.montserrat(fontSize: 16),),],
              ),
              const SizedBox(height: 5,),
              SizedBox(
                  width: 280,
                  child: Text(widget.reviews.text, maxLines: 20, style: GoogleFonts.montserrat(fontSize: 16),)),

              const SizedBox(height: 10,),
              const Row(
                children: [
                  SvgIcons(path: "assets/svg/star.svg", size: 20),
                  SvgIcons(path: "assets/svg/star.svg", size: 20),
                  SvgIcons(path: "assets/svg/star.svg", size: 20),
                  SvgIcons(path: "assets/svg/star.svg", size: 20),
                  SvgIcons(path: "assets/svg/star.svg", size: 20),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
