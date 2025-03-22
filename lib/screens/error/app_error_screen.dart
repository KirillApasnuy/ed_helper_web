import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/l10n.dart';
import '../../util/constants/app_colors.dart';

@RoutePage()
class AppErrorScreen extends StatefulWidget {
  const AppErrorScreen({super.key});

  @override
  State<AppErrorScreen> createState() => _AppErrorScreenState();
}

class _AppErrorScreenState extends State<AppErrorScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double size = screenWidth > screenHeight ? screenWidth : screenHeight;
    bool isCompact = size <= 930;
    double logoSize =
        size * 0.8 >= 800 ? 800 : (size * 0.8 <= 200 ? 200 : size * 0.8);

    return Scaffold(
      body: Container(
        color: AppColors.backgroundScreen,
        padding: const EdgeInsets.all(50),
        child: isCompact
            ? Flexible(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [Text(
                          S.of(context).error,
                          style: GoogleFonts.montserrat(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff1C54B5),
                          ),
                          textAlign: TextAlign.center,
                        ),
                          const SizedBox(height: 10),
                          Text(
                            S.of(context).appErrorDescription,
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff1C54B5),
                            ),
                            textAlign: TextAlign.center,
                          ),],
                      ),
                    ),
                    // Center(
                    //   child: SizedBox(
                    //     width: logoSize,
                    //     height: logoSize,
                    //     child: Image.asset("assets/main_logo.png"),
                    //   ),
                    // ),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).error,
                        style: GoogleFonts.montserrat(
                          fontSize: logoSize * 0.1,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff1C54B5),
                        ),
                      ),
                      Text(
                        S.of(context).appErrorDescription,
                        style: GoogleFonts.montserrat(
                          fontSize: logoSize * 0.05,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff1C54B5),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Image.asset("assets/main_logo.png",
                      width: logoSize,
                      height: logoSize,
                    fit: BoxFit.contain,),
                  ),
                ],
              ),
      ),
    );
  }
}
