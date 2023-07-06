// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter/getx/cartController.dart';
import 'package:login_flutter/getx/homepageController.dart';
import 'package:login_flutter/widgets/All_items.dart';
import 'package:login_flutter/widgets/Cart.dart';
import 'package:login_flutter/widgets/Category.dart';
import 'package:login_flutter/widgets/Header.dart';
import 'package:login_flutter/my_drawer/Mydrawer.dart';
import 'package:login_flutter/widgets/Trending.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(FetchProducts());
  final cartController = Get.put(CartController());
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  getCartItemLength() async {
    int price;
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('cartitems')
        .get()
        .then((snap) => {
              if (snap.docs.isNotEmpty)
                {
                  cartController.cartLength.value = snap.docs.length,
                  for (var x = 0; x < snap.docs.length; x++)
                    {
                      cartController.addPrice(snap.docs[x]['price'.toString()],
                          snap.docs[x]['quantity']),
                    }
                }
              else
                {
                  cartController.cartLength.value = 0,
                  cartController.cartitemTotalCost.value = 0
                }
            });
  }

  checkInternetConneciton() async {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        controller.isDeviceConnected.value = true;
      } else {
        showDialog("not connected");
        controller.isDeviceConnected.value = false;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Furniture Shop",
          style: TextStyle(
              fontSize: 28.0,
              color: Colors.black,
              height: 1,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Cart(),
          )
        ],
      ),
      drawer: Drawer(
        width: 250.0,
        child: MyDrawer(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Future.delayed(Duration(seconds: 2));
          controller.getDatafromFirebase();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Header(), Category(), Trending(), AllItems()],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getCartItemLength();
    checkInternetConneciton();
    super.initState();
  }

  showDialog(String msg) {
    Get.defaultDialog(
        barrierDismissible: false,
        title: "Internet Connection",
        middleText: "Please make sure your device is connected to the internet",
        confirm: ElevatedButton(
            onPressed: () {
              controller.isDeviceConnected.value == false
                  ? Container()
                  : Navigator.of(context).pop();
            },
            child: Text("OK")));
  }
}
