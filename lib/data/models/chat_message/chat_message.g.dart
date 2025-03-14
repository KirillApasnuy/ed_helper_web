// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      id: (json['id'] as num?)?.toInt(),
      text: json['text'] as String,
      imageUrl: json['imageUrl'] as String?,
      audioUrl: json['audioUrl'] as String?,
      user: json['user'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
      images:
          (json['media'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'imageUrl': instance.imageUrl,
      'audioUrl': instance.audioUrl,
      'user': instance.user,
      'timestamp': instance.timestamp.toIso8601String(),
      'media': instance.images,
    };
