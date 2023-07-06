import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  var ispasswordHidden = true.obs;
  var isformValidated = false;

  var email = "".obs;
  var password = "".obs;
  var confPassword = "".obs;

  // ignore: non_constant_identifier_names
  final GlobalKey<FormState> signup_key = GlobalKey<FormState>();

  late TextEditingController emailController,
      passwordController,
      confPasswordController;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confPasswordController = TextEditingController();
    super.onInit();
  }

  validateEmail(String value) {
    if (value.isEmpty) {
      return "Please enter Email";
    } else if (!value.contains("@gmail.com")) {
      return "Please enter a valid Email";
    } else if (value.length < 13) {
      return "Please enter a valid Email";
    }
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

  void checkSignUP() {
    final isValid = signup_key.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      // Get.snackbar('Succuesful', "Account Created Successfully", snackPosition: SnackPosition.BOTTOM,);
      signup_key.currentState!.save();
      email.value = emailController.text;
      password.value = passwordController.text;
      confPassword.value = confPasswordController.text;
      isformValidated = true;
    }
  }
}
