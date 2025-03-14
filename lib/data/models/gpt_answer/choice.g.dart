// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Choice _$ChoiceFromJson(Map<String, dynamic> json) => Choice(
      (json['index'] as num).toInt(),
      GptMessage.fromJson(json['message'] as Map<String, dynamic>),
      json['finish_reason'] as String,
    );

Map<String, dynamic> _$ChoiceToJson(Choice instance) => <String, dynamic>{
      'index': instance.id,
      'message': instance.message,
      'finish_reason': instance.finish_reason,
    };
