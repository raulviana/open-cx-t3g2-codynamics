import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.authStateChanges();
  }

  //Sign In Anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //Sign In Email/Password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user;
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  //Register Email/Password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e)
    {
      print(e.toString());
      return null;
    }
  }

}