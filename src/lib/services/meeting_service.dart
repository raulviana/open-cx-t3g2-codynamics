import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:speed_meeting/locator.dart';
import 'package:speed_meeting/models/meeting.dart';
import 'package:speed_meeting/services/database_service.dart';

import '../models/meeting.dart';
import '../models/meeting.dart';
import '../models/meeting.dart';

class MeetingService {
  //database service - dependency injection - using ioc containers to inject service into this class
  final DatabaseService _databaseService = locator<DatabaseService>();

  Future<MeetingData> enterMeeting(String userId, String roomId) {
    _databaseService.addToWaiting(userId, roomId);
  }

  Future<String> getRoom(String userId, String roomId) async {
    return (await _databaseService.readMeeting(roomId)).users[userId];
  }

  // Room sorting algorithm
  void assignRooms(String id) async {
    MeetingData meeting = await _databaseService.readMeeting(id);

    Map<String, List<List<String>>> leaders =
        new Map<String, List<List<String>>>();
    // Initialize leaders list
    List<String> leaderIds = meeting.leaders;
    for (int i = 0; i < leaderIds.length; i++) {
      List<String> tags = await _databaseService.findTags(leaderIds[i]);
      leaders[leaderIds[i]] = [tags, []];
    }

    Map<String, List<List<String>>> users =
        new Map<String, List<List<String>>>();
    // Initialize normal users list
    List<String> userIds = List.from(meeting.users.keys);
    for (int i = 0; i < userIds.length; i++) {
      List<String> tags = await _databaseService.findTags(userIds[i]);
      users[userIds[i]] = [tags, [""]];
    }

    // Calculate ration
    double realRatio = users.length / leaders.length;

    Map<String, List<String>> userPreferences = new Map<String, List<String>>();

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
      debugPrint("engaged " + studentId + " and " + professorId);
      users[studentId][1][0] = professorId;
      leaders[professorId][1].add(studentId);
      leaders[professorId][1].sort((String a, String b) =>
          similarity(a, professorId) - similarity(b, professorId));
    }

    void freeStudent(String studentId) {
      String auxProf = users[studentId][1][0];
      if (auxProf != "") {
        leaders[auxProf][1].remove(studentId);
        users[studentId][1][0] = "";
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

    List<String> leaderKeys = List.from(leaders.keys);
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

    for (String user in users.keys) {
      debugPrint(user + ":" + users[user][1][0]);
    }

    // TODO: write on database
    /*for (String room in leaders.keys) {
      List<String> users = leaders[room][1];
      for (String user in users) {
        debugPrint(user + ": " + room);
        meeting.users[user] = room;
      }
    }*/

    _databaseService.changeWaiters(meeting);
  }

  void AddMeeting(MeetingData d) {
    _databaseService.saveMeeting(d);
  }
}

MeetingData CreateMeeting(
    String owner_id, String name, int duration, Timestamp date) {
  List<String> leader = new List();
  Map<String, String> user = new Map();
  return MeetingData(
      duration: duration,
      start: date,
      leaders: leader,
      owner: owner_id,
      users: user,
      name: name);
}
