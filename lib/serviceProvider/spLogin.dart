import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loginregister/serviceProvider/spHomepage.dart';
import 'package:flutter_loginregister/serviceProvider/spSignUp.dart';

class SPDetails {
  static String spID;
}

class ServiceProviderSignInPage extends StatelessWidget {
  static const routeName = '/ServiceProvider-login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xff1c87ab),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: Text(
          'Service Provider Login',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: ServiceProviderSignInScreen(),
    );
  }
}

class ServiceProviderSignInScreen extends StatefulWidget {
  @override
  _ServiceProviderSignInScreenState createState() =>
      _ServiceProviderSignInScreenState();
}

class _ServiceProviderSignInScreenState
    extends State<ServiceProviderSignInScreen> {
  final _formKey = GlobalKey<FormState>();

  //text field state'
  String email = '';
  String password = '';
  String status = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),

              //Email
              TextFormField(
                onChanged: (value) {
                  setState(() => email = value.toLowerCase());
                  _checkSuspend();
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Email is empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
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
                  }
                  return null;
                },
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter Password...."),
              ),
              SizedBox(height: 20),

              //Login Button
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
                      _checkSuspend();
                      if (status == 'Suspended') {
                        Scaffold.of(context).showSnackBar(SnackBar(
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
                        loginSP();
                      }
                    }
                  },
                  child: Text(
                    "Login",
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

              //Service Provider Sign Up
              MaterialButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(ServiceProviderSignUpPage.routeName);
                },
                child: Text(
                  "Apply to be a Service Provider",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ));
  }

  Future _checkSuspend() async {
    await FirebaseFirestore.instance
        .collection("ServiceProviders")
        .where('serviceproviderEmail', isEqualTo: email)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((result) {
        status = result['status'];
      });
    });
  }

  loginSP() {
    bool loginSuccess;
    FirebaseFirestore.instance
        .collection("ServiceProviders")
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()["serviceproviderEmail"] == email.trim() &&
            result.data()["serviceproviderPassword"] == password.trim()) {
          loginSuccess = true;
          Navigator.of(context)
              .pushReplacementNamed(ServiceProviderHomePage.routeName);
          SPDetails.spID = result.data()["serviceproviderID"];
        } else {
          loginSuccess = false;
        }
      });
      if (loginSuccess == false) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            "Invalid Email / Invalid Password",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 15),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ));
      }
    });
  }
}
