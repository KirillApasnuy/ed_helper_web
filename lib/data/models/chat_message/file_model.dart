import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';

part 'file_model.g.dart';

@JsonSerializable()
class FileModel {
  final String fileName;

  @JsonKey(
    fromJson: _bytesFromJson,
    toJson: _bytesToJson,
  )
  final Uint8List bytes;

  FileModel(this.fileName, this.bytes);

  factory FileModel.fromJson(Map<String, dynamic> json) =>
      _$FileModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileModelToJson(this);

  // Преобразование Uint8List в List<int> для JSON
  static Uint8List _bytesFromJson(List<int> bytes) => Uint8List.fromList(bytes);

  // Преобразование List<int> в Uint8List из JSON
  static List<int> _bytesToJson(Uint8List bytes) => bytes.toList();
}