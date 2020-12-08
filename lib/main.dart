import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseproject/LogIn_Page.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'CSE  IN CoU',
      theme: ThemeData(
          accentColor: Colors.white70, primarySwatch: Colors.deepPurple),
      home: SignIn(),
    );
  }
}
