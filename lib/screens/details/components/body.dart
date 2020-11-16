import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/screens/details/components/product_size.dart';
// import 'package:shop_app/models/Product.dart';
import 'package:shop_app/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:provider/provider.dart';
import '../../../models/Cart.dart';

class Body extends StatefulWidget {
  final productId;

  const Body({Key key, @required this.productId}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");

  User _user = FirebaseAuth.instance.currentUser;
  String _selectedProductSize = "0";
  Future _addToCart() {
    Provider.of<PhotoMoto>(context, listen: false).getPricesOfProductsInCart();
    return _usersRef
        .doc(_user.uid)
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  final SnackBar _snackBar = SnackBar(
    content: Text("Product added to the cart"),
  );
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _productsRef.doc(widget.productId).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          // Firebase Document Data Map
          Map<String, dynamic> documentData = snapshot.data.data();

          // List of images
          List imageList = documentData['images'];
          List productSizes = documentData['sizes'];

          return ListView(
            children: [
              Column(
                children: [
                  ProductImages(productimages: imageList),
                  TopRoundedContainer(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ProductDescription(
                          productdescription: documentData['description'],
                          productname: documentData['name'],
                          pressOnSeeMore: () {},
                        ),
                        TopRoundedContainer(
                          color: Color(0xFFF6F7F9),
                          child: Column(
                            children: [
                              // ColorDots(product: product),
                              ProductSize(
                                productSizes: productSizes,
                                onSelected: (size) {
                                  _selectedProductSize = size;
                                },
                              ),
                              TopRoundedContainer(
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: SizeConfig.screenWidth * 0.15,
                                    right: SizeConfig.screenWidth * 0.15,
                                    bottom: getProportionateScreenWidth(40),
                                    top: getProportionateScreenWidth(15),
                                  ),
                                  child: DefaultButton(
                                    text: "Add To Cart",
                                    press: () async {
                                      await _addToCart();
                                      Scaffold.of(context)
                                          .showSnackBar(_snackBar);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        }

        // Loading State
        return Scaffold(
          body: Center(
            child: Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
