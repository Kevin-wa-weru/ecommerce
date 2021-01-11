import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckoutScreen extends StatefulWidget {
  static String routeName = "/CheckoutScreen";
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");

  User _user = FirebaseAuth.instance.currentUser;

  int radiovalue;
  String radioValueSubmit;
  void handleRadioChange(int value) {
    setState(() {
      radiovalue = value;
      if (radiovalue == 0) {
        print('CS');
        radioValueSubmit = 'CS';
      } else {
        print('FD');
        radioValueSubmit = 'CS';
      }
    });
  }

  Future _addToOrders() {
    return _usersRef
        .doc(_user.uid)
        .collection("Orders")
        .doc('Orders (ids)')
        .set({
      "Product Ids": ['product id', 'product id'],
      "Total Price Paid": "2400",
      "Date Of Purchase": "12/12/2020",
      "Date Of Delivery": "14/12/2020",
      "Status Of Deliver": "Not Delivered",
      "Shippment Type": radioValueSubmit,
      "Success": ""
    });
  }

  var selectedCurrency, selectedType;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.ac_unit,
                color: Colors.white,
              ),
              onPressed: () {}),
          title: Container(
            alignment: Alignment.center,
            child: Text("Account Details",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.ac_unit,
                size: 20.0,
                color: Colors.white,
              ),
              onPressed: null,
            ),
          ],
        ),
        body: Form(
          key: _formKeyValue,
          // autovalidate: true,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            children: <Widget>[
              SizedBox(height: 20.0),
              SizedBox(height: 20.0),
              SizedBox(height: 40.0),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("depots")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data.docs[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.id,
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                            value: "${snap.id}",
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.shop,
                              size: 25.0, color: Colors.orangeAccent),
                          SizedBox(width: 50.0),
                          DropdownButton(
                            items: currencyItems,
                            onChanged: (currencyValue) {
                              final snackBar = SnackBar(
                                content: Text(
                                  'Selected Currency value is $currencyValue',
                                  style: TextStyle(color: Color(0xff11b719)),
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedCurrency = currencyValue;
                              });
                            },
                            value: selectedCurrency,
                            isExpanded: false,
                            hint: new Text("Choose Your Depot",
                                style: TextStyle(color: Colors.orangeAccent)),
                          ),
                        ],
                      );
                    }
                  }),
              SizedBox(
                height: 150.0,
              ),
              Center(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0, bottom: 8.0),
                    child: Text(
                      'Choose shippment Plan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        new Radio<int>(
                            activeColor: Colors.deepOrange,
                            value: 0,
                            groupValue: radiovalue,
                            onChanged: handleRadioChange),
                        new Text(
                          'Cost share (This will take at most four days)',
                          style: new TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        new Radio<int>(
                            activeColor: Colors.deepOrange,
                            value: 1,
                            groupValue: radiovalue,
                            onChanged: handleRadioChange),
                        new Text(
                          'Fast delivery-ksh 300 (This will take one day)',
                          style: new TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 60.0, right: 60.0, top: 20.0, bottom: 20.0),
                    alignment: Alignment.center,
                    child: new Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.deepOrange,
                            ),
                            onPressed: () {}),
                        new Expanded(
                          child: new RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.deepOrange,
                            onPressed: () {
                              _addToOrders();
                            },
                            child: new Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 20.0,
                              ),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Expanded(
                                    child: Text(
                                      "Proceed To Payment",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                      color: Color(0xff11b719),
                      textColor: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Submit", style: TextStyle(fontSize: 24.0)),
                            ],
                          )),
                      onPressed: () {},
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))),
                ],
              ),
            ],
          ),
        ));
  }
}
