import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatGptRepositories {
  static final String url = "https://api.openai.com/v1/chat/completions";
  static final String ttsUrl = "https://api.openai.com/v1/audio/speech";
  static final String apiKey = dotenv.env['openai_api'] ?? '';
  final String API_URL = dotenv.env['API_URL'] ?? '';
  static final Dio dio = Dio();

  static Future<Response> sendMessage(
      {required String text, File? imageFile}) async {
    if (apiKey.isEmpty) {
      throw Exception("API key is missing");
    }

    List<Map<String, dynamic>> content = [
      {"type": "text", "text": text}
    ];

    if (imageFile != null) {
      String base64Image = base64Encode(await imageFile.readAsBytes());
      content.add({
        "type": "image_url",
        "image_url": {
          "url":
              "data:image/${imageFile.path.split('.').last};base64,$base64Image"
        }
      });
    }

    return await dio.post(url,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey",
        }),
        data: {
          "model": "gpt-4o",
          "messages": [
            {"role": "user", "content": content}
          ]
        });
  }

  static Future<Response> synthesizeSpeech(
      {required String text, String voice = "alloy"}) async {
    if (apiKey.isEmpty) {
      throw Exception("API key is missing");
    }
    return await dio.post(
      ttsUrl,
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      }, responseType: ResponseType.bytes),
      data: {"model": "tts-1", "input": text, "voice": voice},
    );
  }
}
