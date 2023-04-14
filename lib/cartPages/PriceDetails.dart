// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter/getx/cartController.dart';

class PriceDetails extends StatelessWidget {
  PriceDetails({Key? key}) : super(key: key);

  final cartcontroller = Get.put(CartController());


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              offset: const Offset(0, 3),
              blurRadius: 5.0)
          ]
        ),
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: const [
          //     Text(
          //       "Sub-Total:",
          //       style: TextStyle(
          //         fontSize: 18.0,
          //         fontWeight: FontWeight.bold,
          //         color: Color(0xff475269)),
          //     ),
          //     Text(
          //        "0",
          //       style: TextStyle(
          //         fontSize: 18.0,
          //         fontWeight: FontWeight.bold,
          //         color: Color(0xff475269)),
          //     ),
          //   ],
          // ),
          // Divider(height: 30, thickness: 0.2, color: Color(0xff475269)),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: const [
          //     Text(
          //       "Delivery Fee:",
          //       style: TextStyle(
          //         fontSize: 18.0,
          //         fontWeight: FontWeight.bold,
          //         color: Color(0xff475269)),
          //     ),
          //     Text(
          //       "Rs 500",
          //       style: TextStyle(
          //         fontSize: 18.0,
          //         fontWeight: FontWeight.bold,
          //         color: Color(0xff475269)),
          //     ),
          //   ],
          // ),
          // Divider(height: 30, thickness: 0.2, color: Color(0xff475269)),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: const [
          //     Text(
          //       "Discount:",
          //       style: TextStyle(
          //         fontSize: 18.0,
          //         fontWeight: FontWeight.bold,
          //         color: Color(0xff475269)),
          //     ),
          //     Text(
          //       "Rs -1500",
          //       style: TextStyle(
          //         fontSize: 18.0,
          //         fontWeight: FontWeight.bold,
          //         color: Color(0xff475269)),
          //     ),
          //   ],
          // ),
          // Divider(height: 40, thickness: 0.6, color: Color(0xff475269)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff475269)),
              ),
              Obx(()=> Text(
                cartcontroller.cartLength.value == 0 ? "0" : 
                cartcontroller.cartitemTotalCost.value.toString(),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent),
              )
              )
            ],
          ),
        ],
      ),
    );
  }
}
