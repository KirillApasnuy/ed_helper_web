import 'package:dio/dio.dart';
import 'package:ed_helper_web/common/widgets/app_widgets/benefit_tile.dart';
import 'package:ed_helper_web/common/widgets/button/text_button_type_one.dart';
import 'package:ed_helper_web/common/widgets/dialog/done_dialog.dart';
import 'package:ed_helper_web/common/widgets/dialog/error_dialog.dart';
import 'package:ed_helper_web/data/models/user/user_model.dart';
import 'package:ed_helper_web/data/repositories/ed_helper/subscribe_repository.dart';
import 'package:ed_helper_web/screens/profile/widgets/subscribe_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../data/models/user/subscription.dart';
import '../../../generated/l10n.dart';
import '../../../util/device/localization/locale_provider.dart';

class ToggleContainer extends StatefulWidget {
  ToggleContainer(
      {super.key,
      required this.isYearBilling,
      required this.onUserChanged,
      required this.authUser});

  bool isYearBilling;
  UserModel authUser;
  final Function(UserModel) onUserChanged;

  @override
  _ToggleContainerState createState() => _ToggleContainerState();
}

class _ToggleContainerState extends State<ToggleContainer> {
  final SubscribeRepository _subscribeRepository = SubscribeRepository();
  bool isLoading = false;
  List<Subscription> subscriptions = [];

  void initialize() async {
    subscriptions = (await _subscribeRepository.getSubscription())!;
    setState(() {});
  }

  void _toggleSelection() {
    setState(() {
      widget.isYearBilling = !widget.isYearBilling;
    });
  }

  void _subscribe(Subscription subscription) async {
    setState(() {
      isLoading = true;
    });
    Response response =
        await _subscribeRepository.subscribe(planId: subscription.id);
    if (response.statusCode == 200 || response.statusCode == 400) {
      widget.authUser.subscription = subscription;
      widget.authUser.subscribeState = "SUBSCRIBED";
      widget.onUserChanged(widget.authUser);
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (context) =>
            const DoneDialog(title: "Вы успешно подписались!"),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (context) => const ErrorDialog(title: "Ошибка при подписке!"),
      );
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final isEnglish = localeProvider.locale.languageCode == 'en';
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                GestureDetector(
                  onTap: _toggleSelection,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: widget.isYearBilling
                          ? const Color(0xffCCE1F8)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(S.of(context).annual,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, fontSize: 18)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _toggleSelection,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: !widget.isYearBilling
                          ? const Color(0xffCCE1F8)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(S.of(context).monthly,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Плавное переключение UI
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 40,
                runSpacing: 20,
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 20,
                    spacing: 20,
                    children: subscriptions != []
                        ? subscriptions.map((subscription) {
                            return Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 600),
                                child: SubscribeCard(
                                  isPremium: subscription.premium,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        isEnglish
                                            ? subscription.enTitle
                                            : subscription.ruTitle,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 15,
                                        children: (isEnglish
                                                ? subscription.enBenefits
                                                : subscription.ruBenefits)
                                            .map((benefit) {
                                          return BenefitTile(title: benefit);
                                        }).toList(),
                                      ),
                                      const SizedBox(height: 10),
                                      TextButtonTypeOne(
                                        isLoading: isLoading,
                                          text:
                                              "${widget.isYearBilling ? isEnglish ? (subscription.amountPerMonthInYear / 100).toString() : subscription.amountPerMonthInYear.toString() : isEnglish ? (subscription.amountPerMonth / 100).toString() : subscription.amountPerMonth.toString()} ${isEnglish ? "\$" : "₽"}/${widget.isYearBilling ?
                                                  isEnglish ? "year" :"год"
                                                 : isEnglish ? "month" :"мес"}",
                                          onPressed: () {
                                            _subscribe(subscription);
                                          })
                                    ],
                                  ),
                                ));
                          }).toList()
                        : [Text("empty")],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
