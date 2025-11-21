import 'package:flutter/material.dart';
import 'package:flutter_loginregister/admin/Orders/adminAcceptedOrders.dart';
import 'package:flutter_loginregister/admin/Orders/adminCompletedOrders.dart';
import 'package:flutter_loginregister/admin/Orders/adminPendingOrders.dart';
import 'package:flutter_loginregister/admin/Orders/adminRejectedOrders.dart';

class AdminOrders extends StatefulWidget {
  static const routeName = '/admin-orders';
  @override
  _AdminOrdersState createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
  int jobstate = 2;

  void toggleView(int choice) {
    setState(() => jobstate = choice);
  }

  @override
  Widget build(BuildContext context) {
    if (jobstate == 1) {
      return AdminAcceptedOrdersPage(toggleView: toggleView);
    } else if (jobstate == 2) {
      return AdminPendingOrdersPage(toggleView: toggleView);
    } else if (jobstate == 3) {
      return AdminRejectedOrdersPage(toggleView: toggleView);
    } else {
      return AdminCompletedOrdersPage(toggleView: toggleView);
    }
  }
}
