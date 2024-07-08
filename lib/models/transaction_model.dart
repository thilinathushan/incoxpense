// ignore_for_file: constant_identifier_names, non_constant_identifier_names

const String tblName = "transactions";

const String idField = "_id";
const String typeField = "type";
const String dateField = "date";
const String categoryField = "category";
const String amountField = "amount";
const String noteField = "note";
const String created_atField = "created_at";

const List<String> transactionColumns = [
  idField,
  typeField,
  dateField,
  categoryField,
  amountField,
  noteField,
  created_atField,
];

const String boolType = "BOOLEAN NOT NULL";
const String idType = "INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT";
const String textTypeNullable = "TEXT";
const String textType = "TEXT NOT NULL";
const String created_atType =
    "INTEGER NOT NULL DEFAULT (cast(strftime('%s','now') as integer))";

class TransactionModel {
  final int? id;
  final String type;
  final String date;
  final String category;
  final double amount;
  final String? note;
  final String? created_at;

  TransactionModel({
    this.id,
    required this.type,
    required this.date,
    required this.category,
    required this.amount,
    this.note,
    this.created_at,
  });

  static TransactionModel fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json[idField] as int?,
        type: json[typeField] as String,
        date: json[dateField] as String,
        category: json[categoryField] as String,
        amount: json[amountField] as double,
        note: json[noteField] as String?,
      );

  Map<String, dynamic> toJson() => {
        idField: id,
        typeField: type,
        dateField: date,
        categoryField: category,
        amountField: amount,
        noteField: note,
        created_atField: created_at,
      };

  TransactionModel copyWith({
    int? id,
    String? type,
    String? date,
    String? category,
    double? amount,
    String? note,
  }) =>
      TransactionModel(
        id: id ?? this.id,
        type: type ?? this.type,
        date: date ?? this.date,
        category: category ?? this.category,
        amount: amount ?? this.amount,
        note: note ?? this.note,
      );

  factory TransactionModel.fromSqfliteDatabase(Map<String, dynamic> map) =>
      TransactionModel(
        id: map[idField]?.toInt() ?? 0,
        type: map[typeField] ?? '',
        date: map[dateField] ?? '',
        category: map[categoryField] ?? '',
        amount: map[amountField] ?? 0.0,
        note: map[noteField] ?? '',
        created_at: DateTime.fromMicrosecondsSinceEpoch(map[created_atField])
            .toIso8601String(),
      );
}
