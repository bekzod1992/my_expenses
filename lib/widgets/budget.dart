import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hamyon_orginal/models/expence.dart';
import 'package:hamyon_orginal/widgets/edit_expense_price.dart';
import 'progress.dart';

class Budget extends StatefulWidget {
  final double totalByMonth;

  Budget(this.totalByMonth);

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  double budgetLimit = 1000000;

  void showEditBudget(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (ctx) {
          return EditExpensePrice(editChange, budgetLimit);
        });
  }

  void editChange(double editAmount) {
    setState(() {
      budgetLimit = editAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    var totalLimitPercentage = 100 * widget.totalByMonth / budgetLimit;

    totalLimitPercentage =
        totalLimitPercentage > 100 ? 100 : totalLimitPercentage;

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.all(25.0),
        width: double.infinity,
        height: constraints.maxHeight,
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade100,
            // color: Color.fromRGBO(239, 240, 250, 1),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60), topRight: Radius.circular(60))),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  const Text("Oylik byudjet: "),
                  TextButton.icon(
                      onPressed: () {
                        showEditBudget(context);
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.blue,
                      ),
                      label: Text(
                        "${budgetLimit.toStringAsFixed(0)} so'm",
                        style: TextStyle(color: Colors.blue),
                      )),
                ],
              ),
              Text("${(totalLimitPercentage).toStringAsFixed(0)} %")
            ]),
            ProgressBar(totalLimitPercentage),
          ],
        ),
      );
    });
  }
}
