// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileModel _$FileModelFromJson(Map<String, dynamic> json) => FileModel(
      json['fileName'] as String,
      FileModel._bytesFromJson(json['bytes'] as List<int>),
    );

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
      'fileName': instance.fileName,
      'bytes': FileModel._bytesToJson(instance.bytes),
    };
