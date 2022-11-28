import 'package:flutter/material.dart';

class EditExpensePrice extends StatefulWidget {
  final Function editChange;
  final double budgetLimit;

  EditExpensePrice(this.editChange, this.budgetLimit);

  @override
  State<EditExpensePrice> createState() => _EditExpensePriceState();
}

class _EditExpensePriceState extends State<EditExpensePrice> {
  late TextEditingController changePriceController;

  @override
  void initState() {
    changePriceController = TextEditingController();
    changePriceController.text = widget.budgetLimit.toStringAsFixed(0);
    super.initState();
  }

  @override
  void dispose() {
    changePriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Oylik budjet miqdori:"),
            controller: changePriceController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("BEKOR QILISH")),
              ElevatedButton(
                  onPressed: () {
                    print(changePriceController.text);

                    if (changePriceController.text.isEmpty) {
                      return;
                    }

                    var editAmount = double.parse(changePriceController.text);

                    if (editAmount <= 0) {
                      return;
                    }

                    widget.editChange(editAmount);
                    Navigator.of(context).pop();
                  },
                  child: Text("KIRITISH"))
            ],
          )
        ],
      ),
    );
  }
}
