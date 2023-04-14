
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:login_flutter/widgets/SearchBar.dart';


class Header extends StatefulWidget {
  const Header({ Key? key }) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text(
              //   "Furniture Shop",
              //   style: TextStyle(
              //     fontSize: 28.0,
              //     height: 1,
              //     fontWeight: FontWeight.bold
              //   ),
              // ),
              // Cart()
            ],
          ),
          Center(
            child: Text(
              "Get unique furniture for your home",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black45
              ),
              ),
          ),
          SearchBar()
        ],
      ),
    );
  }
}