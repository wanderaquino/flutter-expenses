import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import "package:uuid/uuid.dart";
import "package:uuid/v4.dart";

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key, this.onSubmitTransactionForm});

  final void Function(String, String, double, DateTime)? onSubmitTransactionForm;

  @override
  State<StatefulWidget> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  TextEditingController transactionNameController = TextEditingController();
  TextEditingController transactionValueController = TextEditingController();

  DateTime? _pickedDate;

  _showDatePicker() {
    showDatePicker(context: context, firstDate: DateTime(2019), lastDate: DateTime.now()).then((userPickedDate) {
      if (userPickedDate == null) {
        return;
      }
      setState(() {
        _pickedDate = userPickedDate;
      });
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              height: 220,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: "Nome da Transação"),
                    controller: transactionNameController,
                  ),
                  TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Valor da Transação"),
                      controller: transactionValueController),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_pickedDate == null
                          ? "Nenhuma data selecionada"
                          : "Data selecionada: ${DateFormat("d/MM/y").format(_pickedDate!)}"),
                      TextButton(
                          onPressed: _showDatePicker,
                          style: ElevatedButton.styleFrom(foregroundColor: Theme.of(context).primaryColor),
                          child: const Text("Selecionar data", style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (transactionNameController.text.isEmpty || transactionValueController.text.isEmpty) {
                          return;
                        }

                        widget.onSubmitTransactionForm!(UuidV4().generate(), transactionNameController.text,
                            double.parse(transactionValueController.text), _pickedDate!);
                      },
                      child: const Text("Nova Transação"))
                ],
              ),
            )));
  }
}
