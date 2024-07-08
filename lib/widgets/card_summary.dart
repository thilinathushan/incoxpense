// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../app_style.dart';
import '../size_config.dart';

// ignore: must_be_immutable
class CardSummary extends StatefulWidget {
  String income;
  String expense;
  CardSummary({
    super.key,
    required this.income,
    required this.expense,
  });

  @override
  State<CardSummary> createState() => _CardSummaryState();
}

class _CardSummaryState extends State<CardSummary> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeVertical = SizeConfig.blockSizeVertical!;
    const userProfile = 'assets/logo/appLogo.png';

    // print(widget.income.toString());
    // print(widget.expense.toString());

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        width: SizeConfig.screenWidth,
        decoration: const BoxDecoration(
          color: kPrimaryGray,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: const BoxDecoration(
                              color: primaryIncome,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: sizeVertical * 1,
                          ),
                          const Text(
                            "Total Income",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: sizeVertical * 1,
                      ),
                      Text(
                        'Rs: ${widget.income}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizeVertical * 3,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: const BoxDecoration(
                              color: primaryExpense,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: sizeVertical * 1,
                          ),
                          const Text(
                            "Total Expenses",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: sizeVertical * 1,
                      ),
                      Text(
                        'Rs: ${widget.expense}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.all(10.0),
                child: widget.income == '0.00' && widget.expense == '0.00'
                    ? Image.asset(
                        userProfile,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : AspectRatio(
                        aspectRatio: 1.0,
                        child: PieChart(
                          PieChartData(
                            centerSpaceRadius: sizeVertical * 3,
                            sections: [
                              PieChartSectionData(
                                value: double.parse(widget.income),
                                color: primaryIncome,
                                showTitle: false,
                                radius: 40,
                              ),
                              PieChartSectionData(
                                value: double.parse(widget.expense),
                                color: primaryExpense,
                                showTitle: false,
                                radius: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
