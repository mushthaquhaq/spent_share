

import 'package:flutter/material.dart';
import 'package:spent_share/models/expense_type.dart';
import 'package:spent_share/services/database.dart';

class SettingsForm extends StatefulWidget {
  final String typeID;
  SettingsForm({this.typeID});

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _description;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ExpenseType>(
        stream: DatabaseService().getExpenseType(widget.typeID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ExpenseType expenseType = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Update the expnse type.'),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: expenseType.name,
                    onChanged: (val) => setState(() => _name = val),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: expenseType.description,
                    onChanged: (val) => setState(() => _description = val),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      color: Colors.blue[200],
                      child: Text('Update'),
                      onPressed: () async {
                        await DatabaseService().updateExpenseType(widget.typeID, _name, _description);
                        Navigator.pop(context);
                      })
                ],
              ),
            );
          } else {
            return Text('No data found');
          }
        });
  }
}
