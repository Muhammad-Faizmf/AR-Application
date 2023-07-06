// ignore_for_file: prefer_const_constructors

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:login_flutter/getx/forgotPwdController.dart';
import 'package:login_flutter/pages/login_page.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPage> {
  final forgotController = Get.put(ForgotPasswdController());

  ResetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: forgotController.email.value);
      Future.delayed(Duration(seconds: 3), () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.orange,
          content: Text(
            "Reset Password Link is send to your Email ID. Please check it out.",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ));
      });
      showDialog();
      forgotController.email.value = "";
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pop();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        forgotController.email.value = "";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          content: Text(
            "No user found.",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ));
      }
    }
  }

  checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      ResetPassword();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.red,
        content: const Text(
          "No internet connection.",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.grey[700],
            title: Text("Reset Password"),
            leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
            child: Form(
              key: forgotController.forgotpawd_key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 150.0,
                      child: Image.asset(
                        "images/forgot_pwd_image.png",
                      )),
                  SizedBox(height: 30.0),
                  Text(
                    "Reset Link will be send to your Email ID: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: forgotController.EmailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    validator: (value) {
                      return forgotController.ValidateEmail(value!);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                      onTap: () {
                        forgotController.checkForgotPassword();
                        // check internet, then login
                        if (forgotController.isformValidated == true) {
                          checkInternetConnection();
                          forgotController.EmailController.clear();
                        }
                      },
                      child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Center(
                              child: Text(
                            "RESET",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          )))),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ));
  }

  showDialog() {
    Get.defaultDialog(
        barrierDismissible: false,
        title: "",
        content: Column(children: const [
          SpinKitFadingCircle(
            color: Colors.red,
          ),
          SizedBox(height: 20.0),
          Text("Please Wait...")
        ]));
  }
}
