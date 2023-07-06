// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, nullable_type_in_catch_clause

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_flutter/dashboard/Home.dart';
import 'package:login_flutter/getx/login_controller.dart';
import 'package:login_flutter/pages/forgotPawd_page.dart';
import 'package:login_flutter/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final login_controller = Get.put(LoginController());

  final storage = const FlutterSecureStorage();
  final getxStorage = GetStorage();

  Future<void> userLogin() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: login_controller.email.value,
          password: login_controller.password.value);
      // Storing a user id while logging
      await storage.write(key: "uid", value: credential.user!.uid);
      getxStorage.write("email", credential.user!.email.toString());
      // show dialog after login
      showDialog();
      getLogin();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              backgroundColor: Colors.red,
              content: const Text(
                "No User FOUND.",
                style: TextStyle(fontSize: 18),
              )),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              backgroundColor: Colors.red,
              content: const Text(
                "Wrong Password.",
                style: TextStyle(fontSize: 18),
              )),
        );
      }
    }
  }

  Future googleSignIn() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      FirebaseAuth auth = FirebaseAuth.instance;
      final googlesignIn = GoogleSignIn();
      final signInAccount = await googlesignIn.signIn();
      if (signInAccount != null) {
        final googleAccountAuthentication = await signInAccount.authentication;
        try {
          final credential = GoogleAuthProvider.credential(
              accessToken: googleAccountAuthentication.accessToken,
              idToken: googleAccountAuthentication.idToken);
          UserCredential user = await auth.signInWithCredential(credential);
          showDialog();
          getLogin();
          await storage.write(key: "uid", value: user.user!.uid);
          getxStorage.write("email", user.user!.email.toString());
        } on PlatformException catch (e) {
          if (e.code == "sign-in-canceled") {
            print("sign in canceled");
          }
        }
      } else {
        print("no account selected");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: const Duration(seconds: 3),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: Colors.red,
            content: const Text(
              "Someting is wrong please check internet connection.",
              style: TextStyle(fontSize: 18),
            )),
      );
    }
  }

  // moving to dashboard
  getLogin() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Home()), (route) => false);
    });
  }

  // Checking internet connection before login
  checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      userLogin();
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("login");
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: login_controller.loginkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: const Image(
                    image: AssetImage("images/furniture.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: login_controller.EmailController,
                decoration: InputDecoration(
                  hintText: "E-Mail",
                  label: Text("E-Mail"),
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: (value) {
                  return login_controller.ValidateEmail(value!);
                },
              ),
              const SizedBox(height: 20.0),
              Obx(() => TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: login_controller.ispasswordHidden.value,
                    controller: login_controller.PasswordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      label: Text("Password"),
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        onPressed: () {
                          login_controller.ispasswordHidden.value =
                              !login_controller.ispasswordHidden.value;
                        },
                        icon: Icon(
                          login_controller.ispasswordHidden.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    validator: (value) {
                      return login_controller.ValidatePassword(value!);
                    },
                  )),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPage()),
                        (route) => false);
                  },
                  child: const Text("Forgot Password?"),
                ),
              ),
              const SizedBox(height: 5.0),
              SizedBox(
                height: 50.0,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      login_controller.checkLogin();
                      // check internet, then login
                      if (login_controller.isformValidated == true) {
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
                        "LOGIN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black),
                      ),
                    )),
              ),
              SizedBox(height: 20.0),
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
                    "Dont have an account?",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SignupPage()),
                        //     (route) => false);
                        Get.to(() => SignupPage());
                      },
                      child: const Text("Sign up"))
                ],
              ),
              Divider(
                thickness: 1.0,
              ),
              SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton.icon(
                    onPressed: () async {
                      await googleSignIn();
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                    label: Container(
                      margin: const EdgeInsets.only(left: 8.0),
                      child: const Text(
                        "Continue with Google",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Showing Dialog When login button is Tapped
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
