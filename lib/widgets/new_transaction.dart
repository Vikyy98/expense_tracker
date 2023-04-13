import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactionsEntries extends StatefulWidget {
  final Function addTransactionToList;
  NewTransactionsEntries(this.addTransactionToList);

  @override
  State<NewTransactionsEntries> createState() => _NewTransactionsEntriesState();
}

class _NewTransactionsEntriesState extends State<NewTransactionsEntries> {
  final _itemFieldController = TextEditingController();
  final _costFieldController = TextEditingController();
  DateTime _pickedDate;

  void _submitItems() {
    String itemToAdd = _itemFieldController.text;
    double priceToAdd = double.parse(_costFieldController.text);

    if (itemToAdd.isEmpty || priceToAdd <= 0 || _pickedDate == null) {
      return;
    }

    //To call the constructor inside state class , flutter uses wiget class to refer inside state class
    widget.addTransactionToList(itemToAdd, priceToAdd, _pickedDate);

    //Closes the modal on submit
    Navigator.of(context).pop();
  }

  void _openDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2024))
        .then((selectedDate) {
      if (selectedDate == null) {
        return;
      }
      setState(() {
        _pickedDate = selectedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                style: TextStyle(fontSize: 18),
                controller: _itemFieldController,
                decoration: InputDecoration(labelText: 'Please enter items'),
                keyboardType: TextInputType.text,
                onSubmitted: (_) => _submitItems(),
              ),
              TextField(
                style: TextStyle(fontSize: 18),
                controller: _costFieldController,
                decoration:
                    InputDecoration(labelText: 'Please enter the price'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitItems(),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_pickedDate == null
                        ? "No date chosen"
                        : 'Picked Date: ${DateFormat.yMd().format(_pickedDate)}'),
                    TextButton(
                      child: Text(
                        "Add Date",
                        style: TextStyle(
                            color: Colors.amber, fontWeight: FontWeight.bold),
                      ),
                      onPressed: _openDatePicker,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: _submitItems, child: Text('Add transaction'))
            ],
          ),
        ),
      ),
    );
  }
}
