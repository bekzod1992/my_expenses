import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hamyon_orginal/models/expence.dart';
import 'package:hamyon_orginal/widgets/expense_item.dart';
import 'package:intl/intl.dart';

class AddList extends StatelessWidget {
  final List<Expense> expensese;
  final Function deleteExpense;

  AddList(this.expensese, this.deleteExpense);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        clipBehavior: Clip.hardEdge,
        width: MediaQuery.of(context).size.width,
        height: constraints.maxHeight - 100,
        margin: const EdgeInsets.only(top: 100),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60), topRight: Radius.circular(60)),
        ),
        child: expensese.length > 0
            ? ListView.builder(
                padding: const EdgeInsets.only(top: 10.0, right: 5.0),
                itemBuilder: (ctx, i) {
                  return ExpenseItem(
                      expensese[i].id,
                      expensese[i].title,
                      expensese[i].date,
                      expensese[i].amount,
                      expensese[i].icon,
                      ValueKey(expensese[i].id),
                      deleteExpense);
                },
                itemCount: expensese.length)
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "Bu oyda Harajatlar mavjud emas, \n qo\'shishingiz mumkin"),
                      SizedBox(
                        height: 25.0,
                      ),
                      Image.asset(
                        "assets/images/img_not_list.png",
                        fit: BoxFit.cover,
                        width: 200,
                      )
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
