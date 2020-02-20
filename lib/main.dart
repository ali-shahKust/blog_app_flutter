import 'dart:js';

import 'package:flutter/material.dart';

import 'loginsignup/login.dart';
import 'loginsignup/signup.dart';

void main () {
runApp(new HomePage());
}
class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "BlogoMo",
      home: LoginRegisterPage(),
      theme: new ThemeData(
        primarySwatch: Colors.blue
      ),
    );
  }
}







