import "package:expenses_cod3r/components/transaction_form.dart";
import "package:expenses_cod3r/components/transaction_list.dart";
import "package:flutter/material.dart";

import "../components/chart.dart";
import "../models/transaction.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transaction> _transactions = [];

  void _addTransaction(
      String transactionId, String transactionName, double transactionValue, DateTime transactionDate) {
    Transaction newTransaction =
        Transaction(id: transactionId, date: transactionDate, title: transactionName, value: transactionValue);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: TransactionForm(onSubmitTransactionForm: _addTransaction),
          );
        });
  }

  void _deleteTransaction(String id) {
    _transactions.removeWhere((transaction) => transaction.id == id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Expenses App",
            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.purple,
                    brightness: Brightness.light,
                  ),
                ),
                child: IconButton(onPressed: () {}, color: Colors.white, icon: const Icon(Icons.add)))
          ],
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
          _transactions.isEmpty
              ? Container()
              : Container(
                  child: Chart(_transactions),
                ),
          _transactions.isEmpty
              ? Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20, top: 20),
                      child: const Text("Nenhuma transação cadastrada...",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 250,
                      child: Image.asset(
                        "assets/images/waiting.png",
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                )
              : TransactionList(
                  transactionList: _transactions,
                  onDeleteTransaction: _deleteTransaction,
                )
        ]),
        floatingActionButton: Theme(
            data: Theme.of(context).copyWith(
              // TRY THIS: Change the seedColor to "Colors.red" or
              //           "Colors.blue".
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.purple,
                brightness: Brightness.light,
              ),
            ),
            child: FloatingActionButton(
              child: const Icon(
                Icons.add,
              ),
              onPressed: () => _openTransactionFormModal(context),
            )));
  }
}
