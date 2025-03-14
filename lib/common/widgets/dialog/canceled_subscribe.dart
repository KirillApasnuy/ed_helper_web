import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:ed_helper_web/common/widgets/button/text_button_type_one.dart';
import 'package:ed_helper_web/common/widgets/button/text_button_type_two.dart';
import 'package:ed_helper_web/data/models/user/user_model.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/subscribe_repository.dart';
import 'package:ed_helper_web/util/constants/app_colors.dart';
import 'package:ed_helper_web/util/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';

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
      widget.authUser.subscription = null;
      widget.authUser.paidEndDate = null;
      widget.authUser.paidStartDate = null;
      widget.authUser.subscribeState = "UNSUBSCRIBED";
      widget.onUserChange!(widget.authUser);
      AutoRouter.of(context)
          .popAndPush(DoneRoute(title: S.of(context).subscribeSuccessCanceled));
    } else {
      AutoRouter.of(context)
          .popAndPush(ErrorRoute(title: "Ошибка отмены подписки", ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      width: 550,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.backgroundScreen,
      ),
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(S.of(context).warningWithCanceledSubscribe,
              style: GoogleFonts.montserrat(
                  fontSize: 18, fontWeight: FontWeight.w400)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButtonTypeOne(
                  text: S.of(context).no,
                  onPressed: () async => Navigator.pop(context)),
              const SizedBox(width: 20),
              TextButtonTypeTwo(
                  text: S.of(context).canceledSubscribe,
                  onPressed: () async => _onPressedCanceledSubscribe()),
            ],
          )
        ],
      ),
    ));
  }
}
