import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../models/transaction_model.dart';

class PieChartSample extends StatefulWidget {
  final List<TransactionModel> transactions;
  const PieChartSample({super.key, required this.transactions});

  @override
  State<PieChartSample> createState() => _PieChartSampleState();
}

class _PieChartSampleState extends State<PieChartSample> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          sections: _generatePieSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> _generatePieSections() {
    Map<String, double> categoryAmounts = {};

    for (var transaction in widget.transactions) {
      if (categoryAmounts.containsKey(transaction.category)) {
        categoryAmounts[transaction.category] =
            categoryAmounts[transaction.category]! + transaction.amount;
      } else {
        categoryAmounts[transaction.category] = transaction.amount;
      }
    }

    List<PieChartSectionData> pieSections = [];
    categoryAmounts.forEach((category, amount) {
      pieSections.add(
        PieChartSectionData(
          value: amount,
          title: category,
          color: _getCategoryColor(category, widget.transactions.first.type),
          // Colors.amber,
          radius: 60,
        ),
      );
    });
    return pieSections;
  }

  Color _getCategoryColor(String category, String type) {
    if (type == 'Expense') {
      switch (category) {
        case 'Vehicle':
          return const Color(0xFF42A5F5); // Light Blue for Vehicle
        case 'Clothing':
          return const Color(0xFFAB47BC); // Light Purple for Clothing
        case 'Domiciliary':
          return const Color(0xFFFFA726); // Light Orange for Domiciliary
        case 'Health':
          return const Color(0xFFEF5350); // Light Red for Health
        case 'Beauty':
          return const Color(0xFFEC407A); // Light Pink for Beauty
        case 'Kids':
          return const Color(0xFFFFEE58); // Light Yellow for Kids
        case 'Leisure':
          return const Color(0xFF26A69A); // Light Teal for Leisure
        case 'Sports':
          return const Color(0xFF66BB6A); // Light Green for Sports
        case 'Supermarket':
          return const Color(0xFF8D6E63); // Light Brown for Supermarket
        case 'Transport':
          return const Color(0xFF29B6F6); // Light Cyan for Transport
        default:
          return const Color(0xFFBDBDBD); // Light Gray for undefined categories
      }
    } else {
      switch (category) {
        case 'Salary':
          return const Color(0xFF42A5F5); // Light Blue for Salary
        case 'Business':
          return const Color(0xFFAB47BC); // Light Purple for Business
        case 'Rental Income':
          return const Color(0xFF66BB6A); // Light Green for Rental Income
        default:
          return const Color(0xFFBDBDBD); // Light Gray for undefined categories
      }
    }
  }
}
