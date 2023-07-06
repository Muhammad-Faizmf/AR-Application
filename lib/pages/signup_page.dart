// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:login_flutter/getx/googlePasswordController.dart';
import 'package:login_flutter/getx/signup_controller.dart';
import 'package:login_flutter/pages/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final signup_controller = Get.put(SignUpController());
  final controller = Get.put(GoogleSigninPassword());

  Future createUserAccount() async {
    try {
      UserCredential usercredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: signup_controller.email.value,
              password: signup_controller.password.value);

      showDialog();
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              backgroundColor: Colors.orange,
              content: const Text(
                "Account created successfully. Please Login.",
                style: TextStyle(fontSize: 18),
              )),
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        signup_controller.passwordController.clear();
        signup_controller.confPasswordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.red,
          content: const Text(
            "Email already exists. Try another one.",
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
      createUserAccount();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.red,
        content: const Text(
          "Please check your internet connection.",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Colors.grey[700],
      //   title: const Text("Create an Account"),
      //   leading: IconButton(
      //     onPressed: (){
      //       Navigator.pushAndRemoveUntil(
      //         context, MaterialPageRoute(
      //           builder: (context) => const LoginPage()),
      //         (route) => false
      //       );
      //     },
      //     icon: const Icon(Icons.arrow_back),
      //   ),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Form(
            key: signup_controller.signup_key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: const Image(
                    image: AssetImage("images/welcome_image.jpg"),
                    // fit: BoxFit.cover,
                  ),
                ),
                const Text("Welcome Back",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                const Text(
                  "Create your account to start your journey.",
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: signup_controller.emailController,
                  validator: (value) {
                    return signup_controller.validateEmail(value!);
                  },
                  decoration: InputDecoration(
                      hintText: "E-Mail",
                      label: const Text("E-Mail"),
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                const SizedBox(height: 20.0),
                Obx(() => TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: signup_controller.ispasswordHidden.value,
                      controller: signup_controller.passwordController,
                      validator: (value) {
                        return signup_controller.validatePassword(value!);
                      },
                      decoration: InputDecoration(
                        hintText: "Password",
                        label: const Text("Password"),
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          onPressed: () {
                            signup_controller.ispasswordHidden.value =
                                !signup_controller.ispasswordHidden.value;
                          },
                          icon: Icon(
                            signup_controller.ispasswordHidden.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    )),
                const SizedBox(height: 20.0),
                Obx(() => TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: signup_controller.ispasswordHidden.value,
                      controller: signup_controller.confPasswordController,
                      validator: (value) {
                        return signup_controller.validateConfPassword(value!);
                      },
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        label: const Text("Confirm Password"),
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    )),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                      onPressed: () {
                        signup_controller.checkSignUP();
                        if (signup_controller.isformValidated == true) {
                          checkInternetConnection();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        side: const BorderSide(color: Colors.white),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 8.0),
                        child: const Text(
                          "SIGN UP",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black),
                        ),
                      )),
                ),
                const SizedBox(height: 20.0),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "OR",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                              (route) => false);
                        },
                        child: const Text("Login"))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
