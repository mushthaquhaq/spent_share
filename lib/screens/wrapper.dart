import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spent_share/models/user.dart';
import 'package:spent_share/screens/authenticate/authenticate.dart';
import 'package:spent_share/screens/home/homepage.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final appUser = Provider.of<AppUser>(context);
    if(appUser == null){
      return Authenticate();
    }
    else{
      return MyHomePage(title: 'Home Page',);
    }
  }
}