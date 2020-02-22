import 'package:blog_app_flutter/loginsignup/signup.dart';
import 'package:flutter/material.dart';

class LoginRegisterPage extends StatefulWidget {

  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}


class _LoginRegisterPageState extends State<LoginRegisterPage> {

  final formkey = new GlobalKey<FormState>();

  String email = "";
  String pass = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: Container(

        margin: EdgeInsets.all(15.0),
        child: ListView(
         children: <Widget>[
            new Form(
              key: formkey,
                child: new Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: createInputs() + createButtons(),
           )),
         ],
        ),
      ),
    );
  }

  //Input Text Fields Design
  List<Widget> createInputs(){
    return [
          SizedBox(height: 15,),
      logo(),
      SizedBox(height: 25.0,),
      new TextFormField(keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(border: new OutlineInputBorder(
    borderRadius: const BorderRadius.all(
    const Radius.circular(10.0),
    ),
        )
            ,labelText: 'Email' ),
        validator: (value){
        return value.isEmpty ? 'Email is Required' : null ;
        },
        onSaved: (value){
        return email = value;
        },

      ),

      SizedBox(height: 15.0,),
      new TextFormField(obscureText: true,decoration: InputDecoration(border: new OutlineInputBorder(
    borderRadius: const BorderRadius.all(
    const Radius.circular(10.0),
    )), labelText: 'Password'),
        validator: (value){

          return value.isEmpty ? 'Password is Required' : null ;
        },
        onSaved: (value){
          return pass = value;
        },
      ),
      SizedBox(height: 10.0,),
    ];
  }
  //Button design
  List<Widget> createButtons(){
    return [
      new RaisedButton( shape: new RoundedRectangleBorder( borderRadius: new BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.blue)),
          child: Text('Login',style: TextStyle(fontSize: 18, color: Colors.white)  ,
      )  , color: Colors.blue
          ,onPressed: validateUser
      ),
      new FlatButton(child: Text('No Account Click here?',style: TextStyle(fontSize: 18) ,
      )
          ,onPressed:(){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignupPage()));
          }
      ),
    ];
  }
  //Infusible Coder Logo
  Widget logo(){
    return new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.asset('images/logo.png'),
      ),
    );
  }

  //Method to check User
  bool validateUser(){
final form = formkey.currentState;
if(form.validate()){
  form.save();
  return true;
}
else{
  return false;
}
  }


}
