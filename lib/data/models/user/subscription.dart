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

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    id: (json['id'] as num).toInt(),
    ruTitle: json['ruTitle'] as String,
    enTitle: json['enTitle'] as String,
    limitGenerations: (json['limitGenerations'] as num).toInt(),
    ruBenefits: (json['ruBenefits'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    enBenefits: (json['enBenefits'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    amountPerMonth: (json['amountPerMonth'] as num).toDouble(),
    amountPerMonthInYear: (json['amountPerMonthInYear'] as num).toDouble(),
    accessInGroup: json['accessInGroup'] as bool? ?? false,
    premium: json['premium'] as bool? ?? false,
    tts: json['tts'] as bool? ?? false,
  );

  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);
}
