import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminVerifyServiceProvidersPage extends StatefulWidget {
  static const routeName = '/admin-verifySP';
  @override
  _AdminVerifyServiceProvidersPage createState() =>
      _AdminVerifyServiceProvidersPage();
}

class _AdminVerifyServiceProvidersPage
    extends State<AdminVerifyServiceProvidersPage> {
  final _formKey = GlobalKey<FormState>();
  String serviceproviderID,
      icNum,
      name,
      email,
      password,
      phoneNum,
      address,
      icPhoto,
      status;
  String adminID, adminPassword;
  List type;

  @override
  Widget build(BuildContext context) {
    adminID = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Color(0xff49c9f6),
        appBar: AppBar(
          backgroundColor: Color(0xff1c87ab),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          title: Text(
            'Verify Services Providers',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("unverifiedServiceProviders")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            } else {
              return Container(
                  child: ListView(
                      children: snapshot.data.docs.map((document) {
                serviceproviderID = document["serviceproviderID"];
                icNum = document["serviceproviderICNum"];
                name = document["serviceproviderName"];
                email = document["serviceproviderEmail"];
                password = document["serviceproviderPassword"];
                phoneNum = document["serviceproviderPhoneNum"];
                address = document["serviceproviderAddress"];
                type = document["serviceproviderType"];
                icPhoto = document["serviceproviderICPhoto"];
                status = document["status"];
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
                                  text: serviceproviderID,
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
                                  text: name, style: TextStyle(fontSize: 18))
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
                                  text: email, style: TextStyle(fontSize: 18))
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
                                  text: phoneNum,
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
                                  text: address, style: TextStyle(fontSize: 18))
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
                                  text: type.toString(),
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
                                  text: icNum, style: TextStyle(fontSize: 18))
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          //IC Photo
                          Center(
                            child: Container(
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.network(icPhoto),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          //Verify and Reject Button
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
                                    'Verify',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  onPressed: () {
                                    verifySP();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Color(0xff1c87ab),
                                    borderRadius: BorderRadius.circular(5)),
                                child: MaterialButton(
                                  textColor: Colors.white,
                                  child: Text(
                                    'Reject',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  onPressed: () {
                                    rejectSP();
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

  Future<void> copyUnverifiedSP() async {
    return await FirebaseFirestore.instance
        .collection("ServiceProviders")
        .doc(serviceproviderID)
        .set({
      'serviceproviderID': serviceproviderID,
      'serviceproviderICNum': icNum,
      'serviceproviderName': name,
      'serviceproviderEmail': email,
      'serviceproviderPassword': password,
      'serviceproviderPhoneNum': phoneNum,
      'serviceproviderAddress': address,
      'serviceproviderType': type,
      'serviceproviderICPhoto': icPhoto,
      'status': status,
    }).then((value) => null);
  }

  Future<void> removeUnverifiedSP() async {
    return await FirebaseFirestore.instance
        .collection("unverifiedServiceProviders")
        .doc(serviceproviderID)
        .delete();
  }

  Future<void> verifySP() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Builder(
              builder: (context) => GestureDetector(
                onTap: () {},
                child: AlertDialog(
                  title: Text(
                    "Enter Admin Password\nto proceed.",
                    textAlign: TextAlign.center,
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              obscureText: true,
                              onChanged: (value) {
                                setState(() => adminPassword = value);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Admin Password is empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Admin Password....",
                                  errorStyle: TextStyle(fontSize: 14)),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextButton(
                                child: Text(
                                  'Verify',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    FirebaseFirestore.instance
                                        .collection("Admin")
                                        .doc(adminID)
                                        .get()
                                        .then((DocumentSnapshot snapshot) {
                                      if (snapshot.data()['adminPassword'] ==
                                          adminPassword) {
                                        copyUnverifiedSP();
                                        removeUnverifiedSP();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                              content: Text(
                                                name + " verified!",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              ),
                                              backgroundColor: Colors.black,
                                              duration:
                                                  const Duration(seconds: 1),
                                            ))
                                            .closed
                                            .then((value) {
                                          Navigator.pop(context);
                                        });
                                      } else {
                                        print('Wrong admin password');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            "Wrong admin password",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                          backgroundColor: Colors.red,
                                          duration: const Duration(seconds: 1),
                                        ));
                                      }
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> rejectSP() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Builder(
              builder: (context) => GestureDetector(
                onTap: () {},
                child: AlertDialog(
                  title: Text(
                    "Enter Admin Password\nto proceed.",
                    textAlign: TextAlign.center,
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              obscureText: true,
                              onChanged: (value) {
                                setState(() => adminPassword = value);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Admin Password is empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Admin Password....",
                                  errorStyle: TextStyle(fontSize: 14)),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextButton(
                                child: Text(
                                  'Reject',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    FirebaseFirestore.instance
                                        .collection("Admin")
                                        .doc(adminID)
                                        .get()
                                        .then((DocumentSnapshot snapshot) {
                                      if (snapshot.data()['adminPassword'] ==
                                          adminPassword) {
                                        removeUnverifiedSP();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                              content: Text(
                                                "Removed",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              ),
                                              backgroundColor: Colors.black,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                            ))
                                            .closed
                                            .then((value) {
                                          Navigator.pop(context);
                                        });
                                      } else {
                                        print('Wrong admin password');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            "Wrong admin password",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                          backgroundColor: Colors.red,
                                          duration: const Duration(seconds: 1),
                                        ));
                                      }
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
