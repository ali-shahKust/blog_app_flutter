import 'package:flutter/material.dart';
import 'package:blog_app_flutter/loginsignup/login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
            new Form(child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: createInputs() + createButtons(),
            )
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> createInputs() {
    return [
      SizedBox(height: 15,),
      logo(),
      SizedBox(height: 25.0,),
      new TextFormField(
        decoration: InputDecoration(border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),), labelText: 'Name'),

      ),

      SizedBox(height: 15.0,),
      new TextFormField(keyboardType: TextInputType.number,
        decoration: InputDecoration(border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),), labelText: 'Phone Number'),

      ),


      SizedBox(height: 15.0,),
      new TextFormField(keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),), labelText: 'Email'),

      ),

      SizedBox(height: 15.0,),
      new TextFormField(obscureText: true,
        decoration: InputDecoration(border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            )), labelText: 'Password'),
      ),
      SizedBox(height: 10.0,),
    ];
  }

  List<Widget> createButtons() {
    return [
      new RaisedButton(shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.blue)),
          child: Text(
            'Sign Up', style: TextStyle(fontSize: 18, color: Colors.white),
          ), color: Colors.blue
          , onPressed: () {

          }
      ),
      new FlatButton(child: Text(
        'Already Registered ? Click here', style: TextStyle(fontSize: 18),
      )
          , onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginRegisterPage()));
          }
      ),
    ];
  }

  Widget logo() {
    return new CircleAvatar(
      backgroundColor: Colors.white,
      child: Image.asset('images/logo.png'),
    );
  }

}
