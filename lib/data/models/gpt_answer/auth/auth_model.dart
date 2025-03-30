import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel {

  final String email;
  final String? password;
  final String? name;
  final bool isReceivedEmail;

  AuthModel( {required this.email, this.name, this.password, this.isReceivedEmail = false});


  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}