// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:login_flutter/getx/cartController.dart';
import 'package:login_flutter/getx/itemQuantityController.dart';

class CartItemSample extends StatelessWidget {
  CartItemSample({Key? key}) : super(key: key);

  final cartcontroller = Get.put(CartController());
  final itemcontroller = Get.put(ItemQuantity());

  deleteCartItem(String id) async {
    // CollectionReference db = FirebaseFirestore.instance.collection('cart');
    // db.doc(id).delete().then((value) => {});
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('cartitems')
        .doc(id)
        .delete()
        .then((value) => {});
  }

  increaseCartItemQuantity(
      String id, image, String name, String price, int qty) async {
    itemcontroller.itemquanity.value = qty;
    itemcontroller.itemquanity.value++;
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('cartitems')
        .doc(id)
        .update({
      'image': image,
      'name': name,
      'price': price,
      'quantity': itemcontroller.itemquanity.value
    });
    // FirebaseFirestore.instance.collection('cart').doc(id).update({'image' : image, 'name' : name, 'price' : price, 'quantity' : itemcontroller.itemquanity.value
    // });
  }

  decreaseCartItemQuantity(
      String id, image, String name, String price, int qty) async {
    itemcontroller.itemquanity.value = qty;
    itemcontroller.itemquanity.value--;
    if (itemcontroller.itemquanity.value >= 1) {
      //   FirebaseFirestore.instance.collection('cart').doc(id).update({'image' : image, 'name' : name, 'price' : price, 'quantity' : itemcontroller.itemquanity.value
      // });
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cartitems')
          .doc(id)
          .update({
        'image': image,
        'name': name,
        'price': price,
        'quantity': itemcontroller.itemquanity.value
      });
      int productprice = int.parse(price.toString());
      cartcontroller.cartitemTotalCost.value -= productprice;
    } else {
      print("quantity not decreased");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cartitems')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final List storedoc = [];
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          storedoc.add(a);
          a['id'] = document.id;
        }).toList();
        print("length: ${snapshot.data!.docs.length}");
        return Column(
          children: [
            for (var x = 0; x < storedoc.length; x++) ...[
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                padding: const EdgeInsets.all(10.0),
                height: 110,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: [
                    SizedBox(width: 10.0),
                    Container(
                        height: 90.0,
                        width: 90.0,
                        margin: const EdgeInsets.only(right: 15.0),
                        child: CachedNetworkImage(
                          imageUrl: storedoc[x]['image'],
                          placeholder: (context, url) => const Center(
                            child: SpinKitFadingCircle(
                              color: Colors.red,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text(
                              storedoc[x]['name'].toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff475269)),
                            ),
                          ),
                          Text(
                            storedoc[x]['price'].toString(),
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              // deleting cart item
                              deleteCartItem(storedoc[x]['id']);
                              cartcontroller.cartLength.value =
                                  cartcontroller.cartLength.value - 1;

                              //  deleting cart item price
                              cartcontroller.deductPrice(
                                  storedoc[x]['price'.toString()],
                                  storedoc[x]['quantity']);
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // spacing: 20.0,
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(20.0),
                                  onTap: () {
                                    decreaseCartItemQuantity(
                                        storedoc[x]['id'],
                                        storedoc[x]['image'],
                                        storedoc[x]['name'],
                                        storedoc[x]['price'],
                                        storedoc[x]['quantity']);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              offset: const Offset(0, 3),
                                              blurRadius: 10.0)
                                        ]),
                                    child: const Icon(
                                      CupertinoIcons.minus,
                                      size: 18.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: storedoc[x]['quantity'] <= 9
                                      ? Text(
                                          "0${storedoc[x]['quantity'].toString()}")
                                      : Text(
                                          storedoc[x]['quantity'].toString()),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(20.0),
                                  onTap: () async {
                                    cartcontroller.increaseQuantity(
                                        storedoc[x]['price'.toString()],
                                        storedoc[x]['quantity']);
                                    increaseCartItemQuantity(
                                        storedoc[x]['id'],
                                        storedoc[x]['image'],
                                        storedoc[x]['name'],
                                        storedoc[x]['price'],
                                        storedoc[x]['quantity']);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              offset: const Offset(0, 3),
                                              blurRadius: 10.0)
                                        ]),
                                    child: const Icon(
                                      CupertinoIcons.plus,
                                      size: 16.0,
                                    ),
                                  ),
                                )
                              ])
                        ],
                      ),
                    )
                  ],
                ),
              )
            ]
          ],
        );
      },
    );
  }
}
