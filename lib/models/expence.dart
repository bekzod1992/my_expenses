import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/IconPicker/Packs/Material.dart';

class Expense {
  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final IconData icon;

  Expense(
      {required this.id,
      required this.title,
      required this.date,
      required this.amount,
      this.icon = Icons.ac_unit});
}

class Expenses {
  List<Expense> _items = [
    // Expense(id: "n1", title: "Tarvuz", date: DateTime.now(), amount: 20000),
    // Expense(id: "n2", title: "Bozor", date: DateTime.now(), amount: 30000),
    // Expense(id: "n3", title: "Taxi", date: DateTime.now(), amount: 25000),
    // Expense(id: "n4", title: "Chiqim", date: DateTime.now(), amount: 50000),
  ];

  List<Expense> get items {
    return _items;
  }

  // Oylik harajatni hisoblash

  double totalExpenseByMonth(DateTime date) {
    final expenseByMonth = itemByMonth(date);

    return expenseByMonth.fold(0, (previousValue, expense) {
      return previousValue + expense.amount;
    });
  }

// Oy bo'yicha sort
  List<Expense> itemByMonth(DateTime date) {
    return _items
        .where((expense) =>
            expense.date.month == date.month && expense.date.year == date.year)
        .toList();
  }

// qo'shish
  void addNewExpendense(
      String title, double amount, DateTime date, IconData icon) {
    _items.add(Expense(
        id: "e${_items.length + 1}",
        title: title,
        date: date,
        amount: amount,
        icon: icon));
  }

  // o'chirish

  void delete(String id) {
    _items.removeWhere((expense) => expense.id == id);
  }
}
