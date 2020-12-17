import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';
import 'package:provider/provider.dart';
import 'package:speed_meeting/models/meeting.dart';
import 'package:speed_meeting/models/user.dart';
import 'package:speed_meeting/providers/user_provider.dart';
import 'package:speed_meeting/services/database_service.dart';
import 'package:speed_meeting/services/meeting_service.dart';

class Meeting extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Meeting> {
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "plugintestroom");
  final subjectText = TextEditingController(text: "My Plugin Test Meeting");
  final nameText = TextEditingController();
  bool leader = false;
  final emailText = TextEditingController();
  var isAudioOnly = true;
  var isAudioMuted = true;
  var isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    emailText.text = user.email;
    nameText.text = user.name?.isNotEmpty == true ? user.name : user.email;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red,
            elevation: 0.0,
            title: Text('Join SpeedMeeting')),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                  controller: serverText,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Server URL",
                      hintText: "Hint: Leave empty for meet.jitsi.si"),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: roomText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Room",
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 16.0,
                ),
                CheckboxListTile(
                  title: Text("Audio Only"),
                  value: isAudioOnly,
                  onChanged: _onAudioOnlyChanged,
                ),
                SizedBox(
                  height: 16.0,
                ),
                CheckboxListTile(
                  title: Text("Audio Muted"),
                  value: isAudioMuted,
                  onChanged: _onAudioMutedChanged,
                ),
                SizedBox(
                  height: 16.0,
                ),
                CheckboxListTile(
                  title: Text("Video Muted"),
                  value: isVideoMuted,
                  onChanged: _onVideoMutedChanged,
                ),
                Divider(
                  height: 48.0,
                  thickness: 2.0,
                ),
                SizedBox(
                  height: 32.0,
                  width: double.maxFinite,
                  child: RaisedButton(
                    onPressed: () {
                      _joinAsUser(user);
                    },
                    child: Text(
                      "Join Meeting",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                SizedBox(
                  height: 32.0,
                  width: double.maxFinite,
                  child: RaisedButton(
                    onPressed: () {
                      _joinAsLeader(user);
                    },
                    child: Text(
                      "Join as Leader",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                SizedBox(
                  height: 32.0,
                  width: double.maxFinite,
                  child: RaisedButton(
                    onPressed: () {
                      _startMeeting(user);
                    },
                    child: Text(
                      "Start meeting",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onAudioOnlyChanged(bool value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _startMeeting(UserData user) async {
    String roomId;
    DatabaseService db = new DatabaseService();
    MeetingData meeting = await db.readMeeting(roomText.text);
    if (meeting == null) {
      debugPrint("Meeting does not exist");
      return;
    }

    if (meeting.owner != user.uid) {
      debugPrint("Room not yours!");
    }

    db.addToLeaders(user.uid.toString(), meeting.uid);
    debugPrint("Hello, owner. Calculating rooms");
    MeetingService ms = new MeetingService();
    ms.assignRooms(roomText.text);

    debugPrint("Entering your room");
    roomId = meeting.uid + "-" + user.uid.toString();
    //_joinMeeting(roomId);
  }

  _joinAsLeader(UserData user) async {
    DatabaseService db = new DatabaseService();
    MeetingData meeting = await db.readMeeting(roomText.text);
    if (meeting == null) {
      debugPrint("Meeting does not exist");
      return;
    }

    db.addToLeaders(user.uid.toString(), meeting.uid);

    debugPrint("Entering your room");
    _joinMeeting(meeting.uid + "-" + user.uid.toString());
  }

  _joinAsUser(UserData user) async {
    String roomId;
    DatabaseService db = new DatabaseService();
    MeetingData meeting = await db.readMeeting(roomText.text);
    if (meeting == null) {
      debugPrint("Meeting does not exist");
      return;
    }

    // Join waiting queue
    db.addToWaiting(user.uid.toString(), meeting.uid);
    debugPrint("Waiting for owner to start");

    // When a room is assigned for the user, that is their room
    do {
      sleep(Duration(seconds: 1));
      roomId = await db.getRoom(user.uid, meeting.uid);
    } while (roomId == "");

    debugPrint("Done. " + user.uid + ", your room is " + roomId);
    _joinMeeting(meeting.uid + "-" + roomId);
  }

  _joinMeeting(String roomToConnect) async {
    String serverUrl =
        serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;

    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      };

      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      // Define meetings options here
      var options = JitsiMeetingOptions()
        ..room = roomToConnect
        ..serverURL = serverUrl
        ..subject = subjectText.text
        ..userDisplayName = nameText.text
        ..userEmail = emailText.text
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags.addAll(featureFlags);

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          debugPrint("${options.room} terminated with message: $message");
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        //roomNameConstraints: customContraints, // to use your own constraint(s)
      );
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  static final Map<RoomNameConstraintType, RoomNameConstraint>
      customContraints = {
    RoomNameConstraintType.MAX_LENGTH: new RoomNameConstraint((value) {
      return value.trim().length <= 50;
    }, "Maximum room name length should be 30."),
    RoomNameConstraintType.FORBIDDEN_CHARS: new RoomNameConstraint((value) {
      return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false)
              .hasMatch(value) ==
          false;
    }, "Currencies characters aren't allowed in room names."),
  };

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
