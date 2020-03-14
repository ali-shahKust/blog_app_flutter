import 'package:blog_app_flutter/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class All_Users extends StatefulWidget {
  @override
  _All_UsersState createState() => _All_UsersState();
}

class _All_UsersState extends State<All_Users> {
  
  final databaseRef = Firestore.instance;
  final List<Map> Users = [];
  final primary = Constant.appColor;
  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Users.isNotEmpty ?
              Container(
                padding: EdgeInsets.only(top:145),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: Users.length,
                    itemBuilder: (BuildContext  context ,int index ){
                      return buildlist(context , index) ;
                    }),
              ):Container(
                child: Center(
                  child: Text('No data'),
                ),
              ),
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Center(
                        child: Text(
                          'All Users',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void getUserData() async{
    try{
      String mUiD = (await FirebaseAuth.instance.currentUser()).uid;
      databaseRef.collection('Users').where('user_uid', isGreaterThan: mUiD).getDocuments().then((QuerySnapshot snaps){
        snaps.documents.forEach((mFun){
            Users.add(mFun.data);

            setState(() {

            });
        });
      });
    }catch(e){
      print(e.message);
    }
  }

  Widget buildlist(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.grey.shade400,
      ),
      width: double.infinity,
      height: 110,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 3, color: primary),
              image: DecorationImage(
                  image: Users[index]['user_profile'] == ''
                      ? AssetImage('images/profile.png')
                      :  NetworkImage(Users[index]['user_profile']),
                  fit: BoxFit.fill),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    Users[index]['user_name'],
                    style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.description,
                      color: primary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child:Users[index]['status'] == null? Text('No Details Given'):Text(Users[index]['status'],
                          style: TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3)),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
