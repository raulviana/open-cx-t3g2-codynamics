import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speed_meeting/screens/authenticate/authenticate.dart';
import 'package:speed_meeting/screens/home/create_event_page.dart';
import 'package:speed_meeting/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user == null) {
      return Authenticate();
    }
    else {
      return Create_Event();
    }
  }
}
