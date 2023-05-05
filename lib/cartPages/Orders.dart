
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter/cartPages/OderDetails.dart';

class Orders extends StatefulWidget {
  const Orders({ Key? key }) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        centerTitle: true,
        title: const Text("Orders"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orders').where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
          if(snapshot.data!.docs.isEmpty){
            return Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: const Text(
                "No orders yet",
                style: TextStyle(fontSize: 20.0),
                )
            );
          }
          final List storedoc = [];
          snapshot.data!.docs.map((DocumentSnapshot document){
            Map a = document.data() as Map<String, dynamic>;
            storedoc.add(a);
            a['id'] = document.id;
          }).toList();
          return Column(
            children: [
              for (var x = 0; x < storedoc.length; x++)...
              [
                // Text("items length: ${storedoc[x]['items'].length}"),
                InkWell(
                  onTap: (){
                    Get.to(()=>OrderDetails(storedocList: storedoc, index: x,
                    itemsLength: storedoc[x]['items'].length
                    ));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
                    height: 60.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.09),
                    blurRadius: 20.0
                  )
                ],
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
                  child: ListTile(
                    title: Text(storedoc[x]['id']),
                    trailing: Text(
                      storedoc[x]['order_status'],
                      style: storedoc[x]['order_status'] == "PENDING" ? const TextStyle(color: Colors.red) : const TextStyle(color: Colors.green),
                      ),
                  )),
                ),
            ],
         ],
    );
    },
    ),
      )
    );
  }
  
}