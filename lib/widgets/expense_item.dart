import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatelessWidget {
  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final IconData icon;
  final Key key;
  final Function deleteExpense;

  ExpenseItem(this.id, this.title, this.date, this.amount, this.icon, this.key,
      this.deleteExpense)
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key,
      onDismissed: (direction) {
        deleteExpense(id);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(DateFormat("dd-MMMM-yyyy").format(date)),
        trailing: Text("${amount} so'm"),
      ),
    );
  }
}
