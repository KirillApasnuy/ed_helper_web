// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gpt_usage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GptUsage _$GptUsageFromJson(Map<String, dynamic> json) => GptUsage(
      (json['prompt_tokens'] as num).toInt(),
      (json['completion_tokens'] as num).toInt(),
      (json['total_tokens'] as num).toInt(),
    );

Map<String, dynamic> _$GptUsageToJson(GptUsage instance) => <String, dynamic>{
      'prompt_tokens': instance.prompt_tokens,
      'completion_tokens': instance.completion_tokens,
      'total_tokens': instance.total_tokens,
    };
