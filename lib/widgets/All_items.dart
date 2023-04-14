


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:login_flutter/categoryPages/ProductDescription.dart';
import 'package:login_flutter/getx/homepageController.dart';

class AllItems extends StatefulWidget {
  const AllItems({ Key? key }) : super(key: key);

  @override
  _AllItemsState createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {
  
  final controllerList = Get.put(FetchProducts());
  
  @override
  Widget build(BuildContext context) {
     return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: GetBuilder(
        init: FetchProducts(),
        builder: (controller){
          return GridView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 12.0,
            mainAxisExtent: 305
          ),
          children: controllerList.allproducts.where((element) => element.isTrending == false).map((e) {
            return InkWell(
              borderRadius: BorderRadius.circular(10.0),
              onTap: (){
                Get.to(ProductDescription(
                  ImagePath: e.image,
                  title: e.name,
                  price: e.price,
                  description: e.description,
                  index: e, render_image: e.render_image,
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: Offset.zero,
                      blurRadius: 20.0
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)
                      ),
                      child: CachedNetworkImage(
                      imageUrl: e.image,
                      placeholder: (context, url) => const Center(child: SpinKitFadingCircle(
                        color: Colors.red, 
                      ),),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 240.0,
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.name,
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
                                color: Colors.red[500]
                              ),
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
        }
      )
    );
  }
}





