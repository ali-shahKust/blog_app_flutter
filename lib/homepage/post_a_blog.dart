import 'dart:async';
import 'dart:io';

import 'package:blog_app_flutter/homepage/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:progress_dialog/progress_dialog.dart';



final auth = FirebaseAuth.instance;
final reference = Firestore.instance.collection('Blogs');
final databaseReference = Firestore.instance;
String url;
ProgressDialog pr;

String myName = '';
String abtMe = '';
String myDp = '';
String mDp = '';
String mName = '';
String mUid = '';
String mStatus = '';

DocumentSnapshot mRef;
//final analytics = new FirebaseAnalytics();
class PostBlogPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: <String, WidgetBuilder>{
        "/home": (BuildContext context) => new HomePageLoader(),
      },
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Post Blog..'),
          ),
          body: new _PostPage()),
    );
  }
}

class _PostPage extends StatefulWidget {

  @override
  _PostPageState createState() => new _PostPageState();
}

class _PostPageState extends State<_PostPage> {
  File _image;
  final TextEditingController _title = new TextEditingController();
  final TextEditingController _desc = new TextEditingController();
  bool _isTitle = false;
  bool _isDesc = false;
  bool _isImage = false;
  bool _isLoading = false;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);

    return new Container(
      child: new SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: new Container(
          child: new Column(
            children: <Widget>[
              new Padding(padding: const EdgeInsets.only(top: 24.0)),
              new InkWell(
                child: _image == null
                    ? new Image.asset(
                        'images/profile.png',
                        height: 200.0,
                        width: 300.0,
                        fit: BoxFit.fill,
                      )
                    : new Image.file(
                        _image,
                        height: 200.0,
                        width: 300.0,
                      ),
                onTap: () {
                  getImage();
                  _isImage = true;
                },
              ),
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextField(
                  controller: _title,
                  style: new TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  onChanged: (String text) {
                    setState(() {
                      _isTitle = text.length > 0;
                    });
                  },
                  decoration: new InputDecoration.collapsed(
                    hintText: "Title",
                    border: new UnderlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.blueAccent,
                          style: BorderStyle.solid,
                          width: 5.0),
                    ),
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextField(
                  controller: _desc,
                  style: new TextStyle(color: Colors.black, fontSize: 18.0),
                  onChanged: (String text) {
                    setState(() {
                      _isDesc = text.length > 0;
                    });
                  },
                  decoration: new InputDecoration.collapsed(
                    hintText: "Description",
                    border: new UnderlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.blueAccent,
                          style: BorderStyle.solid,
                          width: 5.0),
                    ),
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new RaisedButton(
                  padding: const EdgeInsets.only(
                      left: 45.0, right: 45.0, top: 15.0, bottom: 15.0),
                  color: Colors.blueAccent,
                  elevation: 2.0,
                  child: new Text(
                    "Post",
                    style: new TextStyle(color: Colors.white),
                  ),
                  onPressed: _isTitle && _isDesc && _isImage && !_isLoading
                      ? () => _handleSubmitted(_title.text, _desc.text, _image)
                      : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Uri> _handleSubmitted(String title, String desc, File img) async {
    setState(() {
      _isLoading = true;
    });
     mUid = (await FirebaseAuth.instance.currentUser()).uid;

    mRef = await Firestore.instance
        .collection("Users")
        .document((await FirebaseAuth.instance.currentUser()).uid)
        .get();

    pr.style(
        message: 'Uploading Blog...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    await pr.show();
    StorageReference ref = FirebaseStorage.instance.ref().child("Blog_Images/" +
        new DateTime.now().millisecondsSinceEpoch.toString()); //new
    StorageUploadTask uploadTask = ref.putFile(img);

    uploadTask.onComplete.then((result) async {
      pr.update(
        progress: 50.0,
        message: "Please wait...",
        progressWidget: Container(
            padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
      );

      pr.hide().then((isHidden) {
        print(isHidden);
      });
      url = await result.ref.getDownloadURL();
      Fluttertoast.showToast(
          msg: 'Picture Uploaded Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0
      );
      _addBlog(title, desc, url.toString(), mUid);
      setState(() {

      });
    });
  }

  void _addBlog(String title, String description, String imageUrl, String mUid) {
    reference.add({
      'image': imageUrl,
      'title': title,
      'description': description,
      'uid': mUid,
      'user_name': mRef['user_name'],
    });
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text("Posted Successfully!"),
    ));

  }
}
