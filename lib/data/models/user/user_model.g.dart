// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num).toInt(),
      dateCreated: json['dateCreated'] as String,
      userType: json['userType'] as String,
      email: json['email'] as String,
      uploadFolderId: (json['uploadFolderId'] as num?)?.toInt(),
      usedTokensInPeriod: (json['usedTokensInPeriod'] as num).toInt(),
      usedTokensInPeriodInLastMonth:
          (json['usedTokensInPeriodInLastMonth'] as num).toInt(),
      countGenerationInLastMonth:
          (json['countGenerationInLastMonth'] as num).toInt(),
      subscribeState: json['subscribeState'] as String,
      paidStartDate: json['paidStartDate'] as String?,
      paidEndDate: json['paidEndDate'] as String?,
      reasonForBlocked: json['reasonForBlocked'] as String?,
      emailVerified: json['emailVerified'] as bool?,
      subscription: json['subscription'] == null
          ? null
          : Subscription.fromJson(json['subscription'] as Map<String, dynamic>),
      autoRenewal: json['autoRenewal'] as bool,
      receiveEmail: json['receiveEmail'] as bool?,
      blocked: json['blocked'] as bool,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'dateCreated': instance.dateCreated,
      'userType': instance.userType,
      'email': instance.email,
      'uploadFolderId': instance.uploadFolderId,
      'usedTokensInPeriod': instance.usedTokensInPeriod,
      'usedTokensInPeriodInLastMonth': instance.usedTokensInPeriodInLastMonth,
      'countGenerationInLastMonth': instance.countGenerationInLastMonth,
      'subscribeState': instance.subscribeState,
      'paidStartDate': instance.paidStartDate,
      'paidEndDate': instance.paidEndDate,
      'reasonForBlocked': instance.reasonForBlocked,
      'emailVerified': instance.emailVerified,
      'subscription': instance.subscription,
      'autoRenewal': instance.autoRenewal,
      'receiveEmail': instance.receiveEmail,
      'blocked': instance.blocked,
    };
