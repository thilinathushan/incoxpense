import 'package:flutter/material.dart';
import '../database/transaction_db.dart';
import '../models/transaction_model.dart';
import '../widgets/card_transaction.dart';
import '../components/layouts/main_layout.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final db = TransactionDB();

  void _deleteTask(int id) async {
    db.delete(id);
    NavigatorState? navigatorState = Navigator.maybeOf(context);
    if (navigatorState != null) {
      navigatorState
        ..pop()
        ..push(
          MaterialPageRoute(
            builder: (context) => MainLayout(
              selectedIndex: 1,
            ),
          ),
      );
    }
  }

  @override
  Widget build(Object context) {
    return _transactionsList();
  }

  Widget _transactionsList() {
    return FutureBuilder(
      future: db.fetchAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No transactions available.'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            TransactionModel transactionModel = snapshot.data![index];
            return GestureDetector(
              onTap: () {
                // print(transactionModel.id);
              },
              child: CardTransaction(
                type: transactionModel.type,
                date: transactionModel.date,
                category: transactionModel.category,
                amount: transactionModel.amount,
                note: transactionModel.note,
                deleteFunction: (context) => _deleteTask(transactionModel.id!),
              ),
            );
          },
        );
      },
    );
  }
}
