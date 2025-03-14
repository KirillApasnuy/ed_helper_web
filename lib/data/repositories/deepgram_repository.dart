import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DeepgramRepository {
  final String apiKey = dotenv.env['deepgram_api']!; // Заменить на свой API-ключ

  Future<String> transcribeAudio(html.File audioFile) async {
    final uri = Uri.parse(
        'https://api.deepgram.com/v1/listen?model=nova-2&smart_format=true&language=ru');

    final request = http.Request('POST', uri)
      ..headers.addAll({
        'Authorization': 'Token $apiKey',
        'Content-Type': 'audio/wav',
      });

    // Чтение файла как ArrayBuffer и преобразование в List<int>
    final fileReader = html.FileReader();
    fileReader.readAsArrayBuffer(audioFile);
    await fileReader.onLoad.first;
    final fileBytes = fileReader.result as List<int>;

    request.bodyBytes = fileBytes;

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(responseData);
      return jsonResponse['results']['channels'][0]['alternatives'][0]['transcript'];
    } else {
      print(response.statusCode);
      print(response.toString());
      print(await response.stream.bytesToString());
      throw Exception('Failed to transcribe audio');
    }
  }
}

