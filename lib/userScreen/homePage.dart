import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loginregister/userScreen/myOrders/myOrders.dart';
import 'package:flutter_loginregister/userScreen/servicelist.dart';
import 'profilePage/profilePage.dart';
import 'package:flutter_loginregister/userScreen/cartPage.dart';
import 'package:flutter_loginregister/widgets/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  var firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                Container(
                  height: 100,
                  child: DrawerHeader(
                    child: Text(
                      "SPACO",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff1c87ab),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'My Profile',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () =>
                      {Navigator.of(context).pushNamed(ProfilePage.routeName)},
                ),
                ListTile(
                  title: Text('My Orders', style: TextStyle(fontSize: 20)),
                  onTap: () {
                    Navigator.of(context).pushNamed(MyOrders.routeName);
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomLeft,
              child: Container(
                child: Column(
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () async {
                        await _auth.signOut();
                      },
                      child: Text(
                        "Sign Out",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff49c9f6),
      appBar: AppBar(
        backgroundColor: Color(0xff1c87ab),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: Text(
          "Home",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartPage.routeName))
        ],
      ),
      body: Container(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 15),
          // child: AllServices(),
          child: GridView.count(
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            crossAxisCount: 2,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ServiceListPage.routeName,
                      arguments: "Aircond");
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GridTile(
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/spaco-firebase.appspot.com/o/Service%20Icons%2FAircond%20service%20icon.jpg?alt=media&token=492d2154-70bd-4f2a-a6bd-f54e605f7742'),
                    footer: Container(
                      height: 30,
                      color: Colors.white,
                      child: Center(
                        child: Text('Aircond Services',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ServiceListPage.routeName,
                      arguments: "Plumbing");
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GridTile(
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/spaco-firebase.appspot.com/o/Service%20Icons%2FPlumbing%20service%20icon.jpg?alt=media&token=66ae7e86-4ac6-4415-a0d5-eecb389b216e'),
                    footer: Container(
                      height: 30,
                      color: Colors.white,
                      child: Center(
                        child: Text('Plumbing Services',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ServiceListPage.routeName,
                      arguments: "Cleaning");
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GridTile(
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/spaco-firebase.appspot.com/o/Service%20Icons%2FCleaning%20service%20icon.jpg?alt=media&token=46686e66-de00-458d-b564-ab19e37e18d1'),
                    footer: Container(
                      height: 30,
                      color: Colors.white,
                      child: Center(
                        child: Text('Cleaning Services',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ServiceListPage.routeName,
                      arguments: "Disinfection");
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GridTile(
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/spaco-firebase.appspot.com/o/Service%20Icons%2FDisinfection%20service%20icon.jpg?alt=media&token=77d18eb1-0bcf-42a9-a94a-ef402266960d'),
                    footer: Container(
                      height: 30,
                      color: Colors.white,
                      child: Center(
                        child: Text('Disinfection Service',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ServiceListPage.routeName,
                      arguments: "Moving");
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GridTile(
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/spaco-firebase.appspot.com/o/Service%20Icons%2FMoving%20service%20icon.jpg?alt=media&token=49ff6003-f74e-4050-919a-152613716ac3'),
                    footer: Container(
                      height: 30,
                      color: Colors.white,
                      child: Center(
                        child: Text('Moving Services',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ServiceListPage.routeName,
                      arguments: "Appliances");
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GridTile(
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/spaco-firebase.appspot.com/o/Service%20Icons%2FAppliance%20service%20icon.jpg?alt=media&token=a3f3886d-874c-45da-a1fd-a9f39a39e20c'),
                    footer: Container(
                      height: 30,
                      color: Colors.white,
                      child: Center(
                        child: Text('Appliances Service',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // loginAdmin() {
  //   var firebaseUser = FirebaseAuth.instance.currentUser;
  //   FirebaseFirestore.instance.collection("test").get().then((snapshot) {
  //     snapshot.docs.forEach((result) {
  //       if (result.data()["userid"] == firebaseUser.uid) {
  //         Text(result.data()["name"]);
  //       }
  //     });
  //   });
  // }

  // Future<DocumentSnapshot> getName() async {
  //   var firebaseUser = await FirebaseAuth.instance.currentUser;
  //   return await FirebaseFirestore.instance
  //       .collection("test")
  //       .doc(firebaseUser.uid)
  //       .get();
  // }
}
// final FirebaseAuth auth = FirebaseAuth.instance;
// final User user = auth.currentUser;
// final uid = user.uid;

// // final firestoreInstance = FirebaseFirestore.instance;
// // firestoreInstance.collection("orders").add({
// //   'test': uid,
// // }).then((value) => null);

//   FirebaseFirestore.instance.collection("test").get().then((querySnapshot) {
//     querySnapshot.docs.forEach((result) {
//       print(result.data()['name'] + " and " + result.data()['userid']);
//       Text(
//         "Welcome Back, " + result.data()['name'],
//         style: TextStyle(color: Colors.black),
//       );
//     });
//   });
