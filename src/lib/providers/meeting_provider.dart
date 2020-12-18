import 'package:flutter/cupertino.dart';
import 'package:speed_meeting/models/meeting.dart';

class MeetingProvider extends ChangeNotifier {
  //private meeting
  MeetingData _meeting;

  //public getter
  MeetingData get meeting => _meeting;

  //public setter with a notify in it,
  //everytime it is called, any observer will be notified
  void setMeeting(MeetingData meeting) {
    this._meeting = meeting;
    notifyListeners();
  }
}
