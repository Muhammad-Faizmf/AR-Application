
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:login_flutter/categoryPages/BedsCategoryPage.dart';
import 'package:login_flutter/categoryPages/ChairsCategoryPage.dart';
import 'package:login_flutter/categoryPages/DesksCategoryPage.dart';
import 'package:login_flutter/categoryPages/SofasCategoryPage.dart';
import 'package:login_flutter/categoryPages/TablesCategoryPage.dart';
import 'package:login_flutter/categoryPages/WardrobeCategoryPage.dart';

class CategoryCard extends StatelessWidget {
  String iconPath, title;
  CategoryCard({ Key? key, required this.iconPath, required  this.title }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(title == "Chair" ){
          Get.to(ChairsCategoryPage(title: title));
        }
        else if(title == "Bed"){
          Get.to(BedsCategoryPage(title: title));
        }
        else if(title == "Table"){
          Get.to(TablesCategoryPage(title: title));
        }
        else if(title == "Sofa"){
          Get.to(SofasCategoryPage(title: title));
        }
        else if(title == "Wardrobe"){
          Get.to(WardrobeCategoryPage(title: title));
        }
        else if(title == "Desk"){
          Get.to(DesksCategoryPage(title: title));
        }
        else{
          print("no selection");
        }
      },
      child: Container(
        height: 90,
        width: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset.zero,
              blurRadius: 15.0
            )
          ]
        ),
        child: Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            children: [
             Container(
                child: SvgPicture.asset(iconPath,
                width: 42.0,
              ),
              ),
              SizedBox(height: 5.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  height: 1.5
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}