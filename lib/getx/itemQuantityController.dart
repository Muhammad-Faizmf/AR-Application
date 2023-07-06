import 'package:get/state_manager.dart';

class ItemQuantity extends GetxController {
  RxInt itemquanity = 1.obs;

  void increaseitemQuantity() {
    itemquanity += 1;
  }

  void decreaseitemQuantity() {
    if (itemquanity > 1) {
      itemquanity -= 1;
    }
  }
}
