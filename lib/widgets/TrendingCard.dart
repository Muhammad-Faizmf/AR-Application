
// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:login_flutter/categoryPages/ProductDescription.dart';


class TrendingCard extends StatelessWidget {
  final imagePath;
  final trendingTitle;
  final trendingPrice;
  final itemdescription;
  final index;
  final render_image;
  
  const TrendingCard({ Key? key, required this.imagePath, required this.trendingTitle, required this.trendingPrice, required this.itemdescription, required this.index, required this.render_image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(7.0),
      onTap: (){
        Get.to(ProductDescription(
        ImagePath: imagePath,
        title: trendingTitle,
        price: trendingPrice,
        description: itemdescription,
        index: index,
        render_image: render_image,
        ));
      },
      child: Container(
        height: 200,
        width: 290,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7.0),
          boxShadow: [
            BoxShadow(
             color: Colors.black.withOpacity(0.1),
              offset: Offset.zero,
              blurRadius: 15.0
            )
          ],
          
        ),
        child: CachedNetworkImage(
          imageUrl:imagePath,
          placeholder: (context, url) => const Center(child: SpinKitFadingCircle(
            color: Colors.red, 
          ),),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
          width: double.infinity,
          height: 240.0,
      ),
      ),
    );
  }
}