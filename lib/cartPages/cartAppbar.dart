
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartAppbar extends StatelessWidget {
  const CartAppbar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          InkWell(
            onTap: (){
              Get.back();
            },
            child: const Icon(Icons.arrow_back, color: Colors.black, size: 30.0,),
          ),
          const Text(
            "Cart",
            style: TextStyle(
              fontSize: 27.0,
              fontWeight: FontWeight.bold,
            ),
          ),
           InkWell(
            onTap: (){
             print("more vert is tapped");
            },
            child: const Icon(null),
          ),
        ],
      ),
    );
  }
}