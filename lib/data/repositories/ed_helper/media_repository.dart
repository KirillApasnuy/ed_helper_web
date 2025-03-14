import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MediaRepository {
  final String API_URL = dotenv.env['api_url'] ?? '';
  final Dio dio = Dio(BaseOptions(
    validateStatus: (status) {
      return true;
    },
  ));

  Future<http.StreamedResponse> uploadFile(
      html.File file, String fileName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("token") ?? "";
    if (authToken.isEmpty) throw Exception("No token");
    try {
      var uri = Uri.parse(
        '${API_URL}/v1/media/user/upload',
      );
      var request = http.MultipartRequest(
        'POST',
        uri,
      );

      var stream = await blobToStream(file);
      var length = file.size;
      var multipartFile = http.MultipartFile(
        'file', // Имя поля, должно совпадать с @RequestParam("file")
        stream,
        length,
        filename: fileName,
        contentType: MediaType(
            fileName.split('.').last == "wav" ? 'audio/wav' : 'image',
            fileName.split('.').last), // Укажите правильный MIME-тип
      );

      request.files.add(multipartFile);
      request.headers.addAll({
        'Authorization': 'Bearer $authToken',
      });

      return await request.send();
    } catch (e) {
      print(e);
      print('Ошибка отправки файла: $e');
      throw Exception('Ошибка отправки файла');
    }
  }

  //
  // Future<http.StreamedResponse> uploadAudioFile(html.File file, String fileName) async {
  //   // Получаем токен из SharedPreferences
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String authToken = prefs.getString("token") ?? "";
  //   if (authToken.isEmpty) throw Exception("No token");
  //
  //   try {
  //     // Формируем URL
  //     var uri = Uri.parse('${API_URL}/v1/media/user/upload');
  //
  //     // Создаем multipart запрос
  //     var request = http.MultipartRequest('POST', uri)
  //       ..headers['Authorization'] = 'Bearer $authToken';
  //
  //     final stream = file.slice().cast<List<int>>();
  //
  //     // Добавляем файл в запрос
  //     var multipartFile = http.MultipartFile(
  //       'file', // Имя поля файла на сервере
  //       stream,
  //       file.size, // Размер файла
  //       filename: fileName, // Имя файла
  //       contentType: MediaType('audio', 'wav'), // Указываем MIME-тип для аудио
  //     );
  //     request.files.add(multipartFile);
  //
  //     // Отправляем запрос
  //     return await request.send();
  //   } catch (e) {
  //     print("Ошибка: $e");
  //     throw Exception('Ошибка отправки файла');
  //   }
  // }

  Future<Stream<List<int>>> blobToStream(html.Blob blob) async {
    final reader = html.FileReader();

    // Create a completer to handle the asynchronous operation
    final completer = Completer<Stream<List<int>>>();

    reader.onLoadEnd.listen((event) {
      // When the reading is complete, convert the result to a Uint8List
      final uint8List = reader.result as Uint8List;
      completer.complete(Stream<List<int>>.fromIterable([uint8List]));
    });

    reader.readAsArrayBuffer(blob); // Start reading the Blob as an ArrayBuffer

    return completer.future; // Return the future of the stream
  }
}
