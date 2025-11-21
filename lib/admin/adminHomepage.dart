import 'package:flutter/material.dart';
import 'package:flutter_loginregister/admin/Orders/adminOrders.dart';
import 'package:flutter_loginregister/admin/adminServices.dart';
import 'package:flutter_loginregister/admin/adminUsers.dart';
import 'package:flutter_loginregister/admin/adminServiceProviders.dart';
import 'package:flutter_loginregister/admin/adminVerifySP.dart';

class AdminHomePage extends StatefulWidget {
  static const routeName = '/admin-home';
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    final adminID = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff1c87ab),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          title: Text(
            'Admin Panel',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(top: 25, bottom: 20, left: 20, right: 20),
            color: Color(0xff49c9f6),
            child: Column(
              children: <Widget>[
                Flexible(
                  child: GridView.count(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    crossAxisCount: 2,
                    children: <Widget>[
                      //Verify Service Providers
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                AdminVerifyServiceProvidersPage.routeName,
                                arguments: adminID);
                          },
                          child: Text(
                            'Verify Service Providers',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ),
                      ),

                      //Services
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              AdminServicesPage.routeName,
                            );
                          },
                          child: Text(
                            'Services',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ),
                      ),

                      //Users
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              AdminUsersPage.routeName,
                            );
                          },
                          child: Text(
                            'Users',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ),
                      ),

                      //Service Providers
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              AdminServiceProvidersPage.routeName,
                            );
                          },
                          child: Text(
                            'Service Providers',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ),
                      ),

                      //Orders
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              AdminOrders.routeName,
                            );
                          },
                          child: Text(
                            'Orders',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ),
                      ),

                      // //Chat
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     border: Border.all(width: 2, color: Colors.black),
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //   child: TextButton(
                      //     onPressed: () {},
                      //     child: Text(
                      //       'Chat',
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.w600,
                      //           fontSize: 20,
                      //           color: Colors.black),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Color(0xff1c87ab),
                      borderRadius: BorderRadius.circular(20)),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Exit",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
