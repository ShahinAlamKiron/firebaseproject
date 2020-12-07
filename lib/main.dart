import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseproject/login.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CSE  IN CoU',
      theme: ThemeData(
          accentColor: Colors.white70, primarySwatch: Colors.deepPurple),
      home: SignIn(),
    );
  }
}
