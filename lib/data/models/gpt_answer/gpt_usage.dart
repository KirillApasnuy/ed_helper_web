import 'package:json_annotation/json_annotation.dart';

part 'gpt_usage.g.dart';

@JsonSerializable()
class GptUsage {
  final int prompt_tokens;
  final int completion_tokens;
  final int total_tokens;

  GptUsage(this.prompt_tokens, this.completion_tokens, this.total_tokens);

  factory GptUsage.fromJson(Map<String, dynamic> json) => _$GptUsageFromJson(json);

  Map<String, dynamic> toJson() => _$GptUsageToJson(this);
}