import 'package:flutter/material.dart';

Future<void> selectDate({
  required BuildContext context,
  required TextEditingController controller,
}) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime(2000),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );

  if (pickedDate != null) {
    controller.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
  }
}