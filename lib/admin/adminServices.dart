import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_loginregister/serviceProvider/editServices.dart';

class AdminServicesPage extends StatefulWidget {
  static const routeName = '/admin-services';
  @override
  _AdminServicesPageState createState() => _AdminServicesPageState();
}

class _AdminServicesPageState extends State<AdminServicesPage> {
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
            'Services',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Services").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            } else {
              return Container(
                  child: ListView(
                      children: snapshot.data.docs.map((document) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ListTile(
                      tileColor: Colors.white,
                      contentPadding: EdgeInsets.only(
                          left: 15, right: 15, top: 8, bottom: 2),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                document['serviceName'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Flexible(fit: FlexFit.tight, child: SizedBox()),
                              Text(
                                document['serviceID'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Price : RM " +
                                  document['servicePrice'].toStringAsFixed(2),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Service Type : " +
                                document['serviceType'] +
                                " Service",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Service Provider : " +
                                document['serviceproviderName'],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            document['serviceDescription'],
                            style: TextStyle(fontSize: 18),
                          ),
                          Center(
                            child: Container(
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.network(document['serviceImgURL']),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Color(0xff1c87ab),
                                    borderRadius: BorderRadius.circular(5)),
                                child: MaterialButton(
                                  textColor: Colors.white,
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        EditServicesPage.routeName,
                                        arguments: document['serviceID']);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Color(0xff1c87ab),
                                    borderRadius: BorderRadius.circular(5)),
                                child: MaterialButton(
                                  textColor: Colors.white,
                                  child: Text(
                                    'Remove',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  onPressed: () {
                                    _removeDialog(document['serviceID']);
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList()));
            }
          },
        ));
  }

  Future<void> _removeDialog(String serviceID) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Remove Confirmation',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Press Yes to confirm,\nPress No to return.',
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          'Yes',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('Services')
                              .doc(serviceID)
                              .delete();
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text('No',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // actions: <Widget>[
          //   TextButton(
          //     child: Text(
          //       'Yes',
          //     ),
          //     onPressed: () {
          //       FirebaseFirestore.instance
          //           .collection('Services')
          //           .doc(serviceID)
          //           .delete();
          //       Navigator.pop(context);
          //     },
          //   ),
          // TextButton(
          //   child: Text('No'),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
          // ],
        );
      },
    );
  }
}
