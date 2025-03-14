import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

class WebAudioRecorder {
  html.MediaRecorder? _mediaRecorder;
  List<html.Blob> _audioChunks = [];
  late html.MediaStream _mediaStream;

  Future<void> startRecording() async {
    try {
      // Запрашиваем доступ к микрофону
      _mediaStream = await html.window.navigator.mediaDevices!
          .getUserMedia({"audio": true});

      // Создаем MediaRecorder
      _mediaRecorder = html.MediaRecorder(_mediaStream);
      _audioChunks.clear();

      // Слушаем событие dataavailable для получения аудиоданных
      _mediaRecorder!.addEventListener('dataavailable', (event) {
        final blobEvent = event as html.BlobEvent;
        if (blobEvent.data != null) {
          _audioChunks.add(blobEvent.data!);
        }
      });

      // Начинаем запись
      _mediaRecorder!.start();
      print("🎤 Запись началась...");
    } catch (e) {
      print("Ошибка при доступе к микрофону: $e");
    }
  }

  Future<Uint8List?> stopRecording() async {
    if (_mediaRecorder != null && _mediaRecorder!.state == "recording") {
      // Останавливаем запись
      _mediaRecorder!.stop();

      // Ждем завершения обработки данных
      await Future.delayed(Duration(milliseconds: 100));

      // Останавливаем микрофон
      _mediaStream.getTracks().forEach((track) => track.stop());

      if (_audioChunks.isNotEmpty) {
        // Создаем Blob из собранных данных
        final audioBlob = html.Blob(_audioChunks, 'audio/wav');

        // Преобразуем Blob в Uint8List
        final audioData = await _blobToUint8List(audioBlob);

        print("🎤 Запись завершена и сохранена.");
        return audioData;
      } else {
        print("⚠️ Ошибка: нет данных для сохранения.");
        return null;
      }
    }
    return null;
  }

  Future<Uint8List> _blobToUint8List(html.Blob blob) async {
    final reader = html.FileReader();
    final completer = Completer<Uint8List>();

    // Слушаем событие завершения чтения
    reader.onLoadEnd.listen((_) {
      if (reader.result != null) {
        completer.complete(reader.result as Uint8List);
      } else {
        completer.completeError("Failed to read blob");
      }
    });

    // Начинаем чтение Blob как ArrayBuffer
    reader.readAsArrayBuffer(blob);

    // Возвращаем Future, который завершится, когда данные будут прочитаны
    return completer.future;
  }

  Future<void> _saveToLocalStorage(Uint8List audioData) async {
    // Преобразуем Uint8List в base64
    final base64Data = html.window.btoa(String.fromCharCodes(audioData));

    // Сохраняем в localStorage
    html.window.localStorage['saved_audio'] = base64Data;
  }

  String? getSavedAudio() {
    // Получаем данные из localStorage
    final encodedData = html.window.localStorage['saved_audio'];
    if (encodedData != null) {
      return "data:audio/wav;base64,$encodedData";
    }
    return null;
  }
}