
// ignore_for_file: prefer_const_constructors

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:login_flutter/getx/forgotPwdController.dart';
import 'package:login_flutter/pages/login_page.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({ Key? key }) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPage> {

  final forgotController = Get.put(ForgotPasswdController());

  ResetPassword() async {
   try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: forgotController.email.value);
    Future.delayed(Duration(seconds: 3),(){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.orange,
          content: Text(
            "Reset Password Link is send to your Email ID. Please check it out.",
              style: TextStyle(
              fontSize: 18,
            ),
        ),
      )
    );
    });
    showDialog();
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(
        builder: (context) => LoginPage()),
       (route) => false
    );
    });
   } on FirebaseAuthException catch (e) {
     if(e.code == "user-not-found"){
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.red,
          content: Text(
            "No user found.",
              style: TextStyle(
              fontSize: 18,
            ),
          ),
        )
      );
     }
   }
  }

  checkInternetConnection() async {

    var connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult == ConnectivityResult.wifi ||
    connectivityResult == ConnectivityResult.mobile) {
      ResetPassword();
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.red,
          content: const Text(
            "No internet connection.",
              style: TextStyle(
              fontSize: 18,
            ),
          ),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[700],
        title: Text("Reset Password"),
        leading: IconButton(
          onPressed: (){
             Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(
                builder: (context) => LoginPage()),
              (route) => false
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: forgotController.forgotpawd_key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Reset Link will be send to your Email ID: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
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
                  validator: (value){
                    return forgotController.ValidateEmail(value!);
                  },
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: (){
                    forgotController.checkForgotPassword();
                    // check internet, then login
                    if(forgotController.isformValidated == true){
                      checkInternetConnection();
                      forgotController.EmailController.clear();
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Center(child: 
                    Text(
                      "RESET",
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0
                        ),
                      )
                    )
                  )
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
    showDialog(){
    Get.defaultDialog(
      title: "",
      content: Column(
        children: const [
          SpinKitFadingCircle(
            color: Colors.red,
          ),
          SizedBox(height: 20.0),
          Text("Please Wait...")
        ]
      )
    );
  }
}