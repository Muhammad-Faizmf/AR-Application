// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter/getx/cartController.dart';
import 'package:login_flutter/getx/homepageController.dart';
import 'package:login_flutter/getx/itemQuantityController.dart';

class BottomBar extends StatefulWidget {
  final name;
  final image;
  final price;
  // final itemquanity;

  const BottomBar({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final cartcontroller = Get.put(CartController());

  final controller = Get.put(FetchProducts());

  final itemcontroller = Get.put(ItemQuantity());

  Future checkItemInCards() async {
    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cartitems')
          .where('name', isEqualTo: widget.name)
          .get()
          .then((value) => {
            if (value.docs.isNotEmpty)
              {cartcontroller.isAlreadyAvailable.value = true}
            else
              {cartcontroller.isAlreadyAvailable.value = false}
          });
          } catch (e) {
            print("Error: $e");
          }
        }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 70.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: Offset(0, 3))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rs ${widget.price.toString()}",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
              Obx(() =>  cartcontroller.isAlreadyAvailable.value  ? ElevatedButton.icon(
                onPressed: null,
                label: Text("Add to Cart",
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                icon: Icon(CupertinoIcons.cart_badge_plus),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 15.0)
                      )
                    ),
              ) : ElevatedButton.icon(
                    onPressed: () async {
                      checkItemInCards();
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .collection("cartitems")
                          .doc()
                          .set({
                        "name": widget.name,
                        "image": widget.image,
                        "price": widget.price.toString(),
                        "quantity": itemcontroller.itemquanity.value
                      });
                      cartcontroller.addPrice(widget.price.toString(),
                          itemcontroller.itemquanity.value);
                      Get.snackbar("Product", "${widget.name} added Sucessfully", snackPosition: SnackPosition.TOP, duration: Duration(seconds: 1));
                      // add cart items length
                      cartcontroller.cartLength.value =
                        cartcontroller.cartLength.value + 1;
                    },
                    label: Text(
                      "Add to Cart",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    icon: Icon(CupertinoIcons.cart_badge_plus),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 15.0)
                          )
                        ),
                  )
                )
            ],
          ),
        ),
      ),
    );
  }

  showDialog() {
    Get.defaultDialog(
        title: "Item",
        titleStyle: TextStyle(fontWeight: FontWeight.bold),
        content: Text(
          "Furniture added Successfully.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 19.0),
        ),
        // onConfirm: (){
        //   Get.back();
        // },
        confirmTextColor: Colors.white);
  }

  @override
  void initState() {
    print("called");
    checkItemInCards();
    // TODO: implement initState
    super.initState();
  }
}
