import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';
import './chartbar.dart';

class Charts extends StatelessWidget {
  final List<Transactions> recentTranscations;
  Charts(this.recentTranscations);

  List<Map<String, Object>> get groupedUserTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (var i = 0; i < recentTranscations.length; i++) {
        if (recentTranscations[i].dateTime.day == weekDay.day &&
            recentTranscations[i].dateTime.month == weekDay.month &&
            recentTranscations[i].dateTime.year == weekDay.year) {
          totalSum = totalSum + recentTranscations[i].price;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum
      };
    }).reversed.toList();
  }

  double get spendingPercentage {
    return groupedUserTransaction.fold(0.0, (sum, element) {
      return sum = sum + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: groupedUserTransaction.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(data['day'], data['amount'],
                (data['amount'] as double) / spendingPercentage),
          );
        }).toList(),
      ),
    );
  }
}
