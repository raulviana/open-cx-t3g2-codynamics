import 'package:speed_meeting/locator.dart';
import 'package:speed_meeting/models/auth_info.dart';
import 'package:speed_meeting/models/user.dart';
import 'package:speed_meeting/providers/user_provider.dart';
import 'package:speed_meeting/services/auth_service.dart';
import 'package:speed_meeting/services/database_service.dart';

class UserService {
  //userprovider - dependency injection - using ioc containers to inject provider into this class
  final UserProvider _userProvider = locator<UserProvider>();

  //database service - dependency injection - using ioc containers to inject service into this class
  final DatabaseService _databaseService = locator<DatabaseService>();

  //Access to AuthService
  final AuthService _authService = locator<AuthService>();

  Future<void> updateUser(UserData userData, bool isNewUser) async {
      await _databaseService.saveUser(userData);
        _userProvider.setUser(userData);


    return null;
  }

  Future<void> registerUser(UserData userData, bool isNewUser) async {
    if (isNewUser) {
      await _databaseService.saveUser(userData);
    }

    _userProvider.setUser(userData);

    return null;
  }


  Future<UserData> signIn({AuthInfo authInfo}) async {
    UserData user;
    if (authInfo == null) {
      user = await _authService.signInAnon();
    } else {
      user = await _authService.signInWithEmailAndPassword(authInfo);
    }

    await _userProvider.setUser(user);
    return user;
  }

  Future<UserData> register(AuthInfo authInfo) async {
    var user = await _authService.registerWithEmailAndPassword(authInfo);

    if(user != null)
      await registerUser(user, true);
    else
      await registerUser(user, false);

    return user;
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _userProvider.setUser(null);
  }
}