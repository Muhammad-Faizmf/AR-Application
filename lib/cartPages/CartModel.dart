
import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel{
  String name;
  String image;
  String price;
  var quantity;

  CartModel({ required this.name, required this.image, required this.price, required this.quantity});

  static Future<void> addtoCart(CartModel cart)async{
    CollectionReference db = FirebaseFirestore.instance.collection('cart');
    Map<String, dynamic> data = {
      "name" : cart.name,
      "image" : cart.image,
      "price" : cart.price,
      "quantity" : cart.quantity,
    };
    await db.add(data);
  }
}