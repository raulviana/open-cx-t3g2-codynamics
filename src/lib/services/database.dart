import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speed_meeting/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection("users");

  Future updateUserData(String name, String email, String socialNetwork, List<String> interests) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'email': email,
      'socialNetwork': socialNetwork,
      'interests': interests,
    });
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      socialNetwork: snapshot.data()['socialNetwork']
      //interests: snapshot.data()['interests']
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}