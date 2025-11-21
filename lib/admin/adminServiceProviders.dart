import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_loginregister/serviceProvider/spEditProfile.dart';

class AdminServiceProvidersPage extends StatefulWidget {
  static const routeName = '/admin-serviceproviders';
  @override
  _AdminServiceProvidersPageState createState() =>
      _AdminServiceProvidersPageState();
}

class _AdminServiceProvidersPageState extends State<AdminServiceProvidersPage> {
  String statusText;

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
            'Services Providers',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("ServiceProviders")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            } else {
              return Container(
                  child: ListView(
                      children: snapshot.data.docs.map((document) {
                if (document["status"] == "Suspended") {
                  statusText = 'Unsuspend';
                } else {
                  statusText = 'Suspend';
                }
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ListTile(
                      tileColor: Colors.white,
                      contentPadding: EdgeInsets.only(
                          left: 15, right: 15, top: 8, bottom: 2),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //Service Provider ID
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: "Service Provider ID : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: document["serviceproviderID"],
                                  style: TextStyle(fontSize: 18))
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          //Name
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
                            height: 10,
                          ),

                          //Service Provider Email
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: "Email : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: document["serviceproviderEmail"],
                                  style: TextStyle(fontSize: 18))
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          //Service Provider Phone Number
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: "Phone Number : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: document["serviceproviderPhoneNum"],
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
                                  text: "Address : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: document["serviceproviderAddress"],
                                  style: TextStyle(fontSize: 18))
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          //Service Type
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: "Service Type : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: document['serviceproviderType']
                                      .toString(),
                                  style: TextStyle(fontSize: 18))
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          //Service Provider I/C Number
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: "I/C Number : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: document["serviceproviderICNum"],
                                  style: TextStyle(fontSize: 18))
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          //Account Status
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: "Account Status : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: document["status"],
                                  style: TextStyle(fontSize: 18))
                            ]),
                          ),

                          //IC Photo
                          Center(
                            child: Container(
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.network(
                                    document['serviceproviderICPhoto']),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          //Edit and Suspend Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Color(0xff1c87ab),
                                    borderRadius: BorderRadius.circular(5)),
                                child: MaterialButton(
                                  textColor: Colors.white,
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        ServiceProvidersEditProfile.routeName,
                                        arguments:
                                            document['serviceproviderID']);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 40,
                                width: 130,
                                decoration: BoxDecoration(
                                    color: Color(0xff1c87ab),
                                    borderRadius: BorderRadius.circular(5)),
                                child: MaterialButton(
                                  textColor: Colors.white,
                                  child: Text(
                                    statusText,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  onPressed: () {
                                    changeAccountStatus(
                                        document['serviceproviderID'],
                                        document['status']);
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList()));
            }
          },
        ));
  }

  Future changeAccountStatus(String serviceproviderID, String status) async {
    final firestoreInstance = FirebaseFirestore.instance;
    String newStatus;
    if (status == 'Unsuspended') {
      newStatus = 'Suspended';
    } else {
      newStatus = 'Unsuspended';
    }

    return await firestoreInstance
        .collection("ServiceProviders")
        .doc(serviceproviderID)
        .update({
      'status': newStatus,
    }).then((value) => null);
  }
}
