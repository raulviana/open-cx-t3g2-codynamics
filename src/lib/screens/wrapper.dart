import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speed_meeting/providers/user_provider.dart';
import 'package:speed_meeting/screens/authenticate/authenticate.dart';
import 'package:speed_meeting/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context).user;

    if(user == null) {
      return Authenticate();
    }
    else {
      return Home();
    }
  }
}
