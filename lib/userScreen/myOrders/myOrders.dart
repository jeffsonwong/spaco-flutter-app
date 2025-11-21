import 'package:flutter/material.dart';
import 'package:flutter_loginregister/userScreen/myOrders/acceptedOrders.dart';
import 'package:flutter_loginregister/userScreen/myOrders/pendingOrders.dart';
import 'package:flutter_loginregister/userScreen/myOrders/rejectedOrders.dart';
import 'package:flutter_loginregister/userScreen/myOrders/completedOrders.dart';

class MyOrders extends StatefulWidget {
  static const routeName = '/orders';
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  int jobstate = 2;

  void toggleView(int choice) {
    setState(() => jobstate = choice);
  }

  @override
  Widget build(BuildContext context) {
    if (jobstate == 1) {
      return AcceptedOrdersPage(toggleView: toggleView);
    } else if (jobstate == 2) {
      return PendingOrdersPage(toggleView: toggleView);
    } else if (jobstate == 3) {
      return RejectedOrdersPage(toggleView: toggleView);
    } else {
      return CompletedOrdersPage(toggleView: toggleView);
    }
  }
}
