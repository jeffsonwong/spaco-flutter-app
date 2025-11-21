import 'package:flutter/material.dart';
import 'package:flutter_loginregister/serviceProvider/spLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PendingJobsPage extends StatefulWidget {
  final Function toggleView;
  PendingJobsPage({this.toggleView});
  @override
  _PendingJobsPageState createState() => _PendingJobsPageState();
}

class _PendingJobsPageState extends State<PendingJobsPage> {
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
            'My Jobs',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Orders")
              .where("serviceproviderID", isEqualTo: spID)
              .where("jobStatus", isEqualTo: "Pending")
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
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 5, top: 5),
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

                                  //User Name
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

                                  //User Address
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

                                  //User Contact
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

                                  //Accept or Reject Button
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          height: 40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4.5,
                                          decoration: BoxDecoration(
                                              color: Color(0xff1c87ab),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: GestureDetector(
                                              onTap: () {
                                                acceptJob(document["jobID"]);
                                              },
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
                                                    'Accept Job',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ))),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          rejectJob(document["jobID"]);
                                        },
                                        child: Container(
                                            height: 40,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4.5,
                                            decoration: BoxDecoration(
                                                color: Color(0xff1c87ab),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.highlight_off_outlined,
                                                  size: 25,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Reject Job',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  )
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

  Future<void> acceptJob(String jobID) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Accept Job Confirmation',
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
                              .collection('Orders')
                              .doc(jobID)
                              .update({'jobStatus': "Accepted"});
                          Navigator.pop(context);
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

  Future<void> rejectJob(String jobID) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Reject Job Confirmation',
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
                              .collection('Orders')
                              .doc(jobID)
                              .update({'jobStatus': "Rejected"});
                          Navigator.pop(context);
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
