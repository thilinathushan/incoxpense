import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTask extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputKeyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatter;
  final String hintText;
  final String? hintImage;
  final Icon? hintIcon;
  final int? maxLines;
  final String? prefixText;

  const InputTask({
    super.key,
    required this.controller,
    required this.inputKeyboardType,
    this.textInputAction,
    this.inputFormatter,
    required this.hintText,
    this.hintImage,
    this.hintIcon,
    this.maxLines,
    this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    bool chance = true;
    Image? imgHint;
    Icon? iconHint;

    if (hintImage != null && hintIcon == null) {
      imgHint = Image.asset(hintImage!);
      chance = true;
    }
    if (hintImage == null && hintIcon != null) {
      iconHint = hintIcon!;
      chance = false;
    }

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 20),
        icon: chance ? imgHint : iconHint,
        contentPadding: const EdgeInsets.all(10),
        border: InputBorder.none,
      ),
      keyboardType: inputKeyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatter,
      style: const TextStyle(fontSize: 20),
      maxLines: maxLines,
    );
  }
}
