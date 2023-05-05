
// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter/getx/buyController.dart';
import 'package:login_flutter/getx/cartController.dart';

class BuyProduct extends StatelessWidget {
  BuyProduct({Key? key}) : super(key: key);

  final buycontroller = Get.put(BuyController());
  final cartcontroller = Get.put(CartController());

  addOrdersToFirebase(String fullname, String address, String mblNo, String city) async {
     var cartItemList = [];

     await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.email).collection('cartitems').get().then((QuerySnapshot? snapshot){
       snapshot!.docs.forEach((element) {
         cartItemList.add({
           "name" : element['name'],
           'price' : element['price'],
           'image' : element['image'],
           'quantity' : element['quantity']
         });
        });
     });
    print("cart items ${cartItemList[0]['name']}");
    await FirebaseFirestore.instance.collection('orders').add({
      "email" : FirebaseAuth.instance.currentUser!.email, 
      "fullname" : fullname,
      "address" : address,
      "mobile_number" : mblNo,
      "city" : city,
      "total": cartcontroller.cartitemTotalCost.value,
      "items" : cartItemList,
      "order_status" : "PENDING"
    });
    cartItemList.clear();
  }

  deleteAllcartItems() async {
    var collection = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.email).collection('cartitems');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
    await doc.reference.delete();
    cartcontroller.cartLength.value = 0;
    cartcontroller.cartitemTotalCost.value = 0;
  }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: buycontroller.formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20.0, top: 15.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Fill Order Details",
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff475269)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0, top: 20.0, right: 15.0),
            padding:
                const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            width: 370,
            child: Obx(() => TextFormField(
                  autovalidateMode: buycontroller.disableValidtion.value
                      ? AutovalidateMode.disabled
                      : AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  controller: buycontroller.nameController,
                  style: const TextStyle(fontSize: 18.0),
                  validator: (value) {
                    return buycontroller.validateName(value!);
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Full Name",
                      hintStyle: TextStyle(fontSize: 18.0)),
                )),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0, top: 20.0, right: 15.0),
            padding:
                const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            width: 370,
            child: Obx(() => TextFormField(
                  autovalidateMode: buycontroller.disableValidtion.value
                      ? AutovalidateMode.disabled
                      : AutovalidateMode.onUserInteraction,
                  controller: buycontroller.mobileNoController,
                  style: const TextStyle(fontSize: 18.0),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return buycontroller.validateMobileNo(value!);
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "(+92) Mobile Number",
                      hintStyle: TextStyle(fontSize: 18.0)),
                )),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0, top: 20.0, right: 15.0),
            padding:
                const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            width: 370,
            child: Obx(() => TextFormField(
                  autovalidateMode: buycontroller.disableValidtion.value
                      ? AutovalidateMode.disabled
                      : AutovalidateMode.onUserInteraction,
                  controller: buycontroller.addressController,
                  style: const TextStyle(fontSize: 18.0),
                  validator: (value) {
                    return buycontroller.validateAddress(value!);
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Address",
                      hintStyle: TextStyle(fontSize: 18.0)),
                )),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0, top: 20.0, right: 15.0),
            padding:
                const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            width: 370,
            child: Obx(() => TextFormField(
               autovalidateMode: buycontroller.disableValidtion.value
                  ? AutovalidateMode.disabled
                  : AutovalidateMode.onUserInteraction,
              controller: buycontroller.cityController,
              style: const TextStyle(fontSize: 18.0),
              validator: (value) {
                return buycontroller.validateCity(value!);
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "City",
                  hintStyle: TextStyle(fontSize: 18.0)),
            )),
          ),
          const SizedBox(height: 20.0),
          Obx(()=>InkWell(
             onTap: cartcontroller.cartLength.value != 0 ?  () async {
              buycontroller.orderNowClick();
              if (buycontroller.isformvalidated == true) {
                await addOrdersToFirebase(buycontroller.name.value, buycontroller.address.value, buycontroller.mobileNo.value, buycontroller.city.value);
                Get.defaultDialog(
                  title: "Product",
                  middleText: "Your order has been placed successfully and you will be contacted soon by the admin.",
                  barrierDismissible: false,
                  confirm: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      buycontroller.disableValidtion.value = true;
                      buycontroller.nameController.clear();
                      buycontroller.mobileNoController.clear();
                      buycontroller.addressController.clear();
                      buycontroller.cityController.clear();
                      buycontroller.isformvalidated = false;
                      deleteAllcartItems();
                    },
                    child: const Text("OK")),
                );
              }
            } : null,
            child: Container(
              width: 370,
              margin: const EdgeInsets.only(left: 20.0, right: 15.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: cartcontroller.cartLength.value != 0 ? const Color(0xffff7466) : Colors.grey,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                "Order Now",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color:cartcontroller.cartLength.value != 0 ? Colors.white : Colors.grey[300]),
              ),
            ),
          )),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
