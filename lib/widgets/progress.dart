import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double totalLimitPercentage;

  ProgressBar(this.totalLimitPercentage);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 4.0,
      decoration: BoxDecoration(
          color: Colors.black26, borderRadius: BorderRadius.circular(5)),
      child: FractionallySizedBox(
        heightFactor: 2,
        widthFactor: totalLimitPercentage / 100,
        child: Container(
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blue,
                Colors.blue,
                Colors.blue.shade200,
                Colors.blue
              ]),
              boxShadow: [
                BoxShadow(color: Colors.blue, blurRadius: 10, spreadRadius: -3)
              ],
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
