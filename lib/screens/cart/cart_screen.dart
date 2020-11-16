import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart/components/body.dart';
import 'components/check_out_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      // bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final CollectionReference _usersRef =
        FirebaseFirestore.instance.collection("Users");

    User _user = FirebaseAuth.instance.currentUser;
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          StreamBuilder(
            stream: _usersRef.doc(_user.uid).collection("Cart").snapshots(),
            // ignore: missing_return
            builder: (context, snapshot) {
              int _totalItems = 0;
              // var productids;
              if (snapshot.connectionState == ConnectionState.active) {
                List _documents = snapshot.data.docs;
                _totalItems = _documents.length;
                // _documents.forEach((element) {
                //   productids = element.toString();
                // });
                return Text(
                  "$_totalItems",
                  style: Theme.of(context).textTheme.caption,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
