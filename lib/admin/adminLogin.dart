import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loginregister/admin/adminHomepage.dart';

class AdminLoginPage extends StatelessWidget {
  static const routeName = '/admin-login';
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
          'Admin Login',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: AdminLoginScreen(),
    );
  }
}

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  //text field state'
  String email = '';
  String password = '';

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
                  setState(() => email = value);
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
                    hintText: "Enter Admin Email...."),
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

              //Login button
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
                      loginAdmin();
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
            ],
          ),
        ));
  }

  loginAdmin() {
    bool loginsuccess;
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()["adminEmail"] == email.trim() &&
            result.data()["adminPassword"] == password.trim()) {
          loginsuccess = true;
          Navigator.of(context).pushNamed(AdminHomePage.routeName,
              arguments: result.data()["adminID"]);
        } else {
          loginsuccess = false;
        }
      });
      if (loginsuccess == false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Invalid Email / Password",
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
