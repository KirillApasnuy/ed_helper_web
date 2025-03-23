import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:ed_helper_web/common/widgets/button/text_button_type_one.dart';
import 'package:ed_helper_web/common/widgets/button/text_button_type_two.dart';
import 'package:ed_helper_web/common/widgets/dialog/done_dialog.dart';
import 'package:ed_helper_web/data/models/user/user_model.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/subscribe_repository.dart';
import 'package:ed_helper_web/util/constants/app_colors.dart';
import 'package:ed_helper_web/util/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import 'error_dialog.dart';

class CanceledSubscribe extends StatefulWidget {
  CanceledSubscribe({super.key, required this.onUserChange, required  this.authUser});
  final Function(UserModel) onUserChange;
  final UserModel authUser;
  @override
  State<CanceledSubscribe> createState() => _CanceledSubscribeState();
}

class _CanceledSubscribeState extends State<CanceledSubscribe> {
  final SubscribeRepository _subscribeRepository = SubscribeRepository();
  Future<void> _onPressedCanceledSubscribe() async {
    Response response = await _subscribeRepository.cancelSubscription();
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      widget.authUser.subscription = null;
      widget.authUser.paidEndDate = null;
      widget.authUser.paidStartDate = null;
      widget.authUser.subscribeState = "UNSUBSCRIBED";
      widget.onUserChange!(widget.authUser);
      showDialog(context: context, builder: (context) => DoneDialog(title: S.of(context).subscribeSuccessCanceled));
    } else {
      Navigator.of(context).pop();
      showDialog(context: context, builder: (context) => ErrorDialog(title: S.of(context).unsubscribeError));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Dialog(

        insetPadding: const EdgeInsets.all(8),
        child: Container(
      width: 550,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.backgroundScreen,
      ),
      padding: const EdgeInsets.all(30),
      child: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(S.of(context).warningWithCanceledSubscribe,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  fontSize: 18, fontWeight: FontWeight.w400)),
          Wrap(
            spacing: 20,
            runSpacing: 10,
            children: [
              TextButtonTypeOne(
                mainAxisSize: (screenWidth < 445) ? MainAxisSize.max : MainAxisSize.min,
                  text: S.of(context).no,
                  onPressed: () async => Navigator.pop(context)),
              TextButtonTypeTwo(
                mainAxisSize: (screenWidth < 445) ? MainAxisSize.max : MainAxisSize.min,
                  text: S.of(context).canceledSubscribe,
                  onPressed: () async => _onPressedCanceledSubscribe()),
            ],
          )
        ],
      ),
    ));
  }
}
