import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class ServiceProvidersEditProfile extends StatelessWidget {
  static const routeName = '/ServiceProvider-editprofile';
  final _formKey = GlobalKey<FormState>();
  String name;
  String phoneNum;
  String address;
  String spID;

  @override
  Widget build(BuildContext context) {
    spID = ModalRoute.of(context).settings.arguments;
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
              .collection("ServiceProviders")
              .doc(spID)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            } else {
              Map<String, dynamic> document = snapshot.data.data();
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
                                radius: 65,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/spaco-firebase.appspot.com/o/serviceproviderBlueIcon.png?alt=media&token=0d56a039-c409-4248-b2cd-b0825ee809d4'),
                                  backgroundColor: Colors.transparent,
                                ),
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
                                initialValue: name =
                                    document["serviceproviderName"],
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
                                    document["serviceproviderPhoneNum"],
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
                                    document["serviceproviderAddress"],
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

                                print(spID);
                                Scaffold.of(context).showSnackBar(SnackBar(
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
    await firestoreInstance.collection("ServiceProviders").doc(spID).update({
      'serviceproviderName': name,
      'serviceproviderPhoneNum': phoneNum,
      'serviceproviderAddress': address,
    }).then((value) => null);

    FirebaseFirestore.instance
        .collection("Services")
        .where("serviceproviderID", isEqualTo: spID)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((result) {
        result.reference.update({
          'serviceproviderName': name,
          'serviceproviderPhoneNum': phoneNum,
          'serviceproviderAddress': address,
        });
      });
    });

    FirebaseFirestore.instance
        .collection("Orders")
        .where("serviceproviderID", isEqualTo: spID)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((result) {
        result.reference.update({
          'serviceproviderName': name,
          'serviceproviderPhoneNum': phoneNum,
          'serviceproviderAddress': address,
        });
      });
    });
  }
}
