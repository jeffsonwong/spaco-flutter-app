import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminRejectedOrdersPage extends StatefulWidget {
  final Function toggleView;
  AdminRejectedOrdersPage({this.toggleView});
  @override
  _AdminRejectedOrdersPageState createState() =>
      _AdminRejectedOrdersPageState();
}

class _AdminRejectedOrdersPageState extends State<AdminRejectedOrdersPage> {
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
            'Orders',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Orders")
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

                                  Text(
                                    "Customer : ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),

                                  //Customer Name
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text: "Name : ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: document["userName"],
                                          style: TextStyle(fontSize: 18))
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),

                                  //Customer Address
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text: "Address : ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: document["userAddress"],
                                          style: TextStyle(fontSize: 18))
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),

                                  //Customer Contact
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text: "Contact : ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: document["userPhoneNum"],
                                          style: TextStyle(fontSize: 18))
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),

                                  Text(
                                    "Service Provider : ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),

                                  //Service Provider Name
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text: "Name : ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: document["serviceproviderName"],
                                          style: TextStyle(fontSize: 18))
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),

                                  //Service Provider Address
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text: "Address : ",
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
                                    height: 5,
                                  ),

                                  //Service Provider Contact
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text: "Contact : ",
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

                                  //Remove button
                                  GestureDetector(
                                    onTap: () {
                                      removeOrder(document["jobID"]);
                                    },
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Color(0xff1c87ab),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Remove",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
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

  Future<void> removeOrder(String jobID) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Remove Confirmation',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Press Yes to confirm,\nPress No to return.',
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          'Yes',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("Orders")
                              .doc(jobID)
                              .delete();
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Removed!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            backgroundColor: Colors.black,
                            duration: const Duration(milliseconds: 500),
                          ));
                        },
                      ),
                      TextButton(
                        child: Text('No',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
