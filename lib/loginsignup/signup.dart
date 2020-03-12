import 'package:blog_app_flutter/homepage/homepage.dart';
import 'package:blog_app_flutter/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:blog_app_flutter/loginsignup/login.dart';

import '../constant.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email, _password, _name;
  final databaseReference = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _namecontroller = TextEditingController();
  final _phonecontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Register Page'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            new Form(
                child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: createInputs() + createButtons(),
            )),
          ],
        ),
      ),
    );
  }

  List<Widget> createInputs() {
    return [
      SizedBox(
        height: 15,
      ),
      logo(),
      SizedBox(
        height: 25.0,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Material(
          elevation: 2.0,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: TextFormField(
            keyboardType: TextInputType.text,
            controller: _namecontroller,
            onChanged: (String value) {},
            cursorColor: Constant.appColor,
            decoration: InputDecoration(
                hintText: "Username",
                prefixIcon: Material(
                  elevation: 0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Icon(
                    Icons.verified_user,
                    color: Constant.appColor,
                  ),
                ),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
          ),
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Material(
          elevation: 2.0,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: TextFormField(
            keyboardType: TextInputType.phone,
            controller: _phonecontroller,
            onChanged: (String value) {},
            cursorColor: Constant.appColor,
            decoration: InputDecoration(
                hintText: "Phone Number",
                prefixIcon: Material(
                  elevation: 0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Icon(
                    Icons.phone,
                    color: Constant.appColor,
                  ),
                ),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
          ),
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      SizedBox(
        height: 15.0,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Material(
          elevation: 2.0,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailcontroller,
            onChanged: (String value) {},
            cursorColor: Constant.appColor,
            decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: Material(
                  elevation: 0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Icon(
                    Icons.email,
                    color: Constant.appColor,
                  ),
                ),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
          ),
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      SizedBox(
        height: 15.0,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Material(
          elevation: 2.0,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: TextFormField(
            obscureText: true,
            controller: _passwordcontroller,
            onChanged: (String value) {},
            cursorColor: Constant.appColor,
            decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Material(
                  elevation: 0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Icon(
                    Icons.lock,
                    color: Constant.appColor,
                  ),
                ),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
          ),
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      SizedBox(
        height: 10.0,
      ),
    ];
  }

  List<Widget> createButtons() {
    return [
      new RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0),
              side: BorderSide(color: Colors.blue)),
          child: Text(
            'Sign Up',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          color: Colors.blue,
          onPressed: () {
            _SignUp();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePageLoader()));

          }),
      new FlatButton(
          child: Text(
            'Already Registered ? Click here',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginRegisterPage()));
          }),
    ];
  }

  Widget logo() {
    return new CircleAvatar(
      backgroundColor: Colors.white,
      child: Image.asset('images/logo.png'),
    );
  }
  void _SignUp() async {
    _email = _emailcontroller.text;
    _password = _passwordcontroller.text;

    try{
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      ))
          .user;

      String mUid = (await FirebaseAuth.instance.currentUser()).uid;

      await databaseReference.collection('Users').document(mUid).setData({
        'user_uid': mUid,
        'user_name': _namecontroller.text,
        'user_email':_emailcontroller.text,
        'user_phone': _phonecontroller.text,
        'user_profile': '',
      });

    }
    catch(e){
    print(e.message);
    }


  }

}

