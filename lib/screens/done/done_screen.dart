import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/constants/app_colors.dart';

@RoutePage()
class DoneScreen extends StatefulWidget {
  const DoneScreen({super.key, required this.title});
  final String title;
  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: AppColors.backgroundScreen),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Stack(
                children: [
                  Container(
                    height: 500,
                    width: 500,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/logo_background_1.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 600,
                    width: 600,
                    color: AppColors.backgroundScreen.withOpacity(0.95),
                  ),
                ],
              ),
            ),
            Positioned(
              right: -100,
              bottom: -100,
              child: Stack(
                children: [
                  Container(
                    height: 500,
                    width: 500,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/logo_background_2.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 600,
                    width: 600,
                    color: AppColors.backgroundScreen.withOpacity(0.95),
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    'assets/svg/arrow_back.svg',
                    width: 70,
                    height: 70,
                  ),
                )),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/svg/done.svg"),
                  const SizedBox(height: 30,),
                  Text(widget.title, style: GoogleFonts.montserrat(fontSize: 30, fontWeight: FontWeight.w400, color: Colors.black),),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
