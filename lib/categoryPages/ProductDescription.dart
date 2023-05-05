// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter/getx/itemQuantityController.dart';
import 'package:login_flutter/widgets/BottomBar.dart';
import 'package:login_flutter/widgets/Cart.dart';
import 'package:login_flutter/widgets/ProductDetails.dart';
import 'package:login_flutter/widgets/ViewitemAR.dart';

class ProductDescription extends StatefulWidget {
  final ImagePath;
  final title;
  final price;
  final description;
  final index;
  final render_image;

  const ProductDescription(
      {Key? key,
      required this.ImagePath,
      required this.title,
      required this.price,
      required this.description,
      required this.index,
      required this.render_image})
      : super(key: key);

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {

  final controller = Get.put(ItemQuantity());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFEDECF2),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          widget.title.toString(),
          style: TextStyle(
              fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
        actions: [Container(padding: EdgeInsets.all(5.0), child: Cart())],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          ViewItemAR(
            ImagePath: widget.ImagePath,
            renderImage: widget.render_image,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ProductDetails(itemDescription: widget.description),
          ),
          SizedBox(height: 5.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quantity",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(20.0),
                          onTap: () {
                            controller.decreaseitemQuantity();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
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
                        //  SizedBox(width: 25.0),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Obx(() => controller.itemquanity.value <= 9 ? Text("0${controller.itemquanity.toString()}"
                            ) : Text(controller.itemquanity.toString())
                            )),
                        InkWell(
                          borderRadius: BorderRadius.circular(20.0),
                          onTap: () {
                            controller.increaseitemQuantity();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      offset: const Offset(0, 3),
                                      blurRadius: 10.0)
                                ]),
                            child: const Icon(
                              CupertinoIcons.add,
                              size: 18.0,
                            ),
                          ),
                        ),
                      ]),
                )
              ],
            ),
          ),
          SizedBox(height: 10.0,)
        ],
      ),
      bottomNavigationBar: BottomBar(
          name: widget.title,
          image: widget.ImagePath,
          price: widget.price,
          ),
    );
  }
  
}
