import 'package:speed_meeting/locator.dart';
import 'package:speed_meeting/models/user.dart';
import 'package:speed_meeting/providers/user_provider.dart';
import 'package:speed_meeting/services/database.dart';

class UserService {
  //userprovider - dependency injection - using ioc containers to inject provider into this class
  final UserProvider _userProvider = locator<UserProvider>();

  //database service - dependency injection - using ioc containers to inject service into this class
  final DatabaseService _databaseService = locator<DatabaseService>();

  Future<void> updateUser(UserData userData, bool isNewUser) async {
    if(isNewUser){
      await _databaseService.saveUser(userData);
    }

    _userProvider.setUser(userData);

    return null;
  }

  clearUser(){
    _userProvider.setUser(null);

  }
}
