import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class ChatGptService{
  static Future<File> saveSpeechToFile(Response response, Uint8List bytes) async {
    File file = File.fromRawPath(bytes);
    await file.writeAsBytes(response.data);
    return file;
  }
}