import 'package:get_it/get_it.dart';
import 'package:speed_meeting/providers/user_provider.dart';
import 'package:speed_meeting/services/auth_service.dart';
import 'package:speed_meeting/services/database_service.dart';
import 'package:speed_meeting/services/user_service.dart';

import 'services/meeting_service.dart';

//IOC container : functions like an app layer
//It is a sort of dictionary where:
//key is the type of object,
//value is a function that describes how to create that object
GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {
  //add all dependencies needed in the app, ONLY ONCE!!!!!
  //every time we call the locator, it will give this DataBaseService that was created only once
  locator.registerSingleton(UserProvider());
  locator.registerSingleton(DatabaseService());
  locator.registerSingleton(AuthService());
  locator.registerSingleton(UserService());
  locator.registerSingleton(MeetingService());
  return;
}
