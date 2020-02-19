import 'package:flutter/material.dart';

class LoginRegisterPage extends StatefulWidget {
  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: new Form(child: new Column(
          children: <Widget>[

          ],
        )),
      ),
    );
  }

  List<Widget> createInputs(){
    return [
          SizedBox(height: 15,),
      logo(),
      SizedBox(height: 10.0,),
      new TextFormField(decoration: InputDecoration(labelText: 'Email'),

      ),
      new TextFormField(decoration: InputDecoration(labelText: 'Password'),
      ),
      SizedBox(height: 10.0,),
    ];
  }
  List<Widget> createButtons(){
    return [
      new RaisedButton(child: Text('Login',style: TextStyle(fontSize: 18) , ) , color: Colors.blue ,onPressed: (){

      }
      )
    ];
  }
  Widget logo(){
    return new Hero(
      child: new CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.asset('images/logo.png'),
      ),
    );
  }
}
