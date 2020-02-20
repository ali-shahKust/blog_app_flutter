import 'package:flutter/material.dart';

class LoginRegisterPage extends StatefulWidget {

  void validateUsers(){
    
  }

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
        child: ListView(
         children: <Widget>[
            new Form(child: new Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: createInputs() + createButtons(),
           )),
         ],
        ),
      ),
    );
  }

  List<Widget> createInputs(){
    return [
          SizedBox(height: 15,),
      logo(),
      SizedBox(height: 10.0,),
      new TextFormField(decoration: InputDecoration(border: new OutlineInputBorder(
    borderRadius: const BorderRadius.all(
    const Radius.circular(10.0),
    ),) ,labelText: 'Email' ),

      ),

      SizedBox(height: 15.0,),
      new TextFormField(decoration: InputDecoration(border: new OutlineInputBorder(
    borderRadius: const BorderRadius.all(
    const Radius.circular(10.0),
    )), labelText: 'Password'),
      ),
      SizedBox(height: 10.0,),
    ];
  }
  List<Widget> createButtons(){
    return [
      new RaisedButton( shape: new RoundedRectangleBorder( borderRadius: new BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.blue)),
          child: Text('Login',style: TextStyle(fontSize: 18, color: Colors.white)  ,
      )  , color: Colors.blue
          ,onPressed: (){

          }
      ),
      new FlatButton(child: Text('No Account Click here?',style: TextStyle(fontSize: 18) ,
      )
          ,onPressed: (){

          }
      ),
    ];
  }
  Widget logo(){
    return new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.asset('images/logo.png'),
      ),
    );
  }

}
