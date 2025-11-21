import 'package:flutter/material.dart';
import 'package:flutter_loginregister/serviceProvider/editServices.dart';
import 'package:flutter_loginregister/serviceProvider/spLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyServices extends StatelessWidget {
  static const routeName = '/ServiceProvider-services';
  String spID = SPDetails.spID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff49c9f6),
        appBar: AppBar(
          backgroundColor: Color(0xff1c87ab),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          title: Text(
            'My Services',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Services")
              .where('serviceproviderID', isEqualTo: spID)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            } else {
              return Container(
                  child: ListView(
                      children: snapshot.data.docs.map((document) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            EditServicesPage.routeName,
                            arguments: document['serviceID']);
                      },
                      child: ListTile(
                        tileColor: Colors.white,
                        contentPadding: EdgeInsets.only(
                            left: 15, right: 15, top: 8, bottom: 2),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  document['serviceName'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Text(
                                  document['serviceID'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Price : RM " +
                                    document['servicePrice'].toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Service Type : " +
                                  document['serviceType'] +
                                  " Service",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              document['serviceDescription'],
                              style: TextStyle(fontSize: 18),
                            ),
                            Center(
                              child: Container(
                                width: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child:
                                      Image.network(document['serviceImgURL']),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                "Tap on the service to edit it",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
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
