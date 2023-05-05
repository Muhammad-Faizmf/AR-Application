import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_flutter/cartPages/Orders.dart';
import 'package:login_flutter/getx/cartController.dart';
import 'package:login_flutter/getx/login_controller.dart';
import 'package:login_flutter/pages/login_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final login_controller = Get.put(LoginController());

  final storage = const FlutterSecureStorage();
  final getxStorage = GetStorage();
  final cartcontroller = Get.put(CartController());
  final googlesignIn = GoogleSignIn();

  // user logout
  logout() async {
    await FirebaseAuth.instance.signOut();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.grey[700]!.withOpacity(0.09),
                    child: SvgPicture.asset(
                      'images/person_profile.svg',
                      width: 50.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                   getxStorage.read("email"),
                  style: const TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.shopping_bag,
              size: 28.0,
            ),
            title: const Text(
              "Orders",
              style: TextStyle(fontSize: 20.0),
            ),
            onTap: () {
              Navigator.pop(context);
              Get.to(()=>const Orders());
            },
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  tileColor: Colors.orange,
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onTap: () async {
                    cartcontroller.cartitemTotalCost.value = 0;
                    cartcontroller.quantity.value = 0;
                    logout();
                    showDialog();
                    await storage.delete(key: "uid");
                    await googlesignIn.signOut();
                    login_controller.isformValidated = false;
                    print("Logout");

                  },
                ),
              ),
            ),
          )
        ],
      ),
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
          Text("Logging out...")
        ]));
  }
}
