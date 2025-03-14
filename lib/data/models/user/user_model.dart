import 'package:json_annotation/json_annotation.dart';

import 'subscription.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int id;
  final String dateCreated;
  final String userType;
  String email;
  final int? uploadFolderId;
  final int usedTokensInPeriod;
  final int usedTokensInPeriodInLastMonth;
  final int countGenerationInLastMonth;
  String subscribeState;
  String? paidStartDate;
  String? paidEndDate;
  final String? reasonForBlocked;
  final bool? emailVerified;
  Subscription? subscription;
  final bool autoRenewal;
  final bool? receiveEmail;
  final bool blocked;

  UserModel({
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
    this.receiveEmail,
    required this.blocked,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}