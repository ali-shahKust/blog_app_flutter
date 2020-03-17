import 'package:blog_app_flutter/homepage/post_a_blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'constant.dart';
class News_feed extends StatefulWidget {
  @override
  _News_feedState createState() => _News_feedState();
}

class _News_feedState extends State<News_feed> {
  final databaseRef = Firestore.instance;
  List<Map> Posts = [];
  final primary = Constant.appColor;

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:Colors.white ,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Posts.isNotEmpty ? Container(
                padding: EdgeInsets.only(top: 130),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: Posts.length,
                    itemBuilder: (BuildContext context , int index){
                      return buildList(context, index);
                    }
                ),
              ):Container(child: Text('No Data'),),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text('News Feed',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, int index) {
    print('Getting list ${Posts[index]['image']}');
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 400,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 270,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 3, color: primary),
              image: DecorationImage(
                  image: Posts[index]['image'] == ''
                      ? AssetImage('images/profile.png')
                      :  NetworkImage(Posts[index]['image']),
                  fit: BoxFit.fill),
            ),
          ),
        ],
      ),
    );
  }

  void getData() async{
    try{
      String mUiD = (await FirebaseAuth.instance.currentUser()).uid;
      databaseRef.collection('Blogs').getDocuments().then((QuerySnapshot snaps){
        snaps.documents.forEach((mFun){
          Posts.add(mFun.data);

          setState(() {

          });
        });
      });
    }catch(e){
      print(e.message);
    }
  }
}
