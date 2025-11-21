import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_loginregister/authentication/login.dart';
import 'package:flutter_loginregister/models/users.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get UID
  Future<String> getCurrentUID() async {
    return (await _auth.currentUser).uid;
  }

  //create user object based on FirebaseUser
  Users _userFromFirebaseUser(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<Users> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
    //.map((User user) => _userFromFirebaseUser(user));
  }

  //register with email & password
  Future registerwithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;
    return _userFromFirebaseUser(user);
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
