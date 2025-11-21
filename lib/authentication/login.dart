import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loginregister/admin/adminLogin.dart';
import 'package:flutter_loginregister/widgets/auth.dart';
import 'package:flutter_loginregister/serviceProvider/spLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({this.toggleView});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final emailTextfield = TextEditingController();
  final passwordTextfield = TextEditingController();
  //text field state'
  String email = '';
  String password = '';
  String status = '';

  void clearText() {
    emailTextfield.clear();
    passwordTextfield.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xff1c87ab),
        iconTheme: IconThemeData(
          color: Colors.black, //change color here
        ),
        centerTitle: true,
        title: Text(
          'Login',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.gif'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Image.asset(
                        'assets/logoSpaco.png',
                        width: 275,
                        height: 275,
                      ),
                    ),

                    //Email
                    TextFormField(
                      onChanged: (value) {
                        setState(() => email = value);
                        _checkSuspend();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Email is empty';
                        } else if (!(value.contains('@'))) {
                          return 'Email must contain @';
                        } else if (!(value.contains('.com'))) {
                          return 'Email must contain .com';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Enter Email...."),
                      controller: emailTextfield,
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
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Enter Password...."),
                      controller: passwordTextfield,
                    ),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //Sign In button
                        MaterialButton(
                          height: 45,
                          minWidth: 130,
                          color: Color(0xff1c87ab),
                          shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _checkSuspend();
                              if (status == 'Suspended') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'Account has been Suspended!',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 15),
                                  ),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 3),
                                ));
                              } else {
                                try {
                                  await _auth.signInWithEmailAndPassword(
                                      email, password);
                                  clearText();
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        'User not found',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 15),
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: const Duration(seconds: 2),
                                    ));
                                  } else if (e.code == 'wrong-password') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        'Invalid password',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 15),
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: const Duration(seconds: 2),
                                    ));
                                  } else if (e.code == 'invalid-email') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        'Invalid email',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 15),
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: const Duration(seconds: 2),
                                    ));
                                  }
                                  print(e);
                                }
                              }
                            }
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),

                        SizedBox(
                          width: 20,
                        ),

                        //Admin Access button
                        ButtonTheme(
                          height: 45,
                          minWidth: 130,
                          child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(AdminLoginPage.routeName);
                                clearText();
                              },
                              color: Color(0xff1c87ab),
                              shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                "Admin",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              )),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 5,
                    ),

                    //Toggle Register screen
                    MaterialButton(
                      onPressed: () {
                        widget.toggleView();
                        clearText();
                      },
                      child: Text(
                        "Create New Account",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    //Service Provider Access button
                    ButtonTheme(
                      height: 45,
                      child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(ServiceProviderSignInPage.routeName);
                            clearText();
                          },
                          //color: Color(0xff1c87ab),
                          // shape: new RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(30),
                          // ),
                          child: Text(
                            "Service Provider Click Here",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          )),
                    ),
                  ],
                ),
              ),

              //Admin Access button
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                ),
              ),
            ],
          )),
    );
  }

  Future _checkSuspend() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where('email', isEqualTo: email)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((result) {
        status = result['status'];
      });
    });
  }
}
