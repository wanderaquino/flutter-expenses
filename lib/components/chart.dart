import "package:expenses_cod3r/components/chart_bar.dart";
import "package:flutter/material.dart";
import 'package:intl/date_symbol_data_local.dart';
import "package:intl/intl.dart";
import "../models/transaction.dart";

class Chart extends StatelessWidget {

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions, {super.key});
  List<Map<String, Object>> get groupedTransactions {


    return List.generate(7, (index) {
      initializeDateFormatting("pt_BR", "");

      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (Transaction transaction in recentTransactions) {
        bool sameDay = transaction.date.day == weekDay.day;
        bool sameMonth = transaction.date.month == weekDay.month;
        bool sameYear = transaction.date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += transaction.value;
        };
      }
      return {"day": DateFormat.E("pt_BR").format(weekDay)[0].toUpperCase(), "value": totalSum};
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, transaction) {
      return sum + double.parse(transaction['value'].toString());
    });
  }


  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((transaction) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: transaction['day'].toString(),
                  value: double.parse(transaction['value'].toString()),
                  percentage: (transaction['value'] as double) / _weekTotalValue),
            );
          }).toList(),
        ),
      ),
    );
  }
}
