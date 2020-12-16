import 'package:flutter/material.dart';
import 'package:speed_meeting/locator.dart';
import 'package:speed_meeting/services/auth_service.dart';
import 'package:speed_meeting/services/user_service.dart';
import '../../models/event.dart';
import '../../utils/utils.dart';


// ignore: camel_case_types
class Create_Event extends StatelessWidget {

  final UserService _userService = locator<UserService>();
  String _event_name = "",_event_hour="",_event_date="",_event_dur="",_event_rounds="",_event_a="",_event_b="",_event_ratio="";
  EventData event;
  void CreateEvent(){
    //EventData({this.name, this.hour, this.date, this.duration, this.rounds, this.p_a, this.p_b, this.ratio});
    event = new EventData(_event_name,_event_hour,_event_date,_event_dur,_event_rounds,_event_a,_event_b,_event_ratio);
  }

  String Validate(){
    return "message";
  }


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
              await _userService.signOut();
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
          child: new ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 10),
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
                  onChanged: (val) {
                    _event_name=val;print(_event_name);
                  },
                  ),

                  ),       //Event Name Input
              Text(
                "Date",
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 20),
              ),          // Date
              Padding(
                  padding : EdgeInsets.only(left : 50,right: 50),
                  child : TextFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.grey,
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
                        hintText: 'Enter Date(MM-DD-YY)'
                    ),
                    onChanged: (val) {
                      _event_date=val;print(_event_date);print(matchDate(val));
                    },

                  ),

              ),       //Date input
              Text(
                "Hour",
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                  padding : EdgeInsets.only(left : 50,right: 50,bottom: MediaQuery.of(context).viewInsets.bottom),
                  child : TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.grey,
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
                        hintText: 'Enter Hour(24h Format)'
                    ),
                    enableInteractiveSelection: false,
                    onChanged: (val) {
                      _event_hour=val;print(_event_hour);
                    },
                  ),
              ),
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
                      "Duration(minutes)",
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
                            onChanged: (val) {
                              _event_dur=val;print(_event_dur);
                            },
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
                            onChanged: (val) {
                              _event_rounds=val;print(_event_rounds);
                            },
                          )),),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Participant A(#)",
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      "Participant B(#)",
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
                            onChanged: (val) {
                              _event_a=val;print(_event_a);
                            },
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
                            onChanged: (val) {
                              _event_b=val;print(_event_b);
                            },
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
                            onChanged: (val) {
                              _event_ratio=val;print(_event_ratio);
                            },
                          )),)]
              ),
              Padding(padding: EdgeInsets.only(top : 10),child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      height: 20,
                      child: Padding(
                          padding : EdgeInsets.only(top : 0),
                          child : new ElevatedButton(
                            child: Text(
                              "Create",
                              textAlign: TextAlign.center,
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith(
                                      (states) => Colors.red),
                              foregroundColor: MaterialStateProperty.resolveWith(
                                      (states) => Colors.black),
                            ),
                            onPressed:(){CreateEvent();event.display();},
                          ),))]
              )),
            ],
          ),
        ),
      ),
    );
  }
}