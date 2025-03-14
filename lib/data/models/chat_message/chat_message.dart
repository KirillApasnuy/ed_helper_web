
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

import 'file_model.dart';

part 'chat_message.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class ChatMessage {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'text')
  String text;
  @JsonKey(ignore: true)
  final FileModel? attachFile;
  @JsonKey(ignore: true)
  final FileModel? audioFile;
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @JsonKey(name: 'audioUrl')
  final String? audioUrl;

  @JsonKey(name: 'user')
  final bool user;

  @JsonKey(name: 'timestamp')
  final DateTime timestamp;
  @JsonKey(ignore: true)
  bool isLoading;

  @JsonKey(name: 'media')
  final List<String>? images;

  ChatMessage({
    this.id,
    required this.text,
    this.attachFile,
    this.audioFile,
    this.imageUrl,
    this.audioUrl,
    required this.user,
    required this.timestamp,
    this.isLoading = false,
    this.images,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    id: (json['id'] as num?)?.toInt(),
    text: json['text'] as String? ?? '',
    user: json['user'] as bool,
    timestamp: DateTime.parse(json['timestamp'] as String),
    imageUrl: json['imageUrl'] as String?,
    audioUrl: json['audioUrl'] as String?,
    images:
    (json['media'] as List<dynamic>?)?.cast<String>(),
  );

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);

}