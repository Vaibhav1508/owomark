import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:owomark/payment_method.dart';

class CheckoutScreen extends StatefulWidget {

  final int amount;
  final int method;

  CheckoutScreen({Key key, this.amount,this.method}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  FormField city;
  FormField date;
  FormField name;
  FormField email;
  FormField mobile;
  FormField address;

  @override
  Widget build(BuildContext context) {


    name = TextFormField(
        keyboardType: TextInputType
            .text, // Use email input type for emails.
        decoration: new InputDecoration(
          hintText: 'Full Name',
          labelText: 'Enter Your Name',
          icon: new Icon(Icons.person),
        ));
    city = TextFormField(
        keyboardType: TextInputType
            .text, // Use email input type for emails.
        decoration: new InputDecoration(
          hintText: 'City',
          labelText: 'Your City',
          icon: new Icon(Icons.pin_drop),
        ));

    email = TextFormField(
        keyboardType: TextInputType
            .text, // Use email input type for emails.
        decoration: new InputDecoration(
          hintText: 'Email',
          labelText: 'Enter Your Email',
          icon: new Icon(Icons.email),
        ));

    mobile = TextFormField(
        keyboardType: TextInputType
            .text, // Use email input type for emails.
        decoration: new InputDecoration(
          hintText: 'Mobile',
          labelText: 'Enter Your Mobile',
          icon: new Icon(Icons.phone),
        ));

    address = TextFormField(
        keyboardType: TextInputType
            .text, // Use email input type for emails.
        decoration: new InputDecoration(
          hintText: 'Address',
          labelText: 'Enter Your Address',

          icon: new Icon(Icons.home),
        ));


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
                  builder: (_) => PaymentMethod(),
                ),
              )),
          title: Text(
            'Checkout',
            style: TextStyle(color: Colors.black),
            //textAlign: TextAlign.center,
          ),
          elevation: 3.0,
        ),
        body: Container(
          height: double.infinity,
          padding: EdgeInsets.all(10),
          child: Card(

            color: Colors.white,

            child: ListView(
              padding: EdgeInsets.all(5),
              children: <Widget>[
                ListTile(
                  title: Text('Cost Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                Divider(),
                ListTile(
                  title: Text('Order Total',style: TextStyle(
                    fontSize: 18
                  ),),
                  trailing: Text(widget.amount.toString()+' Rs',style: TextStyle(
                    fontSize: 20
                  ),),
                ),
                Divider(),
                ListTile(
                  title: Text('Method Charge',style: TextStyle(
                      fontSize: 18
                  ),),
                  trailing:  Text(widget.amount.toString()+' Rs',style: TextStyle(
                      fontSize: 20
                  ),),
                ),
                Divider(),
                ListTile(
                  title: Text('Total Fees',style: TextStyle(
                      fontSize: 18
                  ),),
                  trailing: Text(widget.amount.toString()+' Rs',style: TextStyle(
                      fontSize: 20,color: Colors.orange
                  ),),
                ),

                SizedBox(height: 10,),
                Divider(),
                SizedBox(height: 5,),

                ListTile(
                  title: Column(
                    children: <Widget>[
                      CircleAvatar(backgroundColor: Colors.blue,child: Icon(Icons.person_outline),
                      radius: 25,),
                      SizedBox(height: 20,),
                      Text('Buyer Profile',style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                city,

                SizedBox(height: 5,),
                name,

                SizedBox(height: 5,),

                email,

                SizedBox(height: 5,),

                mobile,

                SizedBox(height: 5,),

                address,

                SizedBox(height: 10,),
                RaisedButton(
                  child: new Text(
                    'Proceed To Checkout',
                    style:
                    new TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () => () {},
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                ),



              ],
            ),
          )
        ));;
  }
}
