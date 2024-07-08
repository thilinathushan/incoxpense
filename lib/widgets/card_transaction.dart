// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../app_style.dart';
import '../size_config.dart';

class CardTransaction extends StatefulWidget {
  final String type;
  final String date;
  final String category;
  final double amount;
  final String? note;
  Function(BuildContext)? deleteFunction;

  CardTransaction({
    super.key,
    required this.type,
    required this.date,
    required this.category,
    required this.amount,
    this.note,
    this.deleteFunction,
  });

  @override
  State<CardTransaction> createState() => _CardTransactionState();
}

class _CardTransactionState extends State<CardTransaction> {
  IconData? transactionIcon() {
    if (widget.type == "Income") {
      return Icons.call_received_rounded;
    } else if (widget.type == "Expense") {
      return Icons.call_made_rounded;
    }
    return null;
  }

  Color? get transactionColor {
    if (widget.type == "Income") {
      return primaryIncome;
    }
    if (widget.type == "Expense") {
      return primaryExpense;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: widget.deleteFunction,
            icon: Icons.delete,
            backgroundColor: deleteRedColor,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
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
                Row(
                  children: [
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: transactionColor!,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Icon(
                        transactionIcon(),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.category,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          overflow: TextOverflow.clip,
                          softWrap: false,
                          "Rs: ${widget.amount.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(overflow: TextOverflow.clip, softWrap: false, widget.date),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
