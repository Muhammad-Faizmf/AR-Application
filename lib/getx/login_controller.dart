import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var ispasswordHidden = true.obs;
  var isformValidated = false;
  var isLoginClicked = false;
  var currentuserEmail = "".obs;

  GlobalKey<FormState> loginkey = GlobalKey<FormState>();

  late TextEditingController EmailController, PasswordController;

  var email = "".obs;
  var password = "".obs;

  @override
  void onInit() {
    super.onInit();
    EmailController = TextEditingController();
    PasswordController = TextEditingController();
  }

  String? ValidateEmail(String value) {
    if (value.isEmpty) {
      return "Please enter email";
    } else if (!value.contains("@gmail.com")) {
      return "Enter valid email";
    }
    return null;
  }

  String? ValidatePassword(String value) {
    if (value.isEmpty) {
      return "Please enter Password";
    } else if (value.length < 8) {
      return "Password length must be 8 ";
    }
    return null;
  }

  void checkLogin() {
    final isValid = loginkey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      // Get.snackbar('Succuesful', "Login Successful", snackPosition: SnackPosition.BOTTOM,);
      loginkey.currentState!.save();
      email.value = EmailController.text;
      password.value = PasswordController.text;
      isformValidated = true;
      isLoginClicked = true;
    }
  }
}
