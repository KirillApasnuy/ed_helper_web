// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: (json['id'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      name: json['name'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toInt(),
      paymentCardNumber: json['paymentCardNumber'] as String,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'name': instance.name,
      'description': instance.description,
      'amount': instance.amount,
      'paymentCardNumber': instance.paymentCardNumber,
    };
