import 'package:cloud_firestore/cloud_firestore.dart';

class MeetingData {
  final String uid;
  final String name;
  final int duration;
  final Timestamp start;
  Map<String, String> users;
  List<String> leaders;
  final String owner;
  MeetingData({this.uid, this.duration, this.name, this.start, this.users, this.leaders, this.owner});
}
