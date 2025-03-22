import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  final int id;
  final DateTime date;
  final String name;
  final String? description;
  final int amount;

  Transaction({
    required this.id,
    required this.date,
    required this.name,
    this.description,
    required this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
