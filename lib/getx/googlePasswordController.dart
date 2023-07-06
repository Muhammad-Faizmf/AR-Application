import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoogleSigninPassword extends GetxController {
  var ispasswordHidden = true.obs;
  var isformValidated = false;

  var password = "".obs;
  var confPassword = "".obs;

  final GlobalKey<FormState> googleSignInPassword_key = GlobalKey<FormState>();

  late TextEditingController emailController,
      passwordController,
      confPasswordController;

  @override
  void onInit() {
    passwordController = TextEditingController();
    confPasswordController = TextEditingController();
    super.onInit();
  }

  validatePassword(String value) {
    if (value.isEmpty) {
      return "Please enter Password";
    } else if (value.length < 8) {
      return "Password length should be 8.";
    }
  }

  validateConfPassword(String value) {
    if (value.isEmpty) {
      return "Please enter Confirm Password";
    } else if (value.length < 8) {
      return "Password length should be 8.";
    } else if (passwordController.text != confPasswordController.text) {
      return "passwords do not match";
    }
  }

  void checkSignInPassword() {
    final isValid = googleSignInPassword_key.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      // Get.snackbar('Succuesful', "Account Created Successfully", snackPosition: SnackPosition.BOTTOM,);
      googleSignInPassword_key.currentState!.save();
      password.value = passwordController.text;
      confPassword.value = confPasswordController.text;
      isformValidated = true;
    }
  }
}
