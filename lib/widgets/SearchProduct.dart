
// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, invalid_use_of_protected_member, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:login_flutter/categoryPages/ProductDescription.dart';
import 'package:login_flutter/classModels/FurnitureModel.dart';
import 'package:login_flutter/getx/homepageController.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({ Key? key }) : super(key: key);

  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {

  final controller = Get.put(FetchProducts());

  List<Furniture> display_list = List.from(FetchProducts().allproducts);

  searchFurnitureList(String value){
      setState(() {
        display_list = controller.allproducts.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Container(
          width: double.infinity,
          height: 45.0,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: TextField(
              onChanged: (value) => searchFurnitureList(value),
              autofocus: true,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                hintText: "Search for furniture...",
                hintStyle: TextStyle(
                  color: Colors.black45,
                  fontSize: 15.0
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)
                ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)
                ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 6),
                prefixIcon: Icon(Icons.search, color: Colors.black45,),
                border: InputBorder.none,
                ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: display_list.length,
        itemBuilder: ((context, index) => Container(
          alignment: Alignment.center,
          height: 80.0,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            elevation: 5.0,
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: InkWell(
                onTap: (){
                  Get.to(
                    () => ProductDescription(
                    ImagePath: display_list[index].image,
                    title: display_list[index].name,
                    price: display_list[index].price,
                    description: display_list[index].description,
                    index: display_list[index], render_image: display_list[index].render_image,
                  )
                  );
                },
                child: ListTile(
                  leading: Container(
                    width: 50.0,
                    height: 50.0,
                    child: CachedNetworkImage(
                      imageUrl: display_list[index].image,
                      placeholder: (context, url) => const Center(child: SpinKitFadingCircle(
                        color: Colors.red, 
                      ),),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),

                  title: Text(display_list[index].name.       toString(), style: TextStyle(fontSize: 16.0)),

                  trailing: Text("Rs ${display_list[index].price}", style: TextStyle(fontSize: 16.0, color: Colors.redAccent)),
                ),
              ),
            ),
          ),
        )
        )
      )
      );
  }
}