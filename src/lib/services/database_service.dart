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
      'owner' : meetingData.owner,
      'start': meetingData.start,
      'users': meetingData.users,
      'leaders': meetingData.leaders,
    });
  }

  MeetingData readMeeting(String id) {
    MeetingData result;
    _meetingsCollection.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            if (doc["name"] == id) {
              result = MeetingData(
                  uid: doc.id,
                  duration: doc["duration"],
                  name: doc["name"],
                  start: doc["start"],
                  users: Map.from(doc["waiters"]),
                  leaders: List.from(doc["leaders"]),
                  owner: doc["owner"]);
            }
          })
        });
    return result;
  }

  Future addToWaiting(String user, String id) {
    MeetingData meeting = readMeeting(id);
    meeting.users[user] = "";
    // TODO: Save to database
  }

  List<String> findTags(String userID) {
    // TODO: find tags on the database
    return ["a", "b"];
  }
}
