import 'package:ed_helper_web/common/widgets/card/rates_card.dart';
import 'package:ed_helper_web/common/widgets/dialog/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../../../util/constants/app_colors.dart';

class ActivateRatesDetail extends StatefulWidget {
  const ActivateRatesDetail({super.key});

  @override
  State<ActivateRatesDetail> createState() => _ActivateRatesDetailState();
}

class _ActivateRatesDetailState extends State<ActivateRatesDetail> {
  Future<void> _onPressedActivateRateBtn() async {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (context) => ErrorDialog(
              title: S.of(context).successChangeRate,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 500,
        height: 500,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cardBackground),
                    onPressed: () => Navigator.pop(context),
                    icon: SvgPicture.asset(
                      "assets/svg/delete_icon.svg",
                    )),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    S.of(context).activatePlanTitle,
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  RatesCard(onPressed: () async => _onPressedActivateRateBtn()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
