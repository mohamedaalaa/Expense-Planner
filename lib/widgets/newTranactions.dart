import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner/widgets/adaptive_flat_button.dart';

class NewTranactions extends StatefulWidget {
  final Function(String txTitle, double txAmount, DateTime txDateTime) addTx;

  NewTranactions(this.addTx);

  @override
  _NewTranactionsState createState() => _NewTranactionsState();
}

class _NewTranactionsState extends State<NewTranactions> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  var _selectedDate;

  _submiteedData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    final enteredDate = _selectedDate;
    if (enteredTitle.isEmpty || enteredAmount < 0 || enteredDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, enteredDate);
    Navigator.of(context).pop();
  }

      void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(
          () {
            _selectedDate = pickedDate;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          height: 500,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: titleController,
                onSubmitted: (_) => _submiteedData(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submiteedData(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? "No Date Choosen"
                            : "Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    AdaptiveFlatButton(_presentDatePicker),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submiteedData,
                color: Colors.purple,
                child: Text(
                  "Add Transaction",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                textColor: Colors.purple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
