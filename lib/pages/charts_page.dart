import 'package:flutter/material.dart';
import '../app_style.dart';
import '../widgets/card_chart.dart';
import '../database/transaction_db.dart';

class ChartsPage extends StatelessWidget {
  ChartsPage({super.key});

  final TransactionDB _db = TransactionDB();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CardChart(
              cardTitle: "Evolution of Incomes",
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
            CardChart(
              cardTitle: "Evolution of Transactions",
              transactions: _db.fetchIncomeTransactions(),
              chartType: 'line',
            ),
            CardChart(
              cardTitle: "Deviation of Incomes",
              transactions: _db.fetchIncomeTransactions(),
              chartType: 'pie',
            ),
            CardChart(
              cardTitle: "Deviation of Expenses",
              transactions: _db.fetchExpenseTransactions(),
              chartType: 'pie',
            ),
          ],
        ),
      ),
    );
  }
}
