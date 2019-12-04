import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owomark/models/book_item.dart';
import 'package:owomark/single_book.dart';
import 'package:owomark/widgets/mybooks.dart';
import 'package:sweetalert/sweetalert.dart';

import 'api_interface.dart';
import 'dashboard_screen.dart';

class OwosellScreen extends StatefulWidget {
  @override
  _OwosellScreenState createState() => _OwosellScreenState();
}

class _OwosellScreenState extends State<OwosellScreen> {
  int _currentTabIndex = 0;

  ApiInterface apiInterface = new ApiInterface();

  //Category List
  List<BookItem> books = new List();

  String status = '';

  String base64Image;

  File tmpfile;

  String errormsg = 'error uploading image';

  String producturl = 'http://owomark.com/owomarkapp/images/book/';

  Future<File> profileImage;
  var title = TextEditingController();
  var publication = TextEditingController();
  var mrp = TextEditingController();
  var author = TextEditingController();
  var buyprice = TextEditingController();
  var discount = TextEditingController();
  var pickup = TextEditingController();
  var about = TextEditingController();
  var controller8 = TextEditingController();

  Widget _savebutton() {
    return RaisedButton(
        color: Colors.blue,
        padding: EdgeInsets.all(
          10.0,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.blue)),
        highlightColor: Colors.black,
        child: new Text(
          'Submit',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          if (title.text != "" ||
              publication != "" ||
              author != "" ||
              buyprice != "" ||
              mrp != "") {
            addSellBook(
                context,
                title.text,
                author.text,
                publication.text,
                mrp.text,
                buyprice.text,
                pickup.text,
                about.text,
                discount.text);
            title.text = "";
            author.text = "";
            publication.text = "";
            mrp.text = "";
            buyprice.text = "";
            pickup.text = "";
            about.text = "";
            discount.text = "";
            profileImage = null;
          } else {
            SweetAlert.show(
              context,
              title: 'Oops !',
              subtitle: 'Please provide valid details',
              style: SweetAlertStyle.error,
            );
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
            side: BorderSide(color: Colors.blue)),
        highlightColor: Colors.black,
        child: new Text(
          'Choose Image',
          style: TextStyle(color: Colors.blue, fontSize: 20),
        ),
        onPressed: () {
          setState(() {
            profileImage = ImagePicker.pickImage(source: ImageSource.gallery);
          });
        });
  }

  Widget _rechargeButton() {
    return RaisedButton(
        color: Colors.blue,
        padding: EdgeInsets.all(
          15.0,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.blue)),
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
        hintText: "Book Title",
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
      controller: this.publication,
      decoration: new InputDecoration(
        hintText: "Book Publication",
        labelText: "Publicataion",
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
      controller: this.mrp,
      decoration: new InputDecoration(
        hintText: "MRP",
        labelText: "MRP Amount",
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
      controller: this.author,
      decoration: new InputDecoration(
        hintText: "Author",
        labelText: "Book Author",
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
      controller: this.buyprice,
      decoration: new InputDecoration(
        hintText: "Buy Price",
        labelText: "Book Buy Price",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _discount() {
    return new TextField(
      controller: this.discount,
      decoration: new InputDecoration(
        hintText: "Discount %",
        labelText: "Discunt",
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
      controller: this.about,
      decoration: new InputDecoration(
        hintText: "About",
        labelText: "Book About",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
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

  Widget _pickField() {
    return new TextField(
      controller: this.pickup,
      decoration: new InputDecoration(
        hintText: "Pickup",
        labelText: "Book Pickup Location",
        labelStyle: new TextStyle(color: const Color(0xFF424242)),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  Widget _coupontextField() {
    return new TextField(
      controller: this.controller8,
      decoration: new InputDecoration(
        hintText: "Type coupon code",
        labelText: "Coupon Code",
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
      books.length == 0
          ? Center(
              child: Text(
                "No Data Found",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              height: double.infinity,
              child: ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = books[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SingleBook(
                                    project_id: item.id,
                                  ))),
                      child: makeBestCategory(
                          image: producturl + item.imageUrl,
                          title: item.title,
                          price: item.buy_price,
                          pickup: item.pickup),
                    );
                  }),
            ),
      ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.blue,
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
            'Add your Book ',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: 10,
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
                color: Colors.green, fontWeight: FontWeight.w500, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          _nameField(),
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
          _discount(),
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
          _savebutton()
        ],
      ),
      Column(
        children: <Widget>[
          MyBooks(),
        ],
      )
    ];

    final _kBottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.collections_bookmark),
        title: Text('Owoseller'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_circle_outline),
        title: Text('Add New Book'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.book),
        title: Text(
          'Your Books',
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
                    builder: (_) => DashboardScreen(),
                  ),
                )),
        title: Text(
          'Owosell',
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
    getBooks(context);
  }

  getBooks(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getOwoselleBook('ahmedabad', '216');

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            BookItem notificationItem = BookItem.fromMap(list[i]);
            books.add(notificationItem);
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

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  //Books Insert Api

  addSellBook(
      context,
      String title,
      String author,
      String publication,
      String mrp,
      String buy_price,
      String pickup,
      String info,
      String discount) async {
    if (tmpfile == null) {
      // List<int> imageBytes = profileImage.readAsBytesSync();
      // imgUrl = Base64Encoder().convert(imageBytes);
      setStatus(errormsg);
    } else {}

    String filename = tmpfile.path.split('/').last;

    Future<dynamic> response = apiInterface.addSellBook(
        title,
        publication,
        author,
        mrp,
        discount,
        buy_price,
        pickup,
        info,
        filename,
        base64Image,
        '1',
        'ahmedabad',
        '216');

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          SweetAlert.show(
            context,
            title: 'Published !',
            subtitle: 'Your book is uploaded',
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

Widget makeBestCategory(
    {String image, String title, String price, String pickup}) {
  return AspectRatio(
    child: Column(
      children: <Widget>[
        Container(
          height: 150,
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
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
        ),
        ListTile(
          title: Text(
            "Buy Price : " + price + "Rs",
            style: TextStyle(fontSize: 16),
          ),
          trailing: Icon(Icons.card_giftcard),
        ),
        ListTile(
          title: Text(
            "Location : " + pickup,
            style: TextStyle(fontSize: 16),
          ),
          trailing: Icon(Icons.location_on),
        ),
        Divider(),
        ListTile(
          title: Text(
            "View More",
            style: TextStyle(fontSize: 16, fontFamily: 'maven_black'),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ],
    ),
    aspectRatio: 1 / 1,
  );
}
