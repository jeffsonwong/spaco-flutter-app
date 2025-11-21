import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QRScanner extends StatefulWidget {
  static const routeName = '/ServiceProvider-QRscanner';
  @override
  _QRScanner createState() => _QRScanner();
}

class _QRScanner extends State<QRScanner> {
  GlobalKey qrKey = GlobalKey();
  String qrData, scanResult = "No QR Code Detected";
  var qrText = "";
  QRViewController controller;
  @override
  Widget build(BuildContext context) {
    qrData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
            flex: 5,
            child: QRView(
                key: qrKey,
                overlay: QrScannerOverlayShape(
                    borderRadius: 10,
                    borderColor: Colors.red,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300),
                onQRViewCreated: _onQRViewCreate)),
        Expanded(
          flex: 1,
          child: Center(
            child: Text('Scan result: ' + scanResult.toString()),
          ),
        ),
      ],
    ));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreate(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
        if (qrText == qrData) {
          controller.pauseCamera();
          completeMessage();
          FirebaseFirestore.instance.collection("Orders").doc(qrData).update({
            "jobStatus": "Completed",
          });
          scanResult = "Success";
        } else {
          scanResult = "Wrong QR Code";
        }
      });
    });
  }

  completeMessage() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Job is Completed!',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Press Okay to return.',
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          'Okay',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
