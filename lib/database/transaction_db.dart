import 'package:flutter/material.dart';
import 'app_database.dart';
import 'package:sqflite/sqflite.dart';
import '../models/transaction_model.dart';
import 'dart:async';

const String tblName = "transactions";

const String idField = "_id";
const String typeField = "type";
const String dateField = "date";
const String categoryField = "category";
const String amountField = "amount";
const String noteField = "note";
// ignore: constant_identifier_names
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

class TransactionDB extends ChangeNotifier {
  Future<void> createTable(Database database) async {
    await database.execute('''
        CREATE TABLE IF NOT EXISTS $tblName(
          $idField INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          $typeField TEXT NOT NULL,
          $dateField TEXT NOT NULL,
          $categoryField TEXT NOT NULL,
          $amountField DECIMAL(15,2) NOT NULL,
          $noteField TEXT,
          $created_atField INTEGER NOT NULL DEFAULT (cast(strftime('%s','now') as integer))
        );
      ''');
  }

  Future<int> create(TransactionModel transactionModel) async {
    final db = await AppDatabase().database;
    final id = await db.insert(tblName, transactionModel.toJson());
    fetchAll();
    return id;
  }

  Future<List<TransactionModel>> fetchAll() async {
    final db = await AppDatabase().database;
    final result =
        await db.rawQuery('SELECT * FROM $tblName ORDER BY $dateField DESC');
    // print(result);
    List<TransactionModel> transactions = result
        .map((e) => TransactionModel(
              id: e["_id"] as int?,
              type: e["type"] as String,
              date: e["date"] as String,
              category: e["category"] as String,
              amount: double.parse(e["amount"].toString()),
              note: e["note"] as String?,
            ))
        .toList();
    return transactions;
  }

  // Future<TransactionModel> fetchById(int id) async {
  //   final db = await AppDatabase().database;
  //   final result =
  //       await db.rawQuery('SELECT * FROM $tblName WHERE $idField = ?', [id]);
  //   if (result.isNotEmpty) {
  //     return TransactionModel.fromSqfliteDatabase(result.first);
  //   } else {
  //     throw Exception('ID $id not found');
  //   }
  // }

  // Future<int> update(TransactionModel transactionModel) async {
  //   final db = await AppDatabase().database;
  //   final id = await db.update(
  //     tblName,
  //     transactionModel.toJson(),
  //     where: '$idField = ?',
  //     whereArgs: [transactionModel.id],
  //     conflictAlgorithm: ConflictAlgorithm.rollback,
  //   );
  //   return id;
  // }

  Future<void> delete(int id) async {
    final db = await AppDatabase().database;
    await db.delete(tblName, where: '$idField = ?', whereArgs: [id]);
  }

  Future<String> fetchIncomeTransactionsTotal() async {
    double totalIncome = 0;
    final db = await AppDatabase().database;
    final result = await db.rawQuery(
        'SELECT * FROM $tblName WHERE $typeField = "Income" ORDER BY $dateField DESC');

    for (var element in result) {
      totalIncome = totalIncome + double.parse(element['amount'].toString());
    }
    // print("Rs:  $totalIncome");
    return totalIncome.toStringAsFixed(2);
  }

  Future<String> fetchExpenseTransactionsTotal() async {
    double totalExpense = 0;
    final db = await AppDatabase().database;
    final result = await db.rawQuery(
        'SELECT * FROM $tblName WHERE $typeField = "Expense" ORDER BY $dateField DESC');

    for (var element in result) {
      totalExpense = totalExpense + double.parse(element['amount'].toString());
    }
    // print("Rs:  $totalExpense");
    return totalExpense.toStringAsFixed(2);
  }

  Future<List<TransactionModel>> fetchIncomeTransactions() async {
    final db = await AppDatabase().database;
    final result = await db.rawQuery(
        'SELECT * FROM $tblName WHERE $typeField = "Income" ORDER BY $dateField ASC');

    List<TransactionModel> transactions = result
        .map((e) => TransactionModel(
              id: e["_id"] as int?,
              type: e["type"] as String,
              date: e["date"] as String,
              category: e["category"] as String,
              amount: double.parse(e["amount"].toString()),
              note: e["note"] as String?,
            ))
        .toList();
    // print(result);
    return transactions;
  }

  Future<List<TransactionModel>> fetchExpenseTransactions() async {
    final db = await AppDatabase().database;
    final result = await db.rawQuery(
        'SELECT * FROM $tblName WHERE $typeField = "Expense" ORDER BY $dateField ASC');

    List<TransactionModel> transactions = result
        .map((e) => TransactionModel(
              id: e["_id"] as int?,
              type: e["type"] as String,
              date: e["date"] as String,
              category: e["category"] as String,
              amount: double.parse(e["amount"].toString()),
              note: e["note"] as String?,
            ))
        .toList();
    // print(result);
    return transactions;
  }
}
