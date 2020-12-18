import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:speed_meeting/locator.dart';
import 'package:speed_meeting/providers/user_provider.dart';
import 'package:speed_meeting/screens/home/create_event_page.dart';
import 'package:speed_meeting/screens/meeting/meeting.dart';
import 'package:speed_meeting/screens/profile/edit.dart';
import 'package:speed_meeting/screens/wrapper.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: locator<UserProvider>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes: <String, WidgetBuilder>{
          '/CreateEvent': (context) => Create_Event(),
          '/ParticipateEvent': (context) => Meeting(),
          '/EditProfile': (context) => EditProfile(),
        },
      ),
    );
  }
}
