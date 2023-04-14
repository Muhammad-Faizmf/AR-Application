

// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter/categoryPages/TrendingCategoryPage.dart';
import 'package:login_flutter/getx/homepageController.dart';
import 'package:login_flutter/widgets/TrendingCard.dart';

class Trending extends StatefulWidget {
  const Trending ({ Key? key }) : super(key: key);

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {

  // final controller = Get.put(FetchProducts());

  // getDatafromFirebase() async {
  //   await FirebaseFirestore.instance
  //   .collection('products')
  //   .get()
  //   .then((QuerySnapshot? snapshot){
  //     snapshot!.docs.forEach((e) { 
  //       if(e.exists){
  //       controller.allproducts.add(
  //         Furniture(name: e['name'],
  //         image: e['imageUrl'],
  //         category: e['category'],
  //         description: e['description'],
  //         price: int.parse(e['price']),
  //         isTrending: e['trending'],
  //         render_image: e['image3dPath']
  //         )
  //       );
  //     } 
  //     });
  //   });
  //   print(controller.allproducts);
  //   print(controller.allproducts[1].name);
  // }

  // @override
  // void initState() {
  //  getDatafromFirebase();
  //   // TODO: implement initState
  //   super.initState();
  // }

  final Stream<QuerySnapshot> productStream = FirebaseFirestore.instance.collection('products').snapshots();

  final controllerList = Get.put(FetchProducts());


  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Text(
                      "Trending Furniture",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                    Get.to(TrendingCategoryPage(title: "Trending Furniture",)
                    );
                    },
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "View all",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.blue[600]
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              GetBuilder(
                init: FetchProducts(),
                builder: (controller){
                  return Container(
                decoration: BoxDecoration(
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 30.0,
                    children: controllerList.allproducts.where((element) => element.isTrending == true).map((e) {
                      return TrendingCard(
                        imagePath: e.image,
                        trendingTitle: e.name,
                        trendingPrice: e.price, itemdescription: e.description,
                        index: e,
                        render_image: e.render_image,
                        );
                    }).toList()
                  ),
                ),
              );
                }
              )
            ],
          ),
        );
  }
}
