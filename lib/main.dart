import 'package:flutter/material.dart';
import 'package:project/widgets/loginPage.dart';
import 'widgets/bottomNavigation.dart';
// import 'package:project/widgets/title_style.dart';
//void main() => runApp(const MyApp());

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var title = 'App per fer proves';
    return MaterialApp(
      title: title,
      home: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(title: Text("Aplicació")),
          body: const LoginPage()),
    );
  }
}