
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswdController extends GetxController{


  GlobalKey<FormState> forgotpawd_key = GlobalKey<FormState>();

  late TextEditingController EmailController;
  var isformValidated = false;

  var email = "".obs;

  @override
  void onInit() {
    super.onInit();
    EmailController = TextEditingController();
  }


  String? ValidateEmail(String value){
    if(value.isEmpty){
      return "Please enter email";
    }
    if(!value.contains("@gmail.com"))
    {
      return "Enter valid email";
    }
    return null;
  }

  void checkForgotPassword(){
    final isValid = forgotpawd_key.currentState!.validate();
    if(!isValid)
    {
      return;
    }
    else {
      forgotpawd_key.currentState!.save();
      email.value = EmailController.text;
      isformValidated = true;
    }
  }

}