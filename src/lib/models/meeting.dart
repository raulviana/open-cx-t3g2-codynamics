class MeetingData {
  final String uid;
  final String name;
  final int duration;
  final DateTime start;
  Map<String, String> users;
  List<String> leaders;

  MeetingData({this.uid, this.duration, this.name, this.start, this.users, this.leaders});
}
