
import 'package:json_annotation/json_annotation.dart';

part 'gpt_message.g.dart';

@JsonSerializable()
class GptMessage {
  final String role;
  final String content;

  GptMessage(this.role, this.content);

  factory GptMessage.fromJson(Map<String, dynamic> json) => _$GptMessageFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GptMessageToJson(this);

}