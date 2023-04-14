// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter/cartPages/CartPage.dart';
import 'package:login_flutter/getx/cartController.dart';

class Cart extends StatefulWidget {


  const Cart({Key? key,}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Stack(
      children: [
        Container(
          child: IconButton(
            iconSize: 28.0,
            onPressed: () {
              Get.to(CartPage());
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
          ),
        ),
        // if (cartController.furniturelength > 0)
        if(cartController.cartLength.value > 0)
          Positioned(
            top: -1.0,
            right: -1.0,
            child: Container(
              alignment: Alignment.center,
              width: 18.0,
              height: 18.0,
              decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.0)),
              child:Obx(()=> Text(
                cartController.cartLength.value == 0 ? "0" : cartController.cartLength.toString(),
                // cartController.furniturelength == 0 ? 
                // "0" : cartController.furniturelength.toString(),
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                ),
              ),
              )
            ),
          )
      ],
    )
    );
  }
}
