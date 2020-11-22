import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spent_share/models/user.dart';
import 'package:spent_share/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:spent_share/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser>.value(
      value: AuthService().user,
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home:
              Wrapper() //Authenticate() //MyHomePage(title: 'Flutter Demo Home Page'),
          ),
    );
  }
}
