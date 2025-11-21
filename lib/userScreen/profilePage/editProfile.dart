import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class EditProfile extends StatelessWidget {
  static const routeName = '/editprofile';
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  String name;
  String age;
  String phoneNum;
  String address;

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
            "Edit Profile",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(firebaseUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            } else {
              Map<String, dynamic> documentFields = snapshot.data.data();
              return Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: ListView(children: <Widget>[
                            SizedBox(height: 15),

                            //Icon
                            Container(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/spaco-firebase.appspot.com/o/userIcon.png?alt=media&token=6ae00362-85b0-48ef-86e1-44840bed03ea'),
                                backgroundColor: Colors.transparent,
                              ),
                            ),

                            //Name
                            TextFormField(
                                onChanged: (value) {
                                  name = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Name is empty';
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-z]+|\s')),
                                ],
                                initialValue: name = documentFields["name"],
                                decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600)),
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            SizedBox(
                              height: 10,
                            ),

                            // //Email
                            // TextFormField(
                            //     onChanged: (value) {
                            //       email = value;
                            //     },
                            //     validator: (value) {
                            //       if (value.isEmpty) {
                            //         return 'Email is empty';
                            //       } else if (!(value.contains('@'))) {
                            //         return 'Email must contain @';
                            //       } else if (!(value.contains('.com'))) {
                            //         return 'Email must contain .com';
                            //       }
                            //       return null;
                            //     },
                            //     initialValue: email = documentFields["email"],
                            //     decoration: InputDecoration(
                            //         labelText: 'Email',
                            //         labelStyle: TextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w600)),
                            //     style: TextStyle(
                            //       fontSize: 20,
                            //     )),
                            // SizedBox(
                            //   height: 5,
                            // ),

                            //Age
                            TextFormField(
                                onChanged: (value) {
                                  age = value;
                                },
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Age is empty';
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(2),
                                  FilteringTextInputFormatter.digitsOnly
                                  // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                ],
                                initialValue: age = documentFields["age"],
                                decoration: InputDecoration(
                                    labelText: 'Age',
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600)),
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            SizedBox(
                              height: 10,
                            ),

                            //Phone Number
                            TextFormField(
                                onChanged: (value) {
                                  phoneNum = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Phone Number is empty';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(11),
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                initialValue: phoneNum =
                                    documentFields["phoneNum"],
                                decoration: InputDecoration(
                                    labelText: 'Phone Number (Without -)',
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600)),
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            SizedBox(
                              height: 10,
                            ),

                            //Address
                            TextFormField(
                                onChanged: (value) {
                                  address = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Address is empty';
                                  }
                                  return null;
                                },
                                initialValue: address =
                                    documentFields["address"],
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    labelText: 'Address',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    )),
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                          ]),
                        ),
                      ),

                      //Save button
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                              color: Color(0xff1c87ab),
                              borderRadius: BorderRadius.circular(5)),
                          child: MaterialButton(
                            padding: EdgeInsets.all(10),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                updateUserDetails();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    "Saved",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  backgroundColor: Color(0xff1c87ab),
                                  duration: const Duration(milliseconds: 600),
                                ));
                              }
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }

  Future<void> updateUserDetails() async {
    final firestoreInstance = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    var firebaseUser = auth.currentUser;

    return await firestoreInstance
        .collection("users")
        .doc(firebaseUser.uid)
        .update({
      'name': name,
      'age': age,
      'phoneNum': phoneNum,
      'address': address,
    }).then((value) => null);
  }
}
