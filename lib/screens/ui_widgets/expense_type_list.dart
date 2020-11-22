import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spent_share/models/expense_type.dart';
import 'package:spent_share/screens/ui_widgets/expense_type_tile.dart';

class ExpenseTypeList extends StatefulWidget {
  @override
  _ExpenseTypeListState createState() => _ExpenseTypeListState();
}

class _ExpenseTypeListState extends State<ExpenseTypeList> {
  @override
  Widget build(BuildContext context) {

    final expenseTypes = Provider.of<List<ExpenseType>>(context);
    if(expenseTypes == null)
    {
      return Text('Loading');
    }
    else
    {
    return ListView.builder(
      itemCount: expenseTypes.length,
      itemBuilder: (context, index){
        return ExpnseTypeTile(expnseType:expenseTypes[index]);
      },
    );
    }
  }
}