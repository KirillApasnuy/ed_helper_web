// import 'dart:typed_data';
// import 'dart:html' as html;
// import 'package:flutter/material.dart';
// import 'package:googleapis/drive/v3.dart' as drive;
// import 'package:googleapis_auth/auth_browser.dart' as auth;
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   Uint8List? fileData;
//   String? fileName;
//
//   Future<void> downloadFile(String fileId) async {
//     final client = await auth.clientViaUserConsent(
//       auth.ClientId('YOUR_CLIENT_ID', ''),
//       [drive.DriveApi.driveFileScope],
//           (url) => html.window.open(url, "_blank"),
//     );
//
//     final driveApi = drive.DriveApi(client);
//
//     final media = await driveApi.files.get(
//       fileId,
//       downloadOptions: drive.DownloadOptions.fullMedia,
//     ) as drive.Media;
//
//     final List<int> dataStore = [];
//     await for (var chunk in media.stream) {
//       dataStore.addAll(chunk);
//     }
//
//     final Uint8List bytes = Uint8List.fromList(dataStore);
//     setState(() {
//       fileData = bytes;
//       fileName = "downloaded_file.jpg"; // Измените расширение при необходимости
//     });
//
//     // Сохранение файла на устройстве
//     final blob = html.Blob([bytes]);
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     final anchor = html.AnchorElement(href: url)
//       ..setAttribute("download", fileName!)
//       ..click();
//     html.Url.revokeObjectUrl(url);
//
//     client.close();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Google Drive File Viewer')),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () => downloadFile('YOUR_FILE_ID'),
//                 child: Text('📥 Скачать файл'),
//               ),
//               SizedBox(height: 20),
//               fileData != null
//                   ? Image.memory(fileData!)
//                   : Text('Файл не загружен'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
