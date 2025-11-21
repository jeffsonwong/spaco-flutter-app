import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loginregister/ServiceProvider/spProfile.dart';
import 'package:flutter_loginregister/admin/Orders/adminOrders.dart';
import 'package:flutter_loginregister/admin/adminEditUser.dart';
import 'package:flutter_loginregister/admin/adminHomepage.dart';
import 'package:flutter_loginregister/admin/adminLogin.dart';
import 'package:flutter_loginregister/admin/adminServiceProviders.dart';
import 'package:flutter_loginregister/admin/adminServices.dart';
import 'package:flutter_loginregister/admin/adminUsers.dart';
import 'package:flutter_loginregister/admin/adminVerifySP.dart';
import 'package:flutter_loginregister/serviceProvider/addServices.dart';
import 'package:flutter_loginregister/serviceProvider/editServices.dart';
import 'package:flutter_loginregister/serviceProvider/myJobs/QRscanner.dart';
import 'package:flutter_loginregister/userScreen/myOrders/generateQR.dart';
import 'package:flutter_loginregister/serviceProvider/myJobs/myJobs.dart';
import 'package:flutter_loginregister/serviceProvider/removeServices.dart';
import 'package:flutter_loginregister/serviceProvider/spEditProfile.dart';
import 'package:flutter_loginregister/userScreen/myOrders/myOrders.dart';
import 'package:flutter_loginregister/userScreen/profilePage/editProfile.dart';
import 'package:flutter_loginregister/userScreen/profilePage/profilePage.dart';
import 'package:flutter_loginregister/serviceProvider/myServices.dart';
import 'package:flutter_loginregister/userScreen/myOrders/reviewPage.dart';
import 'package:flutter_loginregister/userScreen/servicedetails.dart';
import 'package:flutter_loginregister/userScreen/servicelist.dart';
import 'serviceProvider/spSignUp.dart';
import 'serviceProvider/spHomepage.dart';
import 'serviceProvider/spLogin.dart';
import 'package:flutter_loginregister/authentication/authenticate.dart';
import 'package:flutter_loginregister/models/orders.dart';
import 'package:flutter_loginregister/models/services.dart';
import 'package:flutter_loginregister/models/users.dart';
import 'package:flutter_loginregister/userScreen/homePage.dart';
import 'package:flutter_loginregister/widgets/auth.dart';
import 'package:provider/provider.dart';
import './models/cart.dart';
import 'userScreen/cartPage.dart';
import 'widgets/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Users>.value(value: AuthService().user),
        ChangeNotifierProvider.value(
          value: Services(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Product Sans'),
        home: LandingPage(),
        routes: {
          AdminOrders.routeName: (ctx) => AdminOrders(),
          AdminVerifyServiceProvidersPage.routeName: (ctx) =>
              AdminVerifyServiceProvidersPage(),
          AdminServiceProvidersPage.routeName: (ctx) =>
              AdminServiceProvidersPage(),
          AdminEditUserPage.routeName: (ctx) => AdminEditUserPage(),
          AdminUsersPage.routeName: (ctx) => AdminUsersPage(),
          AdminServicesPage.routeName: (ctx) => AdminServicesPage(),
          AdminHomePage.routeName: (ctx) => AdminHomePage(),
          AdminLoginPage.routeName: (ctx) => AdminLoginPage(),
          QRScanner.routeName: (ctx) => QRScanner(),
          ServiceProviderHomePage.routeName: (ctx) => ServiceProviderHomePage(),
          ServiceProviderSignInPage.routeName: (ctx) =>
              ServiceProviderSignInPage(),
          ServiceProviderSignUpPage.routeName: (ctx) =>
              ServiceProviderSignUpPage(),
          ServiceProviderProfilePage.routeName: (ctx) =>
              ServiceProviderProfilePage(),
          ServiceProvidersEditProfile.routeName: (ctx) =>
              ServiceProvidersEditProfile(),
          RemoveServicesPage.routeName: (ctx) => RemoveServicesPage(),
          AddServicesPage.routeName: (ctx) => AddServicesPage(),
          EditServicesPage.routeName: (ctx) => EditServicesPage(),
          MyServices.routeName: (ctx) => MyServices(),
          MyJobs.routeName: (ctx) => MyJobs(),
          ServiceListPage.routeName: (ctx) => ServiceListPage(),
          ServiceDetailsPage.routeName: (ctx) => ServiceDetailsPage(),
          CartPage.routeName: (ctx) => CartPage(),
          ProfilePage.routeName: (ctx) => ProfilePage(),
          EditProfile.routeName: (ctx) => EditProfile(),
          MyOrders.routeName: (ctx) => MyOrders(),
          QRGenerator.routeName: (ctx) => QRGenerator(),
          ReviewPage.routeName: (ctx) => ReviewPage(),
        },
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    print(user);
    //return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}

// class LandingPage extends StatelessWidget {
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _initialization,
//       builder: (context, snapshot) {
//         //check for errors
//         if (snapshot.hasError) {
//           return Scaffold(
//             body: Center(
//               child: Text("Error: ${snapshot.error}"),
//             ),
//           );
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           return StreamBuilder(
//             stream: FirebaseAuth.instance.authStateChanges(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.active) {
//                 User user = snapshot.data;

//                 if (user != null) {
//                   return HomePage();
//                 } else {
//                   return LoginPage();
//                 }
//               }
//               return Scaffold(
//                 body: Center(
//                   child: Text("Checking Authentication..."),
//                 ),
//               );
//             },
//           );
//         }

//         return Scaffold(
//           body: Center(
//             child: Text("Connecting to the app..."),
//           ),
//         );
//       },
//     );
//   }
// }
