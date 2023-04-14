


// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks



import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:login_flutter/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  final storage = const FlutterSecureStorage();

  Future<bool> CheckLoginStatus() async {
    String? value = await storage.read(key: "uid");
    if(value == null){
      return false;
    }
    else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
      Timer(const Duration(seconds: 5),
        ()=> Navigator.push(context, MaterialPageRoute(
          builder: (context) => LoginPage())
        )
     );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Image(image: AssetImage("images/furniture.png"),
              fit: BoxFit.cover, height: 200,
              ),
            ),

            Text("AR Furniture App",
              style: TextStyle(fontWeight:FontWeight.bold, color: Colors.red, fontSize: 25)
            ),
            SizedBox(height: 20),
            SpinKitSpinningCircle(
              color: Colors.yellow, 
            ),
            
          ],
        ),
      ),
    );
  }
}