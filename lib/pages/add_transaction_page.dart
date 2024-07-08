import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/layouts/main_layout.dart';
import '../database/transaction_db.dart';
import '../models/categories_data.dart';
import '../models/transaction_model.dart';
import '../widgets/input_transaction.dart';
import '../app_style.dart';
import '../components/custom_appbar.dart';
import '../size_config.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final db = TransactionDB();

  final _categoryDropDown = GlobalKey<FormFieldState>();
  final TextEditingController addNotesController = TextEditingController();
  final TextEditingController addAmountController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String formattedDateTime = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String? title;
  String updateTitle() {
    if (_selected.join() != 'type') {
      return title = _selected.join();
    } else {
      return title = 'Add Transaction';
    }
  }

  // Initial state for selection and list
  Set<String> _selected = {'type'};
  List<String> incomeList = CategoriesList().incomeCategoriesData;
  List<String> expenseList = CategoriesList().expenseCategoriesData;
  late List<String> list;
  late String dropDownValue = '';

  void updateSelected(Set<String> newSelection) {
    setState(() {
      _selected = newSelection;
    });
    if (_selected.join() == "Income") {
      list = incomeList;
    } else if (_selected.join() == "Expense") {
      list = expenseList;
    } else {
      list = incomeList;
    }
  }

  String formattedDateTimeFun() {
    DateTime combinedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );
    formattedDateTime = DateFormat('yyyy-MM-dd').format(combinedDateTime);
    return formattedDateTime;
  }

  ButtonStyle? _buttonStyle() {
    if (_selected.join() == "Income") {
      return ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryIncome;
          }
          return null;
        }),
      );
    }
    if (_selected.join() == "Expense") {
      return ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryExpense;
          }
          return null;
        }),
      );
    }
    return null;
  }

  void onsave() async {
    if (_selected.join() != "type" &&
        formattedDateTime.isNotEmpty &&
        dropDownValue.isNotEmpty &&
        addAmountController.text.isNotEmpty) {
      // print("T Type: " + _selected.join());
      // print("Date: " + formattedDateTime);
      // print("Category: " + dropDownValue);
      // print("Amount: " + double.parse(addAmountController.text).toString());
      // print("Notes: " + addNotesController.text);

      final newtrans = TransactionModel(
        type: _selected.join(),
        date: formattedDateTime,
        category: dropDownValue,
        amount: double.parse(addAmountController.text),
        note: addNotesController.text,
        created_at: DateTime.now().toIso8601String(),
      );
      await db.create(newtrans);

      resetForm();
      // ignore: use_build_context_synchronously
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
  }

  void resetForm() {
    setState(() {
      title = 'Add Transaction'; // Set title back to default
      _selected = {'type'}; // Unselect segment button
      selectedDate = DateTime.now(); // Reset date to today
      // dropDownValue = ''; // Set category to hint text
      _categoryDropDown.currentState?.reset();
      addAmountController.clear(); // Clear amount text field
      addNotesController.clear(); // Clear notes text field
      formattedDateTime = DateFormat('yyyy-MM-dd').format(selectedDate);
    });
  }

  @override
  void initState() {
    super.initState();
    list = incomeList;
  }

  @override
  void dispose() {
    _selected.clear();
    addAmountController.dispose();
    addNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      color: kPrimaryWhite,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                const CustomAppBar(),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: SizedBox(
                          width: SizeConfig.screenWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      updateTitle(),
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                        child: Text(
                          "Trasnaction Type",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SegmentedButton(
                        segments: const [
                          ButtonSegment(
                            value: "Income",
                            label: Text(
                              "Income",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            icon: Icon(
                              Icons.call_received_rounded,
                            ),
                          ),
                          ButtonSegment(
                            value: "Expense",
                            label: Text(
                              "Expense",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            icon: Icon(
                              Icons.call_made_rounded,
                            ),
                          ),
                        ],
                        selected: _selected,
                        onSelectionChanged: updateSelected,
                        showSelectedIcon: false,
                        style: _buttonStyle(),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                        child: Text(
                          "Date",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: kDarkGray,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          width: SizeConfig.screenWidth,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.calendar_month_outlined,
                                  color: kPrimaryGray,
                                ),
                                Text(
                                  formattedDateTimeFun(),
                                  style: const TextStyle(
                                      fontSize: 20, color: kPrimaryGray),
                                ),
                                const Icon(
                                  Icons.keyboard_double_arrow_down_rounded,
                                  color: kPrimaryGray,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                        child: Text(
                          "Category",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: kYellowColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        width: SizeConfig.screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 0.0, right: 0.0),
                          child: Center(
                            child: DropdownMenu<String>(
                              key: _categoryDropDown,
                              inputDecorationTheme: const InputDecorationTheme(
                                border: InputBorder.none,
                              ),
                              menuStyle: const MenuStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(kYellowColor),
                              ),
                              trailingIcon: const Icon(
                                Icons.keyboard_double_arrow_down_rounded,
                                color: kDarkGray,
                              ),
                              selectedTrailingIcon: const Icon(
                                Icons.keyboard_double_arrow_up_rounded,
                                color: kDarkGray,
                              ),
                              leadingIcon: const Icon(
                                Icons.category_outlined,
                                color: kDarkGray,
                              ),
                              width: (SizeConfig.screenWidth!) -
                                  (const EdgeInsets.all(10.0)
                                          .horizontal
                                          .toDouble() +
                                      const Radius.circular(25).x.toDouble()),
                              enableSearch: false,
                              textStyle:
                                  MaterialStateTextStyle.resolveWith((states) {
                                return const TextStyle(
                                  fontSize: 20.0,
                                );
                              }),
                              hintText: "Select the Category",
                              onSelected: (String? value) {
                                setState(() {
                                  dropDownValue = value!;
                                });
                              },
                              dropdownMenuEntries: list
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
                                return DropdownMenuEntry<String>(
                                  value: value,
                                  label: value,
                                  style: const ButtonStyle(
                                    textStyle: MaterialStatePropertyAll(
                                      TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                        child: Text(
                          "Add Amount",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: kCupertinoModalBarrierColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        width: SizeConfig.screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              const Text(
                                "Rs: ",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: kDarkGray,
                                ),
                              ),
                              Expanded(
                                child: InputTask(
                                  controller: addAmountController,
                                  inputKeyboardType: TextInputType.number,
                                  hintText: "Add your Amount here.",
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                        child: Text(
                          "Add Notes",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: kCupertinoModalBarrierColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        width: SizeConfig.screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: InputTask(
                            controller: addNotesController,
                            inputKeyboardType: TextInputType.multiline,
                            hintText: "Add your Notes here.",
                            hintIcon: const Icon(
                              Icons.edit_note_rounded,
                              color: kDarkGray,
                            ),
                            textInputAction: TextInputAction.newline,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          onsave();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 40.0,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: kPrimaryBlue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            width: SizeConfig.screenWidth,
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                      fontSize: 20, color: kPrimaryWhite),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
