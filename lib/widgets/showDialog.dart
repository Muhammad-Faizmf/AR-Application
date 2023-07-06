import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constant {
  showAlertDialog(String msg, String title, BuildContext context) {
    return Get.defaultDialog(
        barrierDismissible: false,
        title: title,
        contentPadding: const EdgeInsets.all(10.0),
        content: Text(
          msg.toString(),
          textAlign: TextAlign.justify,
        ),
        onConfirm: () {
          Navigator.of(context).pop();
        },
        confirmTextColor: Colors.white);
  }
}
