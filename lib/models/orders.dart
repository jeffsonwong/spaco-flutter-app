import 'package:flutter/cupertino.dart';
import './cart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Orders with ChangeNotifier {
  String userID;
  String name;
  String phoneNum;
  String address;
  String jobID;
  String serviceID;

  Future<void> addOrder(List<CartItem> cartservices, double total,
      String jobDate, String jobTime) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var firebaseUser = auth.currentUser;
    final timeStamp = DateTime.now();
    final firestoreInstance = FirebaseFirestore.instance;

    //get User details
    await firestoreInstance
        .collection('users')
        .doc(firebaseUser.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      name = snapshot['name'];
      phoneNum = snapshot['phoneNum'];
      address = snapshot['address'];
    });

    cartservices
        .map((cs) => {
              jobID = UniqueKey().toString(),
              firestoreInstance.collection("Orders").doc(jobID).set({
                'serviceID': cs.id,
                'serviceName': cs.name,
                'jobQuantity': cs.quantity,
                'jobStatus': "Pending",
                'servicePrice': cs.price,
                'serviceproviderID': cs.spID,
                'serviceproviderName': cs.spName,
                'serviceproviderPhoneNum': cs.spPhoneNum,
                'serviceproviderAddress': cs.spAddress,
                'jobID': jobID,
                'jobDate': jobDate,
                'jobTime': jobTime,
                'userID': firebaseUser.uid,
                'userName': name,
                'userPhoneNum': phoneNum,
                'userAddress': address,
                'orderDateTime': timeStamp.toIso8601String(),
              }).then((value) => null)
            })
        .toList();

    // try {
    //   return await firestoreInstance
    //       // .collection("users")
    //       // .doc(firebaseUser.uid)
    //       .collection("Orders")
    //       .doc(jobID)
    //       .set(
    //     {
    //       'jobID': jobID,
    //       'userID': firebaseUser.uid,
    //       'userName': name,
    //       'userPhoneNum': phoneNum,
    //       'userAddress': address,
    //       'orderDateTime': timeStamp.toIso8601String(),
    //       'jobAmount(Total)': total,
    //       'jobDateTime': jobDate + ' ' + jobTime,
    //       // 'jobDetails': cartservices
    //       //     .map((cs) => {
    //       //           'serviceID': cs.id,
    //       //           'serviceName': cs.name,
    //       //           'jobQuantity': cs.quantity,
    //       //           'servicePrice': cs.price,
    //       //           'serviceproviderID': cs.spID,
    //       //           'serviceproviderName': cs.spName,
    //       //         })
    //       //     .toList(),
    //     },
    //   ).then((value) => null);
    // } catch (err) {
    //   throw err;
    // }
  }
}

// return await orderService.doc(orderService.id).set({
//   'CartID': UniqueKey().toString(),
//   'Amount(Total)': total,
//   'DateTime': timeStamp.toIso8601String(),
//   'ServicesDetails': cartServices
//       .map((cs) => {
//             'ServiceID': cs.id,
//             'ServiceName': cs.name,
//             'ServiceQuantity': cs.quantity,
//             'ServicePrice': cs.price
//           })
//       .toList(),
// });
