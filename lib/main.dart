// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_flutter/getx/homepageController.dart';
import 'package:login_flutter/pages/splash_screen.dart';
import 'package:sizer/sizer.dart';

import 'dashboard/Home.dart';


void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final storage = const FlutterSecureStorage();
  final controller = Get.put(FetchProducts());

  Future<bool> CheckLoginStatus() async {
    String? value = await storage.read(key: "uid");
    if (value == null) {
      return false;
    } else {
      return true;
    }
  }

  // final controller = Get.put(FetchProducts());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Something Went Wrong");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Sizer(
            builder: (context, orientation, deviceType) => GetMaterialApp(
                  title: 'Augmented Reality',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  defaultTransition: Transition.leftToRightWithFade,
                  transitionDuration: const Duration(milliseconds: 200),
                  debugShowCheckedModeBanner: false,
                  home: FutureBuilder(
                      future: CheckLoginStatus(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.data == false) {
                          return const SplashScreen(); // splashscreen()
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                              color: Colors.white,
                              // ignore: prefer_const_constructors
                              child: Center(
                                child: const SpinKitFadingCircle(
                                  color: Colors.red,
                                ),
                              ));
                        }
                        return const Home(); // Home()
                      }),
                ));
      },
    );
  }

  showDialog() {
    Get.defaultDialog(
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
