import 'package:firebase_auth/firebase_auth.dart';
import 'package:speed_meeting/locator.dart';
import 'package:speed_meeting/models/user.dart';
import 'package:speed_meeting/services/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = locator<UserService>();

  Stream<User> get user {
    return _auth.authStateChanges();
  }

  //Sign In Anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      _updateUser(user, false);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign In Email/Password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      _updateUser(user, false);

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register Email/Password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      _updateUser(user, true);

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void _updateUser(User user, bool isNewUser) {
    UserData userData = UserData(
        uid: user.uid,
        name: user.displayName,
        email: user.email,
        socialNetwork: "",
        interests: []);

    _userService.updateUser(userData, isNewUser);
  }

  //Sign Out
  Future signOut() async {
    try {
      await _auth.signOut();
      _userService.clearUser();

      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
