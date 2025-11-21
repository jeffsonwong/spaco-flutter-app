import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RejectedOrdersPage extends StatefulWidget {
  final Function toggleView;
  RejectedOrdersPage({this.toggleView});
  @override
  _RejectedOrdersPageState createState() => _RejectedOrdersPageState();
}

class _RejectedOrdersPageState extends State<RejectedOrdersPage> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
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
            'My Orders',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Orders")
              .where("userID", isEqualTo: firebaseUser.uid)
              .where("jobStatus", isEqualTo: "Rejected")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  "Loading",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              widget.toggleView(1);
                            });
                          },
                          child: Text(
                            "Accepted",
                            style: TextStyle(
                                decorationThickness: 2.5,
                                decorationColor: Colors.black,
                                shadows: [
                                  Shadow(
                                      color: Colors.black,
                                      offset: Offset(0, -5))
                                ],
                                color: Colors.transparent,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              widget.toggleView(2);
                            });
                          },
                          child: Text(
                            "Pending",
                            style: TextStyle(
                                decorationThickness: 2.5,
                                decorationColor: Colors.black,
                                shadows: [
                                  Shadow(
                                      color: Colors.black,
                                      offset: Offset(0, -5))
                                ],
                                color: Colors.transparent,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              widget.toggleView(3);
                            });
                          },
                          child: Text(
                            "Rejected",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationThickness: 2.5,
                                decorationColor: Colors.black,
                                shadows: [
                                  Shadow(
                                      color: Colors.black,
                                      offset: Offset(0, -5))
                                ],
                                color: Colors.transparent,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              widget.toggleView(4);
                            });
                          },
                          child: Text(
                            "Completed",
                            style: TextStyle(
                                decorationThickness: 2.5,
                                decorationColor: Colors.black,
                                shadows: [
                                  Shadow(
                                      color: Colors.black,
                                      offset: Offset(0, -5))
                                ],
                                color: Colors.transparent,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Container(
                          child: ListView(
                              children: snapshot.data.docs.map((document) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 5, bottom: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: ListTile(
                              tileColor: Colors.white,
                              contentPadding: EdgeInsets.all(10),
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
                                      Flexible(
                                          fit: FlexFit.tight,
                                          child: SizedBox()),
                                      Text(
                                        document['jobID'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  //Job Date
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text: "Job Date : ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: document["jobDate"],
                                          style: TextStyle(fontSize: 18))
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  //Job Time
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text: "Job Time (24:00) : ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: document["jobTime"],
                                          style: TextStyle(fontSize: 18))
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  //Job Quantity
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text: "Job Quantity : ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: document["jobQuantity"]
                                              .toString(),
                                          style: TextStyle(fontSize: 18))
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  //Service Provider Name
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text: "Service Provider Name : ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: document["serviceproviderName"],
                                          style: TextStyle(fontSize: 18))
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  //Service Provider Address
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text: "Service Provider Address : ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: document[
                                              "serviceproviderAddress"],
                                          style: TextStyle(fontSize: 18))
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  //Service Provider Contact
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text: "Service Provider Contact : ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: document[
                                              "serviceproviderPhoneNum"],
                                          style: TextStyle(fontSize: 18))
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  //Job Status
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text: "Job Status : ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: document["jobStatus"],
                                          style: TextStyle(fontSize: 18))
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList())),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
