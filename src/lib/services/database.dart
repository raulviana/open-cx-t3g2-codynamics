import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speed_meeting/models/user.dart';

class DatabaseService {
  // collection reference
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection("users");

  Future updateUserData(UserData userData) async {
    //String name, String email, String socialNetwork, List<String> interests
    return await _usersCollection.doc(userData.uid).set({
      'name': userData.name,
      'email': userData.email,
      'socialNetwork': userData.socialNetwork,
      'interests': userData.interests,
    });
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: snapshot.data()['uid'],
        name: snapshot.data()['name'],
        email: snapshot.data()['email'],
        socialNetwork: snapshot.data()['socialNetwork']
        //interests: snapshot.data()['interests']
        );
  }

  // get user doc stream
  Stream<UserData> userData(String uid) {
    return _usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
