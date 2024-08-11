import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "../models/transaction.dart";

class TransactionList extends StatelessWidget {
  const TransactionList({super.key, required this.transactionList, required this.onDeleteTransaction});

  final List<Transaction> transactionList;
  final void Function(String id) onDeleteTransaction;

  String _formatCurrencyNumber(double number) {
    final format = NumberFormat.currency(symbol: "R\$", locale: "pt_BR");
    return format.format(number).toString();
  }

  String _formatDate(DateTime date) {
    final format = DateFormat("dd MMM y").format(date);
    return format;
  }

  List<Widget> _parseTransactions(List<Transaction> transactions, BuildContext context) {
    List<Widget> transactionsList = transactions
        .map((transaction) => Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: ListTile(
                title: Text(transaction.title.toString(),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                subtitle: Text(_formatDate(transaction.date)),
                leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 32,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                          child: Text(
                        _formatCurrencyNumber(transaction.value),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                    )),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () => onDeleteTransaction(transaction.id),
                ),
              ),
            ))
        .toList();
    return transactionsList;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.60,
      child: ListView(
        children: [..._parseTransactions(transactionList, context)],
      ),
    );

    // Column( children: [..._parseTransactions(transactionList)]);
  }
}
