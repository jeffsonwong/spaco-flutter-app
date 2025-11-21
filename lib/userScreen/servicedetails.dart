import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_loginregister/models/cart.dart';
import 'package:provider/provider.dart';

class ServiceDetailsPage extends StatelessWidget {
  static const routeName = '/service-details';
  @override
  Widget build(BuildContext context) {
    final serviceID = ModalRoute.of(context).settings.arguments as String;
    final cart = Provider.of<Cart>(context);

    return Scaffold(
        backgroundColor: Color(0xff49c9f6),
        appBar: AppBar(
          backgroundColor: Color(0xff1c87ab),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          title: Text(
            "Service Details",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Services")
              .doc(serviceID)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            } else {
              Map<String, dynamic> document = snapshot.data.data();
              return Container(
                child: ListView(
                  children: <Widget>[
                    //Service Image
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 325,
                        child: Image.network(document['serviceImgURL']),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 3, color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //Service Name
                            Text("Service Name : " + document['serviceName'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            SizedBox(height: 10),

                            //Service Provider
                            Text(
                                "Service Provider : " +
                                    document['serviceproviderName'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            SizedBox(height: 10),

                            //Service Type
                            Text("Service Type : " + document['serviceType'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            SizedBox(height: 10),

                            //Service Price
                            Text(
                                "Service Price : RM" +
                                    document['servicePrice'].toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            SizedBox(height: 10),

                            //Service Description
                            Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                    text: "Service Description : \n",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                                TextSpan(
                                    text: document["serviceDescription"],
                                    style: TextStyle(fontSize: 20))
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //Add to Cart button
                    Align(
                      alignment: Alignment.center,
                      child: FloatingActionButton(
                          onPressed: () {
                            cart.addItem(
                              serviceID,
                              document['serviceName'],
                              document['servicePrice'].toDouble(),
                              document['serviceproviderID'],
                              document['serviceproviderName'],
                              document['serviceproviderPhoneNum'],
                              document['serviceproviderAddress'],
                            );
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Added to Cart",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              backgroundColor: Color(0xff1c87ab),
                              duration: const Duration(seconds: 1),
                            ));
                          },
                          child: Icon(
                            Icons.add_shopping_cart,
                            size: 30,
                          )),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
