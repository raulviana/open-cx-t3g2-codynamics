import 'dart:async';
import '../lib/screens/authenticate/authenticate.dart';
import '../lib/screens/authenticate/sign_in.dart';
import '../lib//screens/home/home.dart';
import 'package:flutter/material.dart';


import 'package:speed_meeting/locator.dart';


import 'package:firebase_core/firebase_core.dart';
import '../lib/main.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() async{
  // This line enables the extension
  enableFlutterDriverExtension();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setUpLocator();
  // Call the `main()` function of your app or call `runApp` with any widget you
  // are interested in testing.
  runApp(MyApp());
}