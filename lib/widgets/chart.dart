import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner/models/transactions.dart';
import 'package:planner/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactionsList;

  const Chart(this.recentTransactionsList);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTransactionsList.length; i++) {
        if (recentTransactionsList[i].DateTime.day == weekDay.day &&
            recentTransactionsList[i].DateTime.month == weekDay.month &&
            recentTransactionsList[i].DateTime.year == weekDay.year) {
          totalSum += recentTransactionsList[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0.0, (sum, element) {
      return sum + (element['amount'] as num);
    });
  }

  @override
  Widget build(BuildContext context) {

      return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionsValues.map((e) {
              return Flexible(
                flex:1,
                fit: FlexFit.tight,
                  child: ChartBar(
                e['day'].toString(),
                e['amount'] as double,
                totalSpending == 0
                    ? 0.0
                    : ((e['amount' ]as double) / totalSpending),
              ),
              );
            },
            ).toList(),
          ),
        ),
    );
  }
}
