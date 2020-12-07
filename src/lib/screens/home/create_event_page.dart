import 'package:flutter/material.dart';
import 'package:speed_meeting/locator.dart';
import 'package:speed_meeting/services/auth.dart';

// ignore: camel_case_types
class Create_Event extends StatelessWidget {

  final AuthService _auth = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Create Event'),
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/create_event.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: new EdgeInsets.only(top: 100.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Event Name",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(fontSize: 20),
                  )),       //Event Name
              Padding(
                  padding : EdgeInsets.only(left : 50,right: 50),
                  child : TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.grey,
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
                        hintText: 'Enter the Event Name'
                    ),
                  )),       //Event Name Input
              Text(
                "Date",
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 20),
              ),          // Date
              Padding(
                  padding : EdgeInsets.only(left : 50,right: 50),
                  child : TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.grey,
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
                        hintText: 'Enter Date'
                    ),
                  )),       //Date input
              Text(
                "Hour",
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                  padding : EdgeInsets.only(left : 50,right: 50),
                  child : TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.grey,
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
                        hintText: 'Enter Hour'
                    ),
                  )),
              Text(
                "Meetings",
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 30),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Duration",
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      "Nº of Rounds",
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 15),
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                      height: 20,
                      child: Padding(
                          padding : EdgeInsets.only(left : 0,right: 0),
                          child : TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              fillColor: Colors.grey,
                              filled: true,
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                            ),
                          )),),

                    SizedBox(
                      width: 50,
                      height: 20,
                      child: Padding(
                          padding : EdgeInsets.only(left : 0,right: 0),
                          child : TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              fillColor: Colors.grey,
                              filled: true,
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                            ),
                          )),),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Participant A",
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      "Participant B",
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 15),
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                      height: 20,
                      child: Padding(
                          padding : EdgeInsets.only(left : 0,right: 0),
                          child : TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey,
                              filled: true,
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                            ),
                          )),),

                    SizedBox(
                      width: 50,
                      height: 20,
                      child: Padding(
                          padding : EdgeInsets.only(left : 0,right: 0),
                          child : TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey,
                              filled: true,
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                            ),
                          )),),
                  ]),
              Text(
                "Participant Ratio (A:B)",
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 15),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      height: 20,
                      child: Padding(
                          padding : EdgeInsets.only(left : 0,right: 0),
                          child : TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey,
                              filled: true,
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                            ),
                          )),)]
              ),
            ],
          ),
        ),
      ),
    );
  }
}