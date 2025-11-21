import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_loginregister/userScreen/profilePage/editProfile.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  String newPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff49c9f6),
        appBar: AppBar(
          backgroundColor: Color(0xff1c87ab),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
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
              .collection("users")
              .doc(firebaseUser.uid)
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
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/spaco-firebase.appspot.com/o/userIcon.png?alt=media&token=6ae00362-85b0-48ef-86e1-44840bed03ea'),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Container(
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 3, color: Colors.black),
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
                                        text: documentFields["name"],
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
                                        text: documentFields["email"],
                                        style: TextStyle(fontSize: 20))
                                  ]),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              //Age
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                        text: "Age : ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: documentFields["age"],
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
                                        text: documentFields["phoneNum"],
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
                                        text: documentFields["address"],
                                        style: TextStyle(fontSize: 20))
                                  ]),
                                ),
                              ),
                            ],
                          )),
                    ),

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
                    SizedBox(
                      height: 60,
                    ),

                    //Edit Profile Button
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(EditProfile.routeName);
                            },
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
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
                                        firebaseUser
                                            .updatePassword(newPassword);
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
