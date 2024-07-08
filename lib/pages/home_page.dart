import 'dart:async';
import 'package:flutter/material.dart';
import '../app_style.dart';
import '../widgets/card_chart.dart';
import '../widgets/card_summary.dart';
import '../database/transaction_db.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TransactionDB _db = TransactionDB();

  Future<Map<String, String>> _fetchIncomeAndExpense() async {
    final income = await _db.fetchIncomeTransactionsTotal();
    final expense = await _db.fetchExpenseTransactionsTotal();
    return {
      'income': income.toString(),
      'expense': expense.toString(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _fetchIncomeAndExpense(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available.'));
        }

        final data = snapshot.data!;
        final income = data['income'] ?? '0';
        final expense = data['expense'] ?? '0';

        return SingleChildScrollView(
          child: Column(
            children: [
              CardSummary(income: income, expense: expense),
              CardChart(
                cardTitle: "Evolution of Income",
                transactions: _db.fetchIncomeTransactions(),
                chartType: 'bar',
                chartColor: primaryIncome,
              ),
              CardChart(
                cardTitle: "Evolution of Expense",
                transactions: _db.fetchExpenseTransactions(),
                chartType: 'bar',
                chartColor: primaryExpense,
              ),
            ],
          ),
        );
      },
    );
  }
}
