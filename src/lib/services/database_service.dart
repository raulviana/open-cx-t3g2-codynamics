import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speed_meeting/models/meeting.dart';
import 'package:speed_meeting/models/user.dart';

class DatabaseService {
  // collection reference
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference _meetingsCollection =
      FirebaseFirestore.instance.collection("meetings");

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
      'start': meetingData.start,
      'users': meetingData.users,
      'leaders': meetingData.leaders,
    });
  }

  MeetingData readMeeting(String id) {
    // TODO: Read from database
    return new MeetingData();
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

  // Room sorting algorithm
  void assignRooms(String id) {
    MeetingData meeting = readMeeting(id);

    Map<String, List<List<String>>> leaders;
    // Initialize leaders list
    List<String> leaderIds = meeting.leaders;
    for (int i = 0; i < leaderIds.length; i++) {
      List<String> tags = findTags(leaderIds[i]);
      leaders[leaderIds[i]] = [tags, []];
    }

    Map<String, List<List<String>>> users;
    // Initialize normal users list
    List<String> userIds = meeting.users.keys;
    for (int i = 0; i < userIds.length; i++) {
      List<String> tags = findTags(userIds[i]);
      users[userIds[i]] = [tags, []];
    }

    // Calculate ration
    double realRatio = users.length / leaders.length;

    Map<String, List<String>> userPreferences;

    int similarity(String studentId, String professorId) {
      List<String> sTags = users[studentId][0];
      List<String> pTags = leaders[professorId][0];
      int count = 0;
      for (String tag in sTags) {
        if (pTags.indexOf(tag) != -1) count++;
      }
      return ((count / sTags.length) * 1000).round();
    }

    void engage(String studentId, String professorId) {
      users[studentId][1] = [professorId];
      leaders[professorId][1].add(studentId);
      leaders[professorId][1].sort((String a, String b) =>
          similarity(a, professorId) - similarity(b, professorId));
    }

    void freeStudent(String studentId) {
      List<String> auxProf = users[studentId][1];
      if (auxProf != []) {
        leaders[auxProf][1].remove(studentId);
        users[studentId][1] = [];
      }
    }

    bool hasSpaceForStudent(String professorId) {
      return leaders[professorId][1].length < realRatio;
    }

    String firstFreeStudent() {
      for (String userId in users.keys) {
        if (users[userId][1] == [] && userPreferences[userId].length > 0)
          return userId;
      }
      return null;
    }

    List<String> leaderKeys = leaders.keys;
    for (String userId in users.keys) {
      leaderKeys.sort((String a, String b) =>
          similarity(userId, a) - similarity(userId, b));
      userPreferences[userId] = List.from(leaderKeys);
    }

    while (true) {
      String student = firstFreeStudent();
      if (student == null) break;
      String professor = userPreferences[student][-1];

      if (hasSpaceForStudent(professor)) {
        engage(student, professor);
      } else {
        String lastStudent = leaders[professor][1][-1];
        if (similarity(student, professor) >
            similarity(lastStudent, professor)) {
          freeStudent(lastStudent);
          engage(student, professor);
        }
      }
      userPreferences[student].removeLast();
    }

    // TODO: write on database
    for (String room in leaders.keys) {
      List<String> users = leaders[room][1];
      for (String user in users) {
        meeting.users[user] = room;
      }
    }
  }
}
