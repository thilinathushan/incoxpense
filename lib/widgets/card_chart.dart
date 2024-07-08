// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'charts/pie_chart.dart';
import '../app_style.dart';
import '../models/transaction_model.dart';
import '../size_config.dart';
import '../widgets/charts/bar_chart.dart';
import 'charts/line_chart.dart';

class CardChart extends StatefulWidget {
  final String cardTitle;
  late Future<List<TransactionModel>> transactions;
  final String chartType;
  final Color? chartColor;

  CardChart({
    super.key,
    required this.cardTitle,
    required this.transactions,
    required this.chartType,
    this.chartColor,
  });

  @override
  State<CardChart> createState() => _CardChartState();
}

class _CardChartState extends State<CardChart> {
  double sizeVertical = SizeConfig.blockSizeVertical!;

  late Future<List<TransactionModel>> _transactions;

  @override
  void initState() {
    super.initState();
    _transactions = widget.transactions;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.blockSizeVertical! * 40,
        decoration: const BoxDecoration(
          color: kPrimaryGray,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  widget.cardTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: sizeVertical * 3,
              ),
              SizedBox(
                // width: double.infinity,
                height: 220,
                child: FutureBuilder<List<TransactionModel>>(
                  future: _transactions,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No transactions available.'));
                    }
                    if (widget.chartType == 'bar') {
                      return BarChartSample(
                        transactions: snapshot.data!,
                        color: widget.chartColor!,
                      );
                    }
                    if (widget.chartType == 'line') {
                      return const LineChartSample();
                    }
                    if (widget.chartType == 'pie') {
                      return Center(
                          child: PieChartSample(
                        transactions: snapshot.data!,
                      ));
                    }
                    return const Text("No Data Found");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
