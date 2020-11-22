import 'package:flutter/material.dart';
import 'package:spent_share/models/expense_type.dart';
import 'package:spent_share/screens/ui_widgets/setting_form.dart';

class ExpnseTypeTile extends StatelessWidget {
  final ExpenseType expnseType;
  ExpnseTypeTile({this.expnseType});

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(typeID: expnseType.id),
        );
      });
    }


    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
            title: Text(expnseType.name),
            subtitle: Text(expnseType.description),
            trailing: IconButton(
              icon: new Icon(Icons.edit_outlined),
              onPressed: () => _showSettingsPanel(),
            )),
      ),
    );
  }
}
