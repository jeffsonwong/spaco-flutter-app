import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_loginregister/serviceProvider/addServices.dart';
import 'package:flutter_loginregister/serviceProvider/myJobs/myJobs.dart';
import 'package:flutter_loginregister/serviceProvider/myJobs/pendingJobs.dart';
import 'package:flutter_loginregister/serviceProvider/myServices.dart';
import 'package:flutter_loginregister/serviceProvider/spLogin.dart';
import 'package:flutter_loginregister/serviceProvider/removeServices.dart';

class ServiceProviderHomePage extends StatefulWidget {
  static const routeName = '/ServiceProvider-home';
  @override
  _ServiceProviderHomePageState createState() =>
      _ServiceProviderHomePageState();
}

class _ServiceProviderHomePageState extends State<ServiceProviderHomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String spID = SPDetails.spID;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("ServiceProviders")
        .doc(spID)
        .get()
        .then((snapshot) {
      final snackBar = SnackBar(
        content: Text(
          "Welcome, " + snapshot.data()["serviceproviderEmail"] + "!",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xff1c87ab),
        duration: const Duration(seconds: 2),
      );
      Future(() => scaffoldKey.currentState.showSnackBar(snackBar));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff1c87ab),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          title: Text(
            'Service Provider Home',
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
                      //My Services
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FlatButton(
                          height: 20,
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(MyServices.routeName);
                            // Navigator.of(context).pop();
                          },
                          child: Text(
                            'My Services',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),

                      //My Jobs
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FlatButton(
                          height: 20,
                          onPressed: () {
                            Navigator.of(context).pushNamed(MyJobs.routeName);
                          },
                          child: Text(
                            'My Jobs',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),

                      //Add Services
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FlatButton(
                          height: 20,
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AddServicesPage.routeName);
                          },
                          child: Text(
                            'Add\nService',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),

                      //Remove Service
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FlatButton(
                          height: 20,
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RemoveServicesPage.routeName);
                          },
                          child: Text(
                            'Remove Service',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),

                      //Sign Out
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: MaterialButton(
                          height: 20,
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/ServiceProvider-profile');
                          },
                          child: Text(
                            'My Profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
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
                      //   child: FlatButton(
                      //     height: 20,
                      //     onPressed: () {},
                      //     child: Text(
                      //       'Chat',
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 20,
                      //       ),
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
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Sign Out",
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
