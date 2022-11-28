import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hamyon_orginal/models/expence.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class Header extends StatelessWidget {
  final Function showCalandar;
  final DateTime todoSelectMonth;
  final Function() previousMonth;
  final Function() nextMonth;
  final double totalByMonth;

  Header(this.showCalandar, this.todoSelectMonth, this.previousMonth,
      this.nextMonth, this.totalByMonth);

  @override
  Widget build(BuildContext context) {
    final isLastMonth =
        todoSelectMonth.year == 2020 && todoSelectMonth.month == 1;

    final isNextMonth = todoSelectMonth.year == DateTime.now().year &&
        todoSelectMonth.month == DateTime.now().month;

    return Container(
      color: Colors.blueGrey.shade600,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          TextButton(
              onPressed: () {
                showCalandar(context);
              },
              child: Text(
                DateFormat("MMMM, yyyy").format(todoSelectMonth),
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: previousMonth,
                    icon: Icon(Icons.arrow_left,
                        size: 30,
                        color: isLastMonth ? Colors.red : Colors.black87)),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.black38),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    totalByMonth.toStringAsFixed(0),
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  Text(
                    "so'm",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        height: 0.6,
                        color: Colors.black87),
                  )
                ],
              ),
              Container(
                width: 40,
                height: 40,
                child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: nextMonth,
                    icon: Icon(Icons.arrow_right,
                        size: 30,
                        color: isNextMonth ? Colors.red : Colors.black87)),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.black38),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: 50.0,
          // )
        ]),
      ),
    );
  }
}
