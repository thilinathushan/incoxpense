// ignore_for_file: library_private_types_in_public_api

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:incoxpense/models/transaction_model.dart';
import 'package:intl/intl.dart';
import '../../database/transaction_db.dart';

class LineChartSample extends StatefulWidget {
  const LineChartSample({super.key});

  @override
  _LineChartSampleState createState() => _LineChartSampleState();
}

class _LineChartSampleState extends State<LineChartSample> {
  List<TransactionModel> incomeTransactions = [];
  List<TransactionModel> expenseTransactions = [];
  bool isLoading = true;
  final TransactionDB _db = TransactionDB();

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    final income = await _db.fetchIncomeTransactions();
    final expense = await _db.fetchExpenseTransactions();

    setState(() {
      incomeTransactions = income;
      expenseTransactions = expense;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : AspectRatio(
            aspectRatio: 1.7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _generateLineSpots(incomeTransactions),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                    LineChartBarData(
                      spots: _generateLineSpots(expenseTransactions),
                      isCurved: true,
                      color: Colors.red,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              _formatYAxis(value),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: false), // Hide right Y-axis titles
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final DateTime date =
                              DateTime.fromMillisecondsSinceEpoch(
                                  value.toInt());
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              DateFormat.MMMd().format(date),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // borderData: FlBorderData(show: true),
                  // gridData: const FlGridData(show: false),
                  maxY: _getMaxY(),
                ),
              ),
            ),
          );
  }

  List<FlSpot> _generateLineSpots(List<TransactionModel> transactions) {
    Map<DateTime, double> groupedData = {};

    for (var transaction in transactions) {
      DateTime date = DateTime.parse(transaction.date);
      if (groupedData.containsKey(date)) {
        groupedData[date] = groupedData[date]! + transaction.amount;
      } else {
        groupedData[date] = transaction.amount;
      }
    }

    List<FlSpot> lineSpots = [];
    groupedData.forEach((date, amount) {
      lineSpots.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), amount));
    });

    return lineSpots;
  }

  double _getMaxY() {
    double maxY = 0;
    for (var transaction in incomeTransactions + expenseTransactions) {
      if (transaction.amount > maxY) {
        maxY = transaction.amount;
      }
    }
    return maxY;
  }

  String _formatYAxis(double value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    } else {
      return value.toStringAsFixed(0);
    }
  }
}
