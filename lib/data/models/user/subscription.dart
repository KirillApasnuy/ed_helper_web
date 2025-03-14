import 'package:json_annotation/json_annotation.dart';

part 'subscription.g.dart';
@JsonSerializable()
class Subscription {
  final int id;
  final String ruTitle;
  final String enTitle;
  final int limitGenerations;
  final List<String> ruBenefits;
  final List<String> enBenefits;
  final double amountPerMonth;
  final double amountPerMonthInYear;
  final bool accessInGroup;
  final bool premium;
  final bool tts;

  Subscription({
    required this.id,
    required this.ruTitle,
    required this.enTitle,
    required this.limitGenerations,
    required this.ruBenefits,
    required this.enBenefits,
    required this.amountPerMonth,
    required this.amountPerMonthInYear,
    required this.accessInGroup,
    required this.premium,
    required this.tts,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);
}
