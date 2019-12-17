import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owomark/widgets/myinstitute.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

import 'api_interface.dart';
import 'inst_category.dart';
import 'models/institute_item.dart';

class Institute extends StatefulWidget {
  final String event_id;

  Institute({Key key, this.event_id}) : super(key: key);

  @override
  _InstituteState createState() => _InstituteState();
}

class _InstituteState extends State<Institute> {
  String insturl = 'http://owomark.com/owomarkapp/images/classes/';

  ApiInterface apiInterface = new ApiInterface();

  //Category List
  List<InstituteItem> institute = new List();

  String status = '';

  String base64Image;

  File tmpfile;

  Future<File> profileImage;

  String errormsg = 'error uploading image';

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

  int _currentTabIndex = 0;
  var title = TextEditingController();
  var name = TextEditingController();
  var location = TextEditingController();
  var address = TextEditingController();
  var education = TextEditingController();
  var email = TextEditingController();
  var exp = TextEditingController();
  var contact = TextEditingController();

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
          'Submit',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          if (name.text == null || profileImage == null) {
            SweetAlert.show(context,
                subtitle: 'Please provide details',
                style: SweetAlertStyle.error);
          } else {
            addInstitute(context, name.text, location.text, contact.text,
                email.text, address.text, exp.text, education.text, title.text);
            contact.text = "";
            profileImage = null;
            location.text = null;
            name.text = null;
            email.text = null;
            address.text = null;
            exp.text = null;
            education.text = null;
            title.text = null;
            institute.clear();
            getCategory(context);
          }
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

  Widget _nameField() {
    return new TextField(
      controller: this.title,
      decoration: new InputDecoration(
        hintText: "Institute Title",
        labelText: "Title",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _pubField() {
    return new TextField(
      controller: this.name,
      decoration: new InputDecoration(
        hintText: "Tutor Name",
        labelText: "Full Name",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _mrpField() {
    return new TextField(
      controller: this.location,
      decoration: new InputDecoration(
        hintText: "Location",
        labelText: "Location",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _authField() {
    return new TextField(
      controller: this.address,
      decoration: new InputDecoration(
        hintText: "Address",
        labelText: "Address",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _buypField() {
    return new TextField(
      controller: this.education,
      decoration: new InputDecoration(
        hintText: "Tutor Education",
        labelText: "Education",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _aboutField() {
    return new TextField(
      controller: this.exp,
      decoration: new InputDecoration(
        hintText: "Tutor Experience",
        labelText: "Experience",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _pickField() {
    return new TextField(
      controller: this.email,
      decoration: new InputDecoration(
        hintText: "Institute Email",
        labelText: "Email",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _contacttextField() {
    return new TextField(
      controller: this.contact,
      decoration: new InputDecoration(
        hintText: "Contact",
        labelText: "Mobile",
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
    final _kTabPages = <Widget>[
      institute.length == 0
          ? Center(
              child: Text(
                "No Institute Found",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              height: double.infinity,
              child: ListView.builder(
                itemCount: institute.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = institute[index];

                  return GestureDetector(
                    child: makeBestCategory(
                        image: insturl + item.imageUrl,
                        title: item.name,
                        contact: item.contact,
                        rate: item.rate,
                        location: item.location),
                  );
                },
              ),
            ),
      ListView(
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
          Text(
            'Add your Institute ',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _nameField(),
          SizedBox(
            height: 10,
          ),
          _chooseImage(),
          SizedBox(
            height: 5,
          ),
          showImage(),
          SizedBox(
            height: 20,
          ),
          _pubField(),
          SizedBox(
            height: 20,
          ),
          _mrpField(),
          SizedBox(
            height: 20,
          ),
          _authField(),
          SizedBox(
            height: 20,
          ),
          _buypField(),
          SizedBox(
            height: 20,
          ),
          _pickField(),
          SizedBox(
            height: 20,
          ),
          _aboutField(),
          SizedBox(
            height: 20,
          ),
          _contacttextField(),
          SizedBox(
            height: 20,
          ),
          _savebutton()
        ],
      ),
      Column(
        children: <Widget>[
          MyInstitute(),
        ],
      )
    ];

    final _kBottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.branding_watermark),
        title: Text('Institutes'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_circle_outline),
        title: Text('Add New Institute'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.branding_watermark),
        title: Text(
          'Your Institute',
        ),
      )
    ];

    assert(_kTabPages.length == _kBottomNavBarItems.length);

    final bottomNavbar = BottomNavigationBar(
      items: _kBottomNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 30.0,
            color: Colors.black,
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InstCategory(),
                  ),
                )),
        title: Text(
          'Institutes',
          style: TextStyle(color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        elevation: 3.0,
      ),
      body: _kTabPages[_currentTabIndex],
      bottomNavigationBar: bottomNavbar,
    );
  }

  @override
  void initState() {
    super.initState();
    getCategory(context);
  }

  getCategory(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getInstByCategory(widget.event_id);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            InstituteItem notificationItem = InstituteItem.fromMap(list[i]);
            institute.add(notificationItem);
          }
          setState(() {});
        } else {
          print('error');
        }
      }
    }, onError: (value) {
      print(value);
    });
  }

  addInstitute(
      context,
      String name,
      String location,
      String contact,
      String email,
      String address,
      String exp,
      String education,
      String title) async {
    if (tmpfile == null) {
      // List<int> imageBytes = profileImage.readAsBytesSync();
      // imgUrl = Base64Encoder().convert(imageBytes);
      //setStatus(errormsg);
    } else {}

    String user = '',city='';

    final prefs = await SharedPreferences.getInstance();
     user = prefs.getString('user');
      city = prefs.getString('city');
  

    String filename = tmpfile.path.split('/').last;

    Future<dynamic> response = apiInterface.addInstitute(
        name,
        location,
        contact,
        email,
        address,
        title,
        exp,
        education,
        base64Image,
        filename,
        city,
        user,
        widget.event_id);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          SweetAlert.show(
            context,
            title: 'Published !',
            subtitle: 'Submitted for Verification',
            style: SweetAlertStyle.success,
          );

          institute.clear();
          getCategory(context);

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

Widget makeBestCategory(
    {String image,
    String title,
    String contact,
    String rate,
    String location}) {
  return AspectRatio(
    child: Column(
      children: <Widget>[
        Container(
          height: 180,
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover)),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.2),
                ])),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: ListTile(
                  title: Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  
                )),
          ),
        ),
        ListTile(
          title: Text(
            contact,
            style: TextStyle(fontSize: 16),
          ),
          trailing: Icon(Icons.phone),
        ),
        Divider(),
        ListTile(
          title: Text(
            location,
            style: TextStyle(fontSize: 16),
          ),
          trailing: Icon(Icons.location_on),
        ),
      ],
    ),
    aspectRatio: 1 / 1,
  );
}
