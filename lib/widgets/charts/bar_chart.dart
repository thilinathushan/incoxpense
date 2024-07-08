import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:incoxpense/models/transaction_model.dart';

class BarChartSample extends StatelessWidget {
  final List<TransactionModel> transactions;
  final Color color;

  const BarChartSample({
    super.key,
    required this.transactions,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: _getMaxY(),
            barGroups: _generateBarGroups(),
            borderData: FlBorderData(
              show: false,
            ),
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
                sideTitles:
                    SideTitles(showTitles: false), // Hide right Y-axis titles
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  // reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    final DateTime date =
                        DateTime.fromMillisecondsSinceEpoch(value.toInt());
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
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    Map<String, double> groupedData = {};

    for (var transaction in transactions) {
      if (groupedData.containsKey(transaction.date)) {
        groupedData[transaction.date] =
            groupedData[transaction.date]! + transaction.amount;
      } else {
        groupedData[transaction.date] = transaction.amount;
      }
    }

    List<BarChartGroupData> barGroups = [];
    groupedData.forEach((date, amount) {
      final DateTime parsedDate = DateTime.parse(date);
      barGroups.add(
        BarChartGroupData(
          x: parsedDate
              .millisecondsSinceEpoch, // Use the timestamp as the X value
          barRods: [
            BarChartRodData(
              toY: amount,
              color: color,
              width: 16,
            ),
          ],
        ),
      );
    });

    return barGroups;
  }

  double _getMaxY() {
    double maxY = 0;
    for (var transaction in transactions) {
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
