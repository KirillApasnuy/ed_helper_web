import 'package:json_annotation/json_annotation.dart';

import '../subscribe/subscription_model.dart';

part 'local_user_model.g.dart'; // Файл, который сгенерирует build_runner

@JsonSerializable()
class LocalUserModel {
  final int id;
  final DateTime dateCreated;
  final String userType;
  final String email;
  final int? uploadFolderId;
  final int usedTokensInPeriod;
  final int usedTokensInPeriodInLastMonth;
  final int countGenerationInLastMonth;
  final String subscribeState;
  final DateTime paidStartDate;
  final DateTime paidEndDate;// Уточните тип, если возможно
  final String? reasonForBlocked;
  final bool emailVerified;
  final List<SubscriptionModel> subscription;
  final bool autoRenewal;
  final bool blocked;

  LocalUserModel({
    required this.id,
    required this.dateCreated,
    required this.userType,
    required this.email,
    this.uploadFolderId,
    required this.usedTokensInPeriod,
    required this.usedTokensInPeriodInLastMonth,
    required this.countGenerationInLastMonth,
    required this.subscribeState,
    required this.paidStartDate,
    required this.paidEndDate,
    this.reasonForBlocked,
    required this.emailVerified,
    required this.subscription,
    required this.autoRenewal,
    required this.blocked,
  });

  // Метод для десериализации JSON в объект
  factory LocalUserModel.fromJson(Map<String, dynamic> json) =>
      _$LocalUserModelFromJson(json);

  // Метод для сериализации объекта в JSON
  Map<String, dynamic> toJson() => _$LocalUserModelToJson(this);
}

