
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter/admin_panel/DashboardPage.dart';


class AdminController extends GetxController{

  var email = "".obs;
  var password = "".obs;
  var isformValidated = false;
  var isLoading = false.obs;

  GlobalKey<FormState> adminLoginkey = GlobalKey<FormState>();

  late TextEditingController EmailController, PasswordController;

   @override
  void onInit() {
    super.onInit();
    EmailController = TextEditingController();
    PasswordController = TextEditingController();
  }

   String? ValidateEmail(String value){
     if(value.isEmpty){
      return "Please enter email";
    }
    else{
      return null;
    }
    
  }

  String? ValidatePassword(String value){
    if(value.isEmpty){
      return "Please enter Password";
    }
    return null;
  }
 void checkAdminLogin(){
    final isValid = adminLoginkey.currentState!.validate();
    if(!isValid)
    {
      return;
    }
    else {
      adminLoginkey.currentState!.save();
      email.value = EmailController.text;
      password.value = PasswordController.text;
      isformValidated = true;
      // Get.snackbar('Successful', "Login Sucessfully", snackPosition: SnackPosition.BOTTOM);
    }
  }

}