import 'package:ed_helper_web/data/models/chat_message/chat_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  int id;
  String title;
  final DateTime createdAt;
  List<ChatMessage> messages;

  ChatModel(
      {required this.id,
      required this.title,
      required this.createdAt,
      required this.messages});

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
