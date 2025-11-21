import 'package:flutter/material.dart';
import 'package:flutter_loginregister/serviceProvider/myJobs/QRscanner.dart';
import 'package:flutter_loginregister/userScreen/myOrders/generateQR.dart';
import 'package:flutter_loginregister/serviceProvider/spLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AcceptedJobsPage extends StatefulWidget {
  final Function toggleView;
  AcceptedJobsPage({this.toggleView});
  @override
  _AcceptedJobsPageState createState() => _AcceptedJobsPageState();
}

class _AcceptedJobsPageState extends State<AcceptedJobsPage> {
  String spID = SPDetails.spID;
  String acceptedJobStatus;
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
            'My Jobs',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Orders")
              .where("serviceproviderID", isEqualTo: spID)
              .where("jobStatus", whereIn: [
            "Accepted",
            "Ongoing",
            "Completed (Waiting Customer Confirmation)",
          ]).snapshots(),
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
                        if (document['jobStatus'] == "Accepted") {
                          acceptedJobStatus = "Start Job";
                        } else if (document['jobStatus'] == "Ongoing") {
                          acceptedJobStatus = "Job Completed";
                        } else {
                          acceptedJobStatus =
                              "Waiting for Customer Confirmation";
                        }
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

                                  //Customer Name
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text: "Customer Name : ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: document["userName"],
                                          style: TextStyle(fontSize: 18))
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  //Customer Address
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text: "Customer Address : ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: document["userAddress"],
                                          style: TextStyle(fontSize: 18))
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  //Customer Contact
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text: "Customer Contact : ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: document["userPhoneNum"],
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
                                  SizedBox(
                                    height: 10,
                                  ),

                                  //Start Job button
                                  Center(
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (document["jobStatus"] ==
                                            "Accepted") {
                                          await FirebaseFirestore.instance
                                              .collection("Orders")
                                              .doc(document["jobID"])
                                              .update({"jobStatus": "Ongoing"});
                                        } else if (document["jobStatus"] ==
                                            "Ongoing") {
                                          await FirebaseFirestore.instance
                                              .collection("Orders")
                                              .doc(document["jobID"])
                                              .update({
                                            "jobStatus":
                                                "Completed (Waiting Customer Confirmation)"
                                          });
                                        } else if (document["jobStatus"] ==
                                            "Completed (Waiting Customer Confirmation)") {
                                          Navigator.of(context).pushNamed(
                                              QRScanner.routeName,
                                              arguments: document["jobID"]);
                                        }
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
                                              Icons.check_circle_outline,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              acceptedJobStatus,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
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
}
