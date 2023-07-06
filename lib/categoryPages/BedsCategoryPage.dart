// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter/categoryPages/ProductDescription.dart';
import 'package:login_flutter/getx/homepageController.dart';

class BedsCategoryPage extends StatefulWidget {
  final title;
  const BedsCategoryPage({Key? key, required this.title}) : super(key: key);

  @override
  _BedsCategoryPageState createState() => _BedsCategoryPageState();
}

class _BedsCategoryPageState extends State<BedsCategoryPage> {
  final controllerList = Get.put(FetchProducts());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            widget.title,
            style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black)),
          // actions: [
          //   IconButton(onPressed: () {
          //     print("wardrobe search is clicked");
          //   },
          //    icon: const Icon(Icons.search, color: Colors.black,)
          //   )
          // ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GetBuilder(
                init: FetchProducts(),
                builder: (controller) {
                  return GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 12.0,
                            mainAxisExtent: 305),
                    children: controllerList.allproducts
                        .where((element) => element.category == "BED")
                        .map((e) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: () {
                          Get.to(ProductDescription(
                            ImagePath: e.image,
                            title: e.name,
                            price: e.price,
                            description: e.description,
                            index: e,
                            render_image: e.render_image,
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    offset: Offset.zero,
                                    blurRadius: 20.0)
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)),
                                  child: Image.network(
                                    e.image,
                                    fit: BoxFit.cover,
                                    height: 240,
                                    width: double.infinity,
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        "Rs ${e.price.toString()}",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red[500]),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                })));
  }
}
