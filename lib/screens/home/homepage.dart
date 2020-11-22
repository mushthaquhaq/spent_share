import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spent_share/models/expense_type.dart';
import 'package:spent_share/screens/ui_widgets/expense_type_list.dart';
import 'package:spent_share/services/auth.dart';
import 'package:spent_share/services/database.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    DatabaseService()
        .updateExpenseType('', 'Groceries', 'Supermarket groceries');
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await _auth.signOutGoogle();
            }, 
            icon: Icon(Icons.person), 
            label: Text('Log out'))
        ],
      ),
      body: StreamProvider<List<ExpenseType>>.value(
        value: DatabaseService().expenseTypes,
        child: ExpenseTypeList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
