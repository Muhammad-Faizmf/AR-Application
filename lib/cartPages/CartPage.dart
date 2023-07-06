// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_flutter/cartPages/BuyProduct.dart';
import 'package:login_flutter/cartPages/CartItemSample.dart';
import 'package:login_flutter/cartPages/PriceDetails.dart';

import 'cartAppbar.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const CartAppbar(),
          Container(
            padding: const EdgeInsets.only(top: 10.0),
            decoration: const BoxDecoration(color: Color(0xffedecf2)),
            child: Column(
              children: [CartItemSample(), PriceDetails(), BuyProduct()],
            ),
          )
        ],
      ),
    );
  }
}
