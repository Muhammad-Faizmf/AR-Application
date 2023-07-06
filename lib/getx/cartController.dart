import 'package:get/get.dart';

class CartController extends GetxController {
  final _furniture = {}.obs;
  final cartLength = 0.obs;
  RxInt cartitemTotalCost = 0.obs;
  RxInt quantity = 0.obs;
  var isAlreadyAvailable = false.obs;

  void addPrice(String price, int qty) {
    int productprice = int.parse(price.toString());
    cartitemTotalCost.value += productprice * qty;
  }

  void deductPrice(String price, int qty) {
    int productprice = int.parse(price.toString());
    cartitemTotalCost.value -= (productprice * qty);
  }

  void increaseQuantity(String price, int qty) {
    int productprice = int.parse(price.toString());
    cartitemTotalCost.value += productprice;
    quantity += 1;
  }

  void decreaseQuantity(String price, int qty) {
    if (qty >= 1) {
      int productprice = int.parse(price.toString());
      cartitemTotalCost.value -= productprice;
      qty -= 1;
    } else {
      print("quantity not increased");
    }
  }
}
