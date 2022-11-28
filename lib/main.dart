import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:hamyon_orginal/models/expence.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:intl/intl.dart';
import 'widgets/budget.dart';
import 'widgets/body.dart';
import 'widgets/addList.dart';
import 'widgets/add_new_expense.dart';
import 'widgets/header.dart';

void main(List<String> args) {
  // WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber,
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with WidgetsBindingObserver {
  Expenses expenseData = Expenses();

  DateTime todoSelectMonth = DateTime.now();

  bool _showExpenseList = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void showCalandar(BuildContext context) {
    showMonthPicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((dateMonthValue) {
      if (dateMonthValue != null) {
        setState(() {
          todoSelectMonth = dateMonthValue;
        });
      }
    });
  }

  void previousMonth() {
    if (todoSelectMonth.year == 2020 && todoSelectMonth.month == 1) {
      return;
    }
    setState(() {
      todoSelectMonth = DateTime(
          todoSelectMonth.year, todoSelectMonth.month - 1, todoSelectMonth.day);
    });
  }

  void nextMonth() {
    if (todoSelectMonth.year == DateTime.now().year &&
        todoSelectMonth.month == DateTime.now().month) {
      return;
    }
    setState(() {
      todoSelectMonth = DateTime(
          todoSelectMonth.year, todoSelectMonth.month + 1, todoSelectMonth.day);
    });
  }

  void showNewAddExpenseWindow(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (ctx) {
        return AddNewExpense(addNewExpense);
      },
    );
  }

  void addNewExpense(
      String title, double amount, DateTime date, IconData icon) {
    setState(() {
      expenseData.addNewExpendense(title, amount, date, icon);
    });
  }

  void deleteExpense(String id) {
    setState(() {
      expenseData.delete(id);
    });
  }

  Widget _showPortraitItems(totalByMonth, deviceHieght, deviceWidht) {
    return Column(
      children: [
        Container(
          height: deviceHieght * 0.2,
          width: deviceWidht,
          child: Header(showCalandar, todoSelectMonth, previousMonth, nextMonth,
              totalByMonth),
        ),
        Container(
          height: deviceHieght * 0.8,
          width: deviceWidht,
          child: Body(expenseData.itemByMonth(todoSelectMonth), totalByMonth,
              deleteExpense),
        ),
      ],
    );
  }

  Widget _showLanscapeItems(totalByMonth, deviceHieght, deviceWidht) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Harajatlar ko'rsatish"),
            Switch.adaptive(
                activeColor: Colors.red,
                value: _showExpenseList,
                onChanged: (value) {
                  setState(() {
                    _showExpenseList = value;
                  });
                })
          ],
        ),
        _showExpenseList
            ? Container(
                height: deviceHieght * 0.9,
                width: deviceWidht,
                child: Body(expenseData.itemByMonth(todoSelectMonth),
                    totalByMonth, deleteExpense),
              )
            : Container(
                width: deviceWidht,
                height: deviceHieght * 0.9,
                child: Header(showCalandar, todoSelectMonth, previousMonth,
                    nextMonth, totalByMonth),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalByMonth = expenseData.totalExpenseByMonth(todoSelectMonth);

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
        title: const Text("Mening Hamyonim"),
        backgroundColor: Colors.blueGrey.shade800,
        actions: Platform.isIOS
            ? [
                IconButton(
                    onPressed: () {
                      showNewAddExpenseWindow(context);
                    },
                    icon: Icon(Icons.add))
              ]
            : []);

    final topPading = MediaQuery.of(context).padding.top;

    final deviceHieght = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        topPading;

    final deviceWidht = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blueGrey.shade600,
          child: Column(
            children: [
              isLandscape
                  ? _showLanscapeItems(totalByMonth, deviceHieght, deviceWidht)
                  : _showPortraitItems(totalByMonth, deviceHieght, deviceWidht)

              // Header(showCalandar, todoSelectMonth, previousMonth, nextMonth,
              //     totalByMonth),
              // Body(expenseData.itemByMonth(todoSelectMonth), totalByMonth,
              //     deleteExpense),
            ],
          ),
        ),
      ),
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
              onPressed: () {
                showNewAddExpenseWindow(context);
              },
              child: Icon(Icons.add))
          : Container(),
    );
  }
}
