import 'package:json_annotation/json_annotation.dart';

import 'gpt_message.dart';

part 'choice.g.dart';

@JsonSerializable()
class Choice {

  @JsonKey(name: 'index')
  final int id;
  final GptMessage message;
  final String finish_reason;

  Choice(this.id, this.message, this.finish_reason);

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceToJson(this);
}