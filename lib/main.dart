

import 'package:flutter/material.dart';

import 'homepage/homepage.dart';
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
      home: LoginRegisterPage(),
    );
  }
}







