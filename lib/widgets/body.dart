import 'package:flutter/material.dart';
import 'package:hamyon_orginal/models/expence.dart';
import 'budget.dart';
import 'addList.dart';

class Body extends StatelessWidget {
  final List<Expense> expensese;
  final double totalByMonth;
  final Function deleteExpense;

  Body(this.expensese, this.totalByMonth, this.deleteExpense);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Budget(totalByMonth), AddList(expensese, deleteExpense)],
    );
  }
}
