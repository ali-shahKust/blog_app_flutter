import 'package:blog_app_flutter/Profile_setting.dart';
import 'package:blog_app_flutter/all_users.dart';
import 'package:blog_app_flutter/homepage/post_a_blog.dart';
import 'package:blog_app_flutter/loginsignup/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../newFeed.dart';
class HomePageLoader extends StatefulWidget {
  @override
  _HomePageLoaderState createState() => _HomePageLoaderState();
}

class _HomePageLoaderState extends State<HomePageLoader> {
  DocumentSnapshot mRef;
  List<Object> _tabs;

  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    _tabs  = [News_feed(),PostBlogPage(),All_Users(),Profile_setting()];

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        height: 50,
        backgroundColor: Colors.blueAccent,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.add_circle_outline),
          Icon(Icons.list, size: 30),
          Icon(Icons.supervised_user_circle, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
        body: _tabs[_page]
      );
  }



}
