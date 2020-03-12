import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
class HomePageLoader extends StatefulWidget {
  @override
  _HomePageLoaderState createState() => _HomePageLoaderState();
}

class _HomePageLoaderState extends State<HomePageLoader> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(
        title: Text('BlogoMo'),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        height: 50,
        backgroundColor: Colors.blueAccent,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.exit_to_app, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
        body: Container(
         
        ));
  }
}
