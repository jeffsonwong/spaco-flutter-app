import 'package:flutter/material.dart';
import 'package:flutter_loginregister/widgets/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state'
  String email = '';
  String password = '';
  String error = '';
  String name = '';
  String age = '';
  String phoneNum = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1c87ab),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: Text(
          'Register',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.gif'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),

                  //Email
                  TextFormField(
                    onChanged: (value) {
                      setState(() => email = value);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Email is empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        // errorStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Enter Email...."),
                  ),
                  SizedBox(height: 20),

                  //Password
                  TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      setState(() => password = value);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password is empty';
                      } else if (value.length < 6) {
                        return 'Minimum 6 password characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Enter Password...."),
                  ),
                  SizedBox(height: 20),

                  //Name
                  TextFormField(
                    onChanged: (value) {
                      setState(() => name = value);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name is empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Enter Name...."),
                  ),
                  SizedBox(height: 20),

                  //Register button
                  ButtonTheme(
                    height: 45,
                    minWidth: 130,
                    child: MaterialButton(
                      color: Color(0xff1c87ab),
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result = await _auth
                              .registerwithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() =>
                                error = 'Please enter a valid email/password');
                          }
                          storeUserDetails();
                        }
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  //Back to login button
                  MaterialButton(
                    onPressed: () {
                      widget.toggleView();
                    },
                    child: Text(
                      "Already have an account?\n(Back to Login)",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<void> storeUserDetails() async {
    final firestoreInstance = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    var firebaseUser = auth.currentUser;

    return await firestoreInstance
        .collection("users")
        .doc(firebaseUser.uid)
        .set({
      'userID': firebaseUser.uid,
      'email': email,
      'name': name,
      'age': age,
      'phoneNum': phoneNum,
      'address': address,
      'status': 'Unsuspended',
    }).then((value) => null);
  }
}
