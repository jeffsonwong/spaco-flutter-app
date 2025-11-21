import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_loginregister/serviceProvider/spEditProfile.dart';
import 'package:flutter_loginregister/serviceProvider/spLogin.dart';

class ServiceProviderProfilePage extends StatefulWidget {
  static const routeName = '/ServiceProvider-profile';
  @override
  _ServiceProviderProfilePageState createState() =>
      _ServiceProviderProfilePageState();
}

class _ServiceProviderProfilePageState
    extends State<ServiceProviderProfilePage> {
  String spID = SPDetails.spID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff49c9f6),
        appBar: AppBar(
          backgroundColor: Color(0xff1c87ab),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            "My Profile",
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
              Map<String, dynamic> documentFields = snapshot.data.data();
              return Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/spaco-firebase.appspot.com/o/serviceproviderBlueIcon.png?alt=media&token=0d56a039-c409-4248-b2cd-b0825ee809d4'),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 5, color: Colors.black),
                              borderRadius: new BorderRadius.circular(20)),
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              //Name
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                        text: "Name : ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: documentFields[
                                            "serviceproviderName"],
                                        style: TextStyle(fontSize: 20))
                                  ]),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              //Email
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                        text: "Email : ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: documentFields[
                                            "serviceproviderEmail"],
                                        style: TextStyle(fontSize: 20))
                                  ]),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              //IC Number
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                        text: "IC Number : ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: documentFields[
                                            "serviceproviderICNum"],
                                        style: TextStyle(fontSize: 20))
                                  ]),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              //Phone Number
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                        text: "Phone Number : ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: documentFields[
                                            "serviceproviderPhoneNum"],
                                        style: TextStyle(fontSize: 20))
                                  ]),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              //Address
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                        text: "Address : \n",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: documentFields[
                                            "serviceproviderAddress"],
                                        style: TextStyle(fontSize: 20))
                                  ]),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              //Service Type
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                        text: "Service Type : ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: documentFields[
                                                "serviceproviderType"]
                                            .toString(),
                                        style: TextStyle(fontSize: 20))
                                  ]),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Flexible(
                      child: Column(
                        children: <Widget>[
                          //Change Password button
                          Align(
                            alignment: Alignment.centerLeft,
                            child: MaterialButton(
                              padding: EdgeInsets.only(left: 25),
                              onPressed: () {
                                changePassword();
                              },
                              child: Text(
                                "Change Password",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),

                          //Edit Profile Button
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        ServiceProvidersEditProfile.routeName,
                                        arguments: spID);
                                  },
                                  child: Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }

  Future<void> changePassword() async {
    String newPassword;
    final _formKey = GlobalKey<FormState>();
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
                    "Enter new Password",
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
                              onChanged: (value) {
                                setState(() => newPassword = value);
                              },
                              textAlign: TextAlign.center,
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'New Password is empty!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "New Password....",
                                hintStyle: TextStyle(fontSize: 18),
                                alignLabelWithHint: true,
                                errorStyle: TextStyle(fontSize: 15),
                              ),
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
                                    'Change',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      if (newPassword.length < 6) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            'Password must be longer than 6 characters!',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          backgroundColor: Colors.red,
                                          duration: const Duration(seconds: 3),
                                        ));
                                      } else {
                                        FirebaseFirestore.instance
                                            .collection("ServiceProviders")
                                            .doc(spID)
                                            .update({
                                          "serviceproviderPassword":
                                              newPassword,
                                        });
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            "Password Successfully Changed!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          backgroundColor: Color(0xff1c87ab),
                                          duration: const Duration(seconds: 1),
                                        ));
                                      }
                                    }
                                  })
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
