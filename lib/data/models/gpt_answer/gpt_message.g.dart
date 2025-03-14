// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gpt_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GptMessage _$GptMessageFromJson(Map<String, dynamic> json) => GptMessage(
      json['role'] as String,
      json['content'] as String,
    );

Map<String, dynamic> _$GptMessageToJson(GptMessage instance) =>
    <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
    };
