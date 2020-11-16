import '../Services/firebaseservices.dart';
import 'package:flutter/material.dart';

class PhotoMoto extends ChangeNotifier {
  var _totalcartprices = 0;

  void getPricesOfProductsInCart() {
    _totalcartprices = 0;
    Map<String, dynamic> productMap;
    FirebaseServices _firebaseServices = FirebaseServices();
    _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .get()
        .then((document) => document.docs.forEach((element) {
              _firebaseServices.productsRef.doc(element.id).get().then((value) {
                productMap = value.data();

                _totalcartprices =
                    _totalcartprices + int.parse(productMap['price']);
              });
            }));

    notifyListeners();
  }

  get totalcartprices => _totalcartprices;
}
