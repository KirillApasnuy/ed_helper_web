import 'package:ed_helper_web/common/widgets/button/text_button_type_one.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../../../util/constants/app_colors.dart';

class RatesCard extends StatefulWidget {
  const RatesCard({super.key, required this.onPressed});
  final Function onPressed;
  @override
  State<RatesCard> createState() => _RatesCardState();
}

class _RatesCardState extends State<RatesCard> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.cardBorder,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(screenHeight <= 800 ? screenHeight * 0.03 : 50),
          child: Column(
            children: [
              Text('Заголовок', style: GoogleFonts.montserrat(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('Преимущества', style: GoogleFonts.montserrat(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('Преимущества', style: GoogleFonts.montserrat(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('Преимущества', style: GoogleFonts.montserrat(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('Преимущества', style: GoogleFonts.montserrat(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),),
                ],
              ),
              const SizedBox(height: 10),
              Text("299 руб/мес", style: GoogleFonts.montserrat(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: screenWidth > 1000 ? 0 : 25),
          width: 300,
            child: TextButtonTypeOne(text: S.of(context).activate, onPressed: () async => widget.onPressed()))
      ],
    );
  }
}
