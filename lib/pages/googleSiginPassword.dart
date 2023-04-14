import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_flutter/getx/googlePasswordController.dart';

class GoogleSignPassword extends StatefulWidget {
  const GoogleSignPassword({ Key? key }) : super(key: key);

  @override
  _GoogleSignPasswordState createState() => _GoogleSignPasswordState();
}

class _GoogleSignPasswordState extends State<GoogleSignPassword> {

  final controller = Get.put(GoogleSigninPassword());
  final googlesignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.googleSignInPassword_key,
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller.passwordController,
                decoration: const InputDecoration(
                  hintText: "Enter password"
                ),
                validator: (value){
                  return controller.validatePassword(value!);
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: controller.confPasswordController,
                decoration: const InputDecoration(
                  hintText: "Enter Confirm password"
                ),
                validator: (value){
                  return controller.validateConfPassword(value!);
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: (){
                  controller.checkSignInPassword();
                  if(controller.isformValidated){
                    print("form validated");
                  }
                },
                child: const SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: Center(
                    child: Text('Next', style: TextStyle(fontSize: 16.0),)
                  ),
                )
              ),

              ElevatedButton(
                onPressed: () async {
                  await googlesignIn.signOut();
                },
                child: const SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: Center(
                    child: Text('Sign Out', style: TextStyle(fontSize: 16.0),)
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}