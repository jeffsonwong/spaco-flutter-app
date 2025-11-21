import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_loginregister/admin/adminEditUser.dart';

class AdminUsersPage extends StatefulWidget {
  static const routeName = '/admin-users';
  @override
  _AdminUsersPageState createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
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
            'Users',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
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
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: "User ID : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: document["userID"],
                                  style: TextStyle(fontSize: 15.5))
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: "Name : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: document["name"],
                                  style: TextStyle(fontSize: 18))
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: "Email : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: document["email"],
                                  style: TextStyle(fontSize: 18))
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: "Phone Number : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: document["phoneNum"],
                                  style: TextStyle(fontSize: 18))
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: "Address : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: document["address"],
                                  style: TextStyle(fontSize: 18))
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
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
                          SizedBox(
                            height: 10,
                          ),
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
                                        AdminEditUserPage.routeName,
                                        arguments: document['userID']);
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
                                        document["userID"], document["status"]);
                                    // _removeDialog(document['userID']);
                                    // FirebaseAuth.instance.currentUser.delete();
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

  Future changeAccountStatus(String userID, String status) async {
    final firestoreInstance = FirebaseFirestore.instance;
    String newStatus;
    if (status == 'Unsuspended') {
      newStatus = 'Suspended';
    } else {
      newStatus = 'Unsuspended';
    }

    return await firestoreInstance.collection("users").doc(userID).update({
      'status': newStatus,
    }).then((value) => null);
  }
}
