// ignore_for_file: prefer_if_null_operators, avoid_function_literals_in_foreach_calls, avoid_unnecessary_containers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OrderDetails extends StatefulWidget {
  List<dynamic> storedocList;
  var index;
  dynamic itemsLength;
  OrderDetails(
      {Key? key,
      required this.storedocList,
      required this.index,
      required this.itemsLength})
      : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  static List<String> orderStatusList = ['PENDING', 'ACCEPTED'];

  String? dropDownValue;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      dropDownValue = widget.storedocList[widget.index]['order_status'];
      print("value of: ${widget.storedocList[widget.index]['order_status']}");
    });
    super.initState();
  }

  double containerHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        centerTitle: true,
        title: const Text("Order Details"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            for (var i = 0; i < widget.itemsLength; i++) ...[
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                padding: const EdgeInsets.all(10.0),
                height: 110,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.09),
                          blurRadius: 20.0)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: [
                    const SizedBox(width: 10.0),
                    Container(
                        height: 90.0,
                        width: 90.0,
                        margin: const EdgeInsets.only(right: 15.0),
                        child: CachedNetworkImage(
                          imageUrl: widget.storedocList[widget.index]['items']
                              [i]['image'],
                          placeholder: (context, url) => const Center(
                            child: SpinKitFadingCircle(
                              color: Colors.red,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text(
                              widget.storedocList[widget.index]['items'][i]
                                      ['name']
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff475269)),
                            ),
                          ),
                          Text(
                            widget.storedocList[widget.index]['items'][i]
                                    ['price']
                                .toString(),
                            style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.all(7.0),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Quantity: ${widget.storedocList[widget.index]['items'][i]['quantity']}",
                        style: const TextStyle(fontSize: 15.0),
                      ),
                    )
                  ],
                ),
              )
            ],
            Container(
              height: 60.0,
              padding: const EdgeInsets.all(20.0),
              margin:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.09), blurRadius: 20.0)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Order Status",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff475269))),
                  Container(
                      child: dropDownValue == "ACCEPTED"
                          ? const Text(
                              "ACCEPTED",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            )
                          : const Text("PENDING",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              margin:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              height: widget.storedocList[widget.index]['address'].length < 10
                  ? 350
                  : 400,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.09), blurRadius: 20.0)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: [
                  ReuseableRow("Full Name",
                      widget.storedocList[widget.index]['fullname'], null),
                  const Divider(
                      height: 30.0, thickness: 0.2, color: Color(0xff475269)),
                  ReuseableRow("Email",
                      widget.storedocList[widget.index]['email'], null),
                  const Divider(
                      height: 30.0, thickness: 0.2, color: Color(0xff475269)),
                  ReuseableRow("Address",
                      widget.storedocList[widget.index]['address'], null),
                  const Divider(
                      height: 30.0, thickness: 0.2, color: Color(0xff475269)),
                  ReuseableRow(
                      "City", widget.storedocList[widget.index]['city'], null),
                  const Divider(
                      height: 30.0, thickness: 0.2, color: Color(0xff475269)),
                  ReuseableRow("Mobile Number",
                      widget.storedocList[widget.index]['mobile_number'], null),
                  const Divider(
                      height: 30.0, thickness: 0.2, color: Color(0xff475269)),
                  ReuseableRow("Total",
                      widget.storedocList[widget.index]['total'], Colors.red),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget ReuseableRow(String name, dynamic storedocvalue, Color? color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff475269)),
        ),
        Container(
          alignment: Alignment.centerRight,
          width: 190.0,
          child: Text(
            "$storedocvalue",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: color ?? const Color(0xff475269),
            ),
          ),
        ),
      ],
    );
  }
}
