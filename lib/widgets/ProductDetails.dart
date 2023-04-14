
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final itemDescription;
  const ProductDetails({ Key? key, required this.itemDescription }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
          ),
          SizedBox(height: 7.0),
          Text(
            itemDescription,
            textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20.0,
              ),
          ),
        ]
      )
    );
  }
}