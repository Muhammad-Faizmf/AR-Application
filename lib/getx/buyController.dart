import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyController extends GetxController {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final selectedCity = ''.obs;

  final List<String> cities = [
    "peshawar",
    "mardan",
    "karachi",
    "lahore",
    "islamabad",
  ];

  late TextEditingController nameController,
      mobileNoController,
      addressController;

  var name = "".obs;
  var mobileNo = "".obs;
  var address = "".obs;
  var isformvalidated = false;
  var disableValidtion = false.obs;

  @override
  void onInit() {
    nameController = TextEditingController();
    mobileNoController = TextEditingController();
    addressController = TextEditingController();
    super.onInit();
  }

  validateName(String value) {
    if (value.isEmpty) {
      return "Please enter Full Name";
    } else if (value.isNum) {
      return "please enter only Full name";
    }
  }

  validateMobileNo(String value) {
    if (value.isEmpty) {
      return "Please enter Mobile Number";
    } else if (value.length != 11) {
      return "Please enter number with 11 digits";
    } else if (!value.isNumericOnly) {
      return "Please enter only Numbers";
    } else if (!value.startsWith("03")) {
      return "Please enter Number as (03...)";
    }
  }

  validateAddress(String value) {
    if (value.isEmpty) {
      return "Please enter Address";
    } else if (value.isNum) {
      return "Please enter valid Address";
    }
  }

  validateCity(String value) {
    if (value.isEmpty) {
      return "Please enter City";
    } else if (value.isNum) {
      return "Please enter a valid City";
    }
  }

  orderNowClick() {
    final isValid = formkey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      // Get.snackbar('Product', "Purchased Successfully", snackPosition: SnackPosition.TOP,);
      formkey.currentState!.save();
      name.value = nameController.text;
      mobileNo.value = mobileNoController.text;
      address.value = addressController.text;
      isformvalidated = true;
    }
  }
}
