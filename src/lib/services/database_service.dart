import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:speed_meeting/models/meeting.dart';
import 'package:speed_meeting/models/user.dart';

class DatabaseService {
  // collection reference
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference _meetingsCollection =
      FirebaseFirestore.instance.collection("meeting");

  Future saveUser(UserData userData) async {
    //String name, String email, String socialNetwork, List<String> interests
    return await _usersCollection.doc(userData.uid).set({
      'name': userData.name,
      'email': userData.email,
      'socialNetwork': userData.socialNetwork,
      'interests': userData.interests,
    });
  }

  Future saveMeeting(MeetingData meetingData) async {
    return await _meetingsCollection.doc(meetingData.uid).set({
      'name': meetingData.name,
      'duration': meetingData.duration,
      'owner': meetingData.owner,
      'start': meetingData.start,
      'waiters': meetingData.users,
      'leaders': meetingData.leaders,
    });
  }

  Future<MeetingData> readMeeting(String id) async {
    MeetingData result;
    await _meetingsCollection.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            if (doc["name"] == id) {
              debugPrint("Found: " + id);
              result = MeetingData(
                  uid: doc.id,
                  duration: doc["duration"],
                  name: doc["name"].toString(),
                  start: doc["start"],
                  users: Map.from(doc["waiters"]),
                  leaders: List.from(doc["leaders"]),
                  owner: doc["owner"].toString());
            }
          })
        });
    return result;
  }

  Future addToLeaders(String user, String meeting) async {
    await _meetingsCollection.get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        if (doc.id == meeting) {
          debugPrint("Found: " + meeting);
          List<String> aux = List.from(doc["leaders"]);
          aux.add(user);
          doc.reference.update(<String, dynamic>{"leaders": aux});
        }
      })
    });
  }

  Future addToWaiting(String user, String meeting) async {
    await _meetingsCollection.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            if (doc.id == meeting) {
              debugPrint("Found: " + meeting);
              Map<String, String> aux = Map.from(doc["waiters"]);
              aux[user] = "";
              doc.reference.update(<String, dynamic>{"waiters": aux});
            }
          })
        });
  }

  void changeWaiters(MeetingData data) async {
    for (String user in data.users.keys) {
      debugPrint(user + " goes to room " + data.users[user]);
    }

    await _meetingsCollection.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            if (doc.id == data.uid) {
              debugPrint("Found: " + data.uid);
              doc.reference.update(<String, dynamic>{"waiters": data.users});
            }
          })
        });
  }

  Future<List<String>> findTags(String userID) async {
    /*List<String> result;
    await _usersCollection.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            if (doc.id == userID) {
              debugPrint("Found: " + userID);
              result = List.from(doc["interests"]);
            }
          })
        });*/
    return ["a", "b"];
  }
}
