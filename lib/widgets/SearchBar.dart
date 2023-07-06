import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter/widgets/SearchProduct.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.to(() => const SearchProduct());
        },
        child: Container(
          margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2.0)]),
          child: Row(
            children: const [
              Icon(
                Icons.search,
                color: Colors.black45,
              ),
              SizedBox(width: 10.0),
              Text(
                "Search for Furniture",
                style: TextStyle(color: Colors.black45, fontSize: 15.0),
              )
            ],
          ),
          // decoration: const InputDecoration(
          //   hintText: "Search for furniture...",
          //   hintStyle: TextStyle(
          //     color: Colors.black45,
          //     fontSize: 15.0
          //   ),
          //   contentPadding: EdgeInsets.symmetric(vertical: 15),
          //   prefixIcon: Icon(Icons.search, color: Colors.black45,),
          //   border: InputBorder.none
          // ),
        ));
  }
}
