import 'package:flutter/material.dart';

// import '../../models/Product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(rating: 4.0),
      body: Body(productId: agrs.productId),
    );
  }
}

class ProductDetailsArguments {
  final productId;

  ProductDetailsArguments({@required this.productId});
}
