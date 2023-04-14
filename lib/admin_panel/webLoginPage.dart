import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter/admin_panel/adminController.dart';
import 'package:login_flutter/admin_panel/firebase_services.dart';
import 'package:login_flutter/admin_panel/webmainPage.dart';
import 'package:sizer/sizer.dart';

class WebLoginPage extends StatefulWidget {
  const WebLoginPage({Key? key}) : super(key: key);

  @override
  State<WebLoginPage> createState() => _WebLoginPageState();
}

class _WebLoginPageState extends State<WebLoginPage> {
  TextStyle text_style =
    const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold);

  final controller = Get.put(AdminController());

  adminLogin(BuildContext context) async {
    await FirebaseServices()
        .adminSignIn(controller.EmailController.text)
        .then((value) async {
      if (value['username'] == controller.EmailController.text &&
          value['password'] == controller.PasswordController.text) {
        try {
          UserCredential user = await FirebaseAuth.instance.signInAnonymously();
          Get.to(WebMainPage());
          controller.isLoading.value = false;
        } catch (e) {
          controller.isLoading.value = false;
          print("Error");
        }
      } else {
        controller.isLoading.value = false;
        showDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3.0),
              borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
            child: Form(
              key: controller.adminLoginkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "WELCOME ADMIN ",
                    style: text_style,
                  ),
                  Text(
                    "Login to your Account ",
                    style: text_style,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller.EmailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: const Icon(
                          Icons.person_outline_rounded,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        return controller.ValidateEmail(value!);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller.PasswordController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        return controller.ValidatePassword(value!);
                      },
                    ),
                  ),
                  Obx(() => GestureDetector(
                    onTap: () async {
                      controller.checkAdminLogin();
                      if (controller.isformValidated == true) {
                        controller.isLoading.value = true;
                        adminLogin(context);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border:Border.all(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(12.0)),
                        child: Center(
                          child: controller.isLoading.value
                            ? const CircularProgressIndicator()
                            : const Text(
                                "LOGIN",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                                  )
                          )
                      )
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  showDialog() {
    Get.defaultDialog(
      title: "",
      content: const Text("No User Found"),
      onConfirm: () => {Navigator.pop(context)},
    );
  }
}
