import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

import 'api_interface.dart';
import 'dashboard_screen.dart';
import 'models/users_item.dart';

class AddPg extends StatefulWidget {
  @override
  _AddPgState createState() => _AddPgState();
}

class _AddPgState extends State<AddPg> {
  ApiInterface apiInterface = new ApiInterface();

  //Event List
  List<UsersItem> user = new List();

   String status = '';

  String base64Image;

  File tmpfile;

  String errormsg = 'error uploading image';


  Future<File> profileImage;


  var title = TextEditingController();
  var mobile = TextEditingController();
  var address = TextEditingController();
  var location = TextEditingController();

  var desc = TextEditingController();
  var price = TextEditingController();

  Widget _titletextField() {
    return new TextField(
      controller: this.title,
      decoration: new InputDecoration(
        hintText: "2 BHK ",
        labelText: "Title",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
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


  Widget _rechargeButton() {
    return RaisedButton(
        color: Colors.green,
        padding: EdgeInsets.all(
          15.0,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.green)),
        highlightColor: Colors.black,
        child: new Text(
          'Recharge',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {});
  }


  Widget _desctextField() {
    return new TextField(
      controller: this.desc,
      
      decoration: new InputDecoration(
        hintText: "Enter Pg Description",
        labelText: "Description",
        
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _pricetextField() {
    return new TextField(
      controller: this.price,
      decoration: new InputDecoration(
        hintText: "Enter Rent Amount",
        labelText: "Rent",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _mobiletextField() {
    return new TextField(
      controller: this.mobile,
      enabled: false,
      decoration: new InputDecoration(
        hintText: "Enter Value",
        labelText: "Mobile Number",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _addresstextField() {
    return new TextField(
      controller: this.address,
      decoration: new InputDecoration(
        hintText: "Enter Pg Address",
        labelText: "Address",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _savebutton() {
    return RaisedButton(
        color: Colors.green,
        padding: EdgeInsets.all(
          15.0,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.green)),
        highlightColor: Colors.black,
        child: new Text(
          'Submit',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {

          if(title.text!=null){
            addPg(context, title.text, desc.text, price.text,location.text,address.text);
           setState(() {
              title.text="";
            desc.text="";
            price.text="";
            profileImage = null;
            location.text = "";
            address.text="";
           });
          }else{
             
             Fluttertoast.showToast(msg:'Please Provide details',toastLength: Toast.LENGTH_SHORT,);
   }
        });
  }

  Widget _locationtextField() {
    return new TextField(
      controller: this.location,
      decoration: new InputDecoration(
        hintText: "Enter Pg landmark",
        labelText: "Location",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 30.0,
            color: Colors.black,
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DashboardScreen(),
                  ),
                )),
        title: Text(
          'Add New Pg',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 4.0,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.green,
            child: Icon(
              Icons.note_add,
              size: 45,
              color: Colors.white,
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
          _titletextField(),
          SizedBox(
            height: 20,
          ),
          _desctextField(),
          SizedBox(
            height: 20,
          ),
          _pricetextField(),
                    SizedBox(
            height: 20,
          ),
          _locationtextField(),
               SizedBox(
            height: 20,
          ),
          _addresstextField(),
               SizedBox(
            height: 20,
          ),
          
          _savebutton(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
   // getProfille(context);
  }

  addPg(
      context,
      String title,
      String desc,
      String price,
      String location,
      String address,
      ) async {
    if (tmpfile == null) {
      // List<int> imageBytes = profileImage.readAsBytesSync();
      // imgUrl = Base64Encoder().convert(imageBytes);
     // setStatus(errormsg);
    } else {}

    String filename = tmpfile.path.split('/').last;

     String user = '',city='';

    final prefs = await SharedPreferences.getInstance();
     user = prefs.getString('user');
      city = prefs.getString('city');
  

    Future<dynamic> response = apiInterface.addPg(
        title,desc,price,filename,base64Image,user,city,location,address);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          SweetAlert.show(
            context,
            title: 'Added !',
            subtitle: 'Your Pg is uploaded',
            style: SweetAlertStyle.success,
          );

          setState(() {});
        } else {
          print('error');
        }
      }
    }, onError: (value) {
      print(value);
    });
  }

 
}
