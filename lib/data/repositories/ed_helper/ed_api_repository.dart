import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ed_helper_web/data/models/chat_message/chat_message.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EdApiRepository {
  final String API_URL = dotenv.env['api_url'] ?? '';
  final Dio dio = Dio(BaseOptions(
    validateStatus: (status) {
      return true;
    },
  ));

  Future<Response> sendRequest(ChatMessage message, int? chatId) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("token") ?? "";
    if (authToken.isEmpty) throw Exception("No token");
    Map<String, dynamic> requestBody = {
      "text": message.text,
      "model": "gpt-4-turbo",
      "chatId": chatId,
      "assistantId": 4,
      "imageUrl": message.imageUrl,
      "audioUrl": message.audioUrl,
          };

    if (message.attachFile != null) requestBody["imageInBase64"] = "data:image/${message.attachFile!.fileName.split(".").last};base64,${base64Encode(message.attachFile!.bytes)}";
    print(requestBody["text"]);
    return await dio.post("${API_URL}/v1/message/send", options: Options(headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authToken",
    }),data: requestBody);
  }
}
//{
//     "text": "Как создать новый {OIJf[0sdopaksdopkasdект?",
//     "model": "gpt-4-turbo",
//     // "chatId": 1,
//     "assistantId": 4,
//     "chatId": 8
// }
