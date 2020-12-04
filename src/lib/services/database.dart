import 'package:cloud_firestore/cloud_firestore.dart';

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

}