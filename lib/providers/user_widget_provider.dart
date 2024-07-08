import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserWidgetProvider extends ChangeNotifier {
  Widget? _userWidget;
  Widget? get userWidget => _userWidget;

  void setUserWidget(Widget? widget) {
    _userWidget = widget;
    notifyListeners();
  }

  // Static access method for UserWidgetProvider
  static UserWidgetProvider of(BuildContext context) {
    final provider = Provider.of<UserWidgetProvider>(context, listen: false);
    return provider;
  }
}
