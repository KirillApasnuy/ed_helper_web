// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
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
      accessInGroup: json['accessInGroup'] as bool,
      premium: json['premium'] as bool,
      tts: json['tts'] as bool,
    );

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ruTitle': instance.ruTitle,
      'enTitle': instance.enTitle,
      'limitGenerations': instance.limitGenerations,
      'ruBenefits': instance.ruBenefits,
      'enBenefits': instance.enBenefits,
      'amountPerMonth': instance.amountPerMonth,
      'amountPerMonthInYear': instance.amountPerMonthInYear,
      'accessInGroup': instance.accessInGroup,
      'premium': instance.premium,
      'tts': instance.tts,
    };
