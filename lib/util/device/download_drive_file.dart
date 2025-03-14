import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GoogleDriveFileViewer extends StatefulWidget {
  final String fileId;

  const GoogleDriveFileViewer({Key? key, required this.fileId}) : super(key: key);

  @override
  _GoogleDriveFileViewerState createState() => _GoogleDriveFileViewerState();
}

class _GoogleDriveFileViewerState extends State<GoogleDriveFileViewer> {
  Uint8List? fileBytes;
  String? fileUrl;

  @override
  void initState() {
    super.initState();
    downloadFile();
  }

  Future<void> downloadFile() async {
    final String url = "https://docs.google.com/uc?export=download&id=${widget.fileId}";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          fileBytes = response.bodyBytes;
          fileUrl = url;
        });
      } else {
        print("Ошибка загрузки файла: ${response.statusCode}");
      }
    } catch (e) {
      print("Ошибка: $e");
    }
  }

  void downloadToDevice() {
    if (fileBytes != null) {
      final blob = html.Blob([fileBytes!]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "downloaded_file")
        ..click();
      html.Url.revokeObjectUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (fileBytes != null)
          Image.memory(fileBytes!) // Отображение, если это изображение
        else
          const CircularProgressIndicator(),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: downloadToDevice,
          child: const Text("Скачать файл"),
        ),
      ],
    );
  }
}
