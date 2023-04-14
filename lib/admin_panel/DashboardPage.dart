

import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({ Key? key }) : super(key: key);

  static const String id = "dashboardPage";

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Dashboard")
    );
  }
}