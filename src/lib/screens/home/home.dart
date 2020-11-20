import 'package:flutter/material.dart';
import 'package:speed_meeting/screens/home/create_event_page.dart';
import 'package:speed_meeting/screens/meeting/meeting.dart';
import 'package:speed_meeting/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  void _navigateToParticipate(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Meeting()));
  }

  void _navigateToCreateEvent(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Create_Event()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Speed Meeting'),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Logout"),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new ListView(
            children: <Widget>[
              Image(
                image: AssetImage("images/speed_meeting.jpeg"),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: new ElevatedButton(
                      child: Text(
                        "Create an Event",
                        textAlign: TextAlign.center,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.red),
                        foregroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.black),
                      ),
                  onPressed: (){_navigateToCreateEvent(context);},)),
              new ElevatedButton(
                child: Text(
                  "Participate in an Event",
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.resolveWith((states) => Colors.red),
                  foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.black),
                ),
                onPressed:(){_navigateToParticipate(context);},
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new ElevatedButton(
                      child: Text(
                        "Edit Profile",
                        textAlign: TextAlign.center,
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.red),
                          foregroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.black)),
                    ),
                    new ElevatedButton(
                      child: Text(
                        "Edit Event",
                        textAlign: TextAlign.center,
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.red),
                          foregroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.black)),
                    )
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
