import 'package:json_annotation/json_annotation.dart';

part 'subscription_model.g.dart';

@JsonSerializable()
class SubscriptionModel {
  final int id;
  final String ruTitle;
  final String enTitle;
  final int limitGenerations;
  final List<String> ruBenefits;
  final List<String> enBenefits;
  final double amountPerMonth;
  final double amountPerMonthInYear;
  final bool accessInGroup;
  final bool tts;
  final bool premium;

  SubscriptionModel({
    required this.id,
    required this.ruTitle,
    required this.enTitle,
    required this.limitGenerations,
    required this.ruBenefits,
    required this.enBenefits,
    required this.amountPerMonth,
    required this.amountPerMonthInYear,
    required this.accessInGroup,
    required this.tts,
    required this.premium,
  });

  // Метод для десериализации JSON в объект
  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  // Метод для сериализации объекта в JSON
  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);
}