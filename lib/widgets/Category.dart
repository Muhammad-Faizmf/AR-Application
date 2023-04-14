
// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter/classModels/category.dart';
import 'package:login_flutter/getx/login_controller.dart';
import 'package:login_flutter/widgets/CategoryCard.dart';

class Category extends StatefulWidget {
  const Category({ Key? key }) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {


   final login_controller = Get.put(LoginController());
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 30.0,
                children: [
                  for(int x=0; x < category.length; x++)...[
                    CategoryCard(
                      iconPath: category[x].iconPath,
                      title: category[x].title,
                    ),
                  ]
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

