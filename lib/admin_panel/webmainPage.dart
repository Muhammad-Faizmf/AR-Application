// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:login_flutter/admin_panel/AddProductPage.dart';
import 'package:login_flutter/admin_panel/DashboardPage.dart';
import 'package:login_flutter/admin_panel/DeleteProductPage.dart';
import 'package:login_flutter/admin_panel/UpdateProduct.dart';

class WebMainPage extends StatefulWidget {
  const WebMainPage({ Key? key }) : super(key: key);

  static const String id = "webmain";

  @override
  State<WebMainPage> createState() => _WebMainPageState();
}

class _WebMainPageState extends State<WebMainPage> {

  Widget selectedpage  = DashboardPage();

  choosePage(item){
    switch(item){
      case DashboardPage.id:
        setState(() {
          selectedpage = const DashboardPage();
        });
        break;
      case AddProductPage.id:
        setState(() {
          selectedpage = AddProductPage();
        });
        break;
      case UpdateProductPage.id:
        setState(() {
          selectedpage = const UpdateProductPage();
        });
        break;
      case DeleteProductPage.id:
        setState(() {
          selectedpage = const DeleteProductPage();
        });
        break;
    default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return  AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Admin"),
      ),
      sideBar: SideBar(
        onSelected: (item) {
          choosePage(item.route);
        },
        items: const [
        AdminMenuItem(
          title: "DASHBOARD",
          icon: Icons.dashboard,
          route: DashboardPage.id
          ),
        AdminMenuItem(
          title: "ADD PRODUCT ",
          icon: Icons.add,
          route: AddProductPage.id
          ),
        AdminMenuItem(
          title: "UPDATE PRODUCT",
          icon: Icons.update,
          route: UpdateProductPage.id,
          ),
        AdminMenuItem(
          title: "DELETE PRODUCT",
          icon: Icons.delete,
          route: DeleteProductPage.id
          ),
        AdminMenuItem(
          title: "CART ITEMS",
          icon: Icons.shopping_cart,
          ),
      ], 
      selectedRoute: WebMainPage.id),
      body: selectedpage
    );
  }
}

