import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:intl/number_symbols.dart';

class AddNewExpense extends StatefulWidget {
  final Function addNewExpense;

  AddNewExpense(this.addNewExpense);

  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  DateTime? _todoAddNewDate;
  IconData? iconsExpense;

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void showNewExpenseCalendar(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: _todoAddNewDate ?? DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        setState(() {
          _todoAddNewDate = value;
        });
      }
    });
  }

  void iconSelect(BuildContext context) {
    FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.cupertino]).then((valueIcon) {
      if (valueIcon != null) {
        setState(() {
          iconsExpense = valueIcon;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom > 0
                ? MediaQuery.of(context).viewInsets.bottom
                : 100),
        child: Column(
          children: [
            Platform.isAndroid
                ? TextField(
                    decoration: InputDecoration(labelText: "Harajat nomi"),
                    controller: titleController,
                  )
                : CupertinoTextField(
                    placeholder: 'Harajat nomi',
                    controller: titleController,
                  ),
            Platform.isAndroid
                ? TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Harajat miqdori!",
                    ),
                    controller: amountController,
                  )
                : CupertinoTextField(
                    placeholder: 'Harajat miqdori',
                    controller: amountController,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _todoAddNewDate == null
                    ? const Text("Harajat kuni tanlanmadi")
                    : Text(
                        "Harajat kuni: ${DateFormat("dd-MMMM-yyyy").format(_todoAddNewDate!)}"),
                TextButton(
                    onPressed: () {
                      showNewExpenseCalendar(context);
                    },
                    child: const Text("KUNNI TANLASH"))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconsExpense == null
                    ? const Text("Icon tanlanmadi")
                    : Text("Tanlangan icon:"),
                Icon(iconsExpense),
                TextButton(
                    onPressed: () {
                      iconSelect(context);
                    },
                    child: const Text("ICON TANLASH"))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("BEKOR QILISH")),
                ElevatedButton(
                    onPressed: () {
                      if (titleController.text.isEmpty ||
                          amountController.text.isEmpty ||
                          _todoAddNewDate == null) {
                        return;
                      }
                      print(titleController.text);
                      print(amountController.text);

                      var title = titleController.text;
                      var amout = double.parse(amountController.text);

                      if (amout <= 0) {
                        return;
                      }
                      widget.addNewExpense(
                          title, amout, _todoAddNewDate, iconsExpense);
                      Navigator.of(context).pop();
                    },
                    child: Text("KIRISH"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
