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
import 'package:login_flutter/widgets/showdialog.dart';

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
                    overflow: TextOverflow.ellipsis,
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
              Get.to(() => const Orders());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.contact_mail,
              size: 28.0,
            ),
            title: const Text(
              "Contact",
              style: TextStyle(fontSize: 20.0),
            ),
            onTap: () {
              Constant().showAlertDialog(
                  "You can Contact us regarding any issue by faizanmushtaq@gmail.com.",
                  "Contact",
                  context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.contacts,
              size: 28.0,
            ),
            title: const Text(
              "About Us",
              style: TextStyle(fontSize: 20.0),
            ),
            onTap: () {
              Constant().showAlertDialog(
                  "Welcome to our AR Furniture app! We are Hamza and Faizan, the creators behind this innovative platform with our combined passion for technology and design, embarked on this journey to simplify and enhance the furniture shopping experience. We believe that every individual should have the opportunity to create their dream space effortlessly.",
                  "About Us",
                  context);
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
        barrierDismissible: false,
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
