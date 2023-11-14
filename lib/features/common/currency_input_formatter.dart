import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    String currentValue = oldValue.text;
    final newDouble = double.tryParse(currentValue + newValue.text);
    String newString = NumberFormat.simpleCurrency().format(newDouble);
    currentValue = newString;

    return TextEditingValue(text: currentValue);
  }
}
