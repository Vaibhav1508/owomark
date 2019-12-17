import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owomark/news_feed.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

import 'api_interface.dart';

class UploadNews extends StatefulWidget {
  final String comp_id;

  UploadNews({Key key, this.comp_id}) : super(key: key);

  @override
  _UploadNewsState createState() => _UploadNewsState();
}

class _UploadNewsState extends State<UploadNews> {
  ApiInterface apiInterface = new ApiInterface();

  String status = '';

  String base64Image;

  File tmpfile;

  Future<File> profileImage;

  String errormsg = 'error uploading image';

  Widget _savebutton() {
    return RaisedButton(
        color: Colors.green,
        padding: EdgeInsets.all(
          10.0,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.green)),
        highlightColor: Colors.black,
        child: new Text(
          'Upload',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          if (profileImage == null) {
            SweetAlert.show(context,
                style: SweetAlertStyle.error,
                title: 'Oops!',
                subtitle: "Please Choose Image");
          } else {
            addNews(context);
            profileImage = null;
          }
        });
  }

  Widget _chooseImage() {
    return RaisedButton(
        color: Colors.white,
        padding: EdgeInsets.all(
          10.0,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.green)),
        highlightColor: Colors.black,
        child: new Text(
          'Choose Image',
          style: TextStyle(color: Colors.green, fontSize: 20),
        ),
        onPressed: () {
          setState(() {
            profileImage = ImagePicker.pickImage(source: ImageSource.gallery);
          });
        });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: profileImage,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpfile = snapshot.data;

          base64Image = base64Encode(snapshot.data.readAsBytesSync());

          return Container(
            child: Image.file(snapshot.data, fit: BoxFit.fill),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'error picking image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text('No image selected');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 30.0,
            color: Colors.black,
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewsFeed(
                      comp_id: widget.comp_id,
                    ),
                  ),
                )),
        title: Text(
          'Add Photo',
          style: TextStyle(color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        elevation: 3.0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _chooseImage(),
            SizedBox(
              height: 20,
            ),
            showImage(),
            SizedBox(
              height: 20,
            ),
            Text(
              status,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            _savebutton()
          ],
        ),
      ),
    );
  }

  addNews(context) async {
    setState(() {});

    String filename = tmpfile.path.split('/').last;

     String user = '';

    final prefs = await SharedPreferences.getInstance();
     user = prefs.getString('user');


    Future<dynamic> response =
        apiInterface.addNews(user, widget.comp_id, base64Image, filename);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          profileImage = null;
          SweetAlert.show(context,
              style: SweetAlertStyle.success,
              title: 'Uploaded',
              subtitle: "Image Posted");
        } else {
          print('error');
        }
      }
    }, onError: (value) {
      print(value);
    });
  }
}
