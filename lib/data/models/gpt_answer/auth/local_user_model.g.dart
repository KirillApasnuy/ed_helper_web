// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalUserModel _$LocalUserModelFromJson(Map<String, dynamic> json) =>
    LocalUserModel(
      id: (json['id'] as num).toInt(),
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      userType: json['userType'] as String,
      email: json['email'] as String,
      uploadFolderId: (json['uploadFolderId'] as num?)?.toInt(),
      usedTokensInPeriod: (json['usedTokensInPeriod'] as num).toInt(),
      usedTokensInPeriodInLastMonth:
          (json['usedTokensInPeriodInLastMonth'] as num).toInt(),
      countGenerationInLastMonth:
          (json['countGenerationInLastMonth'] as num).toInt(),
      subscribeState: json['subscribeState'] as String,
      paidStartDate: DateTime.parse(json['paidStartDate'] as String),
      paidEndDate: DateTime.parse(json['paidEndDate'] as String),
      reasonForBlocked: json['reasonForBlocked'] as String?,
      emailVerified: json['emailVerified'] as bool,
      subscription: (json['subscription'] as List<dynamic>)
          .map((e) => SubscriptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      autoRenewal: json['autoRenewal'] as bool,
      blocked: json['blocked'] as bool,
    );

Map<String, dynamic> _$LocalUserModelToJson(LocalUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'userType': instance.userType,
      'email': instance.email,
      'uploadFolderId': instance.uploadFolderId,
      'usedTokensInPeriod': instance.usedTokensInPeriod,
      'usedTokensInPeriodInLastMonth': instance.usedTokensInPeriodInLastMonth,
      'countGenerationInLastMonth': instance.countGenerationInLastMonth,
      'subscribeState': instance.subscribeState,
      'paidStartDate': instance.paidStartDate.toIso8601String(),
      'paidEndDate': instance.paidEndDate.toIso8601String(),
      'reasonForBlocked': instance.reasonForBlocked,
      'emailVerified': instance.emailVerified,
      'subscription': instance.subscription,
      'autoRenewal': instance.autoRenewal,
      'blocked': instance.blocked,
    };
