import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class QRGenerator extends StatefulWidget {
  static const routeName = '/QRgenerator';

  @override
  _QRGeneratorState createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  String qrData;
  Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => checkComplete());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    qrData = ModalRoute.of(context).settings.arguments;
    checkComplete();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1c87ab),
        title: Text(
          "Generate",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 50.0, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            Text(
              "Show this QR Code to the Service Provider only after job is Completed!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 80,
            ),
            QrImage(data: qrData),
          ],
        ),
      ),
    );
  }

  checkComplete() async {
    String jobStatus;
    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(qrData)
        .get()
        .then((DocumentSnapshot document) => {
              jobStatus = document["jobStatus"],
              if (jobStatus == "Completed")
                {
                  Navigator.pop(context),
                }
            });
  }
}
