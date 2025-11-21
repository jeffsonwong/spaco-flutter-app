import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_loginregister/userScreen/servicedetails.dart';
import 'package:flutter_loginregister/userScreen/cartPage.dart';

// ignore: must_be_immutable
class ServiceListPage extends StatelessWidget {
  static const routeName = '/service-list';

  @override
  Widget build(BuildContext context) {
    final serviceType = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff49c9f6),
        appBar: AppBar(
          backgroundColor: Color(0xff1c87ab),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          title: Text(
            serviceType + " Services",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () =>
                    Navigator.of(context).pushNamed(CartPage.routeName))
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Services")
              .where('serviceType', isEqualTo: serviceType)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            } else {
              return Container(
                  child: ListView(
                      children: snapshot.data.docs.map((document) {
                return Padding(
                  padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ServiceDetailsPage.routeName,
                            arguments: document['serviceID']);
                      },
                      child: ListTile(
                        tileColor: Colors.white,
                        contentPadding: EdgeInsets.only(
                            left: 20, right: 20, top: 8, bottom: 8),
                        title: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  document['serviceName'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  " - " + document['serviceproviderName'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Flexible(fit: FlexFit.tight, child: SizedBox()),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "RM " +
                                      document['servicePrice']
                                          .toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList()));
            }
          },
        ));
  }
}
