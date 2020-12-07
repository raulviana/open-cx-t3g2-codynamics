import 'package:flutter/cupertino.dart';
import 'package:speed_meeting/models/user.dart';

class UserProvider extends ChangeNotifier {
  //private user
  UserData _user;
  //public getter
  UserData get user => _user;
  //public setter with a notify in it, 
  //everytime it is called, any observer will be notified
  void setUser(UserData user) {
    this._user = user;
    notifyListeners();
  }
}
