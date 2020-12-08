import 'package:firebase_auth/firebase_auth.dart';
import 'package:speed_meeting/locator.dart';
import 'package:speed_meeting/models/auth_info.dart';
import 'package:speed_meeting/models/user.dart';
import 'package:speed_meeting/services/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.authStateChanges();
  }

  //Sign In Anon
  Future<UserData> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _mapToUserData(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign In Email/Password
  Future<UserData> signInWithEmailAndPassword(AuthInfo authInfo) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: authInfo.email, password: authInfo.password);
      User user = result.user;

      return _mapToUserData(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register Email/Password
  Future<UserData> registerWithEmailAndPassword(AuthInfo authInfo) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: authInfo.email, password: authInfo.password);
      User user = result.user;

      return _mapToUserData(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  UserData _mapToUserData(User user) {
    return UserData(
        uid: user.uid,
        name: user.displayName,
        email: user.email,
        socialNetwork: "",
        interests: []);
  }

  //Sign Out
  Future signOut() async {
    try {
      await _auth.signOut();

      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
