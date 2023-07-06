// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';
import 'package:login_flutter/classModels/FurnitureModel.dart';

class FetchProducts extends GetxController {
  var allproducts = <Furniture>[];
  var isDeviceConnected = false.obs;

  getDatafromFirebase() async {
    allproducts.clear();
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot? snapshot) {
      snapshot!.docs.forEach((e) {
        if (e.exists) {
          allproducts.add(Furniture(
              // id: e['id'],
              name: e['name'],
              image: e['imageUrl'],
              category: e['category'],
              description: e['description'],
              price: int.parse(e['price']),
              isTrending: e['trending'],
              render_image: e['image3dPath']));
        }
      });
    });
    print(allproducts);
    allproducts.shuffle();
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getDatafromFirebase();
    super.onInit();
  }
}
