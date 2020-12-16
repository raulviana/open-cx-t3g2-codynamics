import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speed_meeting/locator.dart';
import 'package:speed_meeting/models/user.dart';
import 'package:speed_meeting/providers/user_provider.dart';
import 'package:speed_meeting/services/user_service.dart';
import 'package:speed_meeting/shared/constants.dart';

class EditProfile extends StatefulWidget {
  final Function toggleView;

  EditProfile({this.toggleView});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<EditProfile> {
  //locator will give the one DatabaseService defined in the locator.dart file
  final UserService _userService = locator<UserService>();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool _ai_tag = false;
  bool _wb_tag = false;
  bool _cs_tag = false;
  bool _nw_tag = false;

  String email;
  String name;
  String socialNetwork;
  List<String> _interests = new List<String>();
  String error = "";


  void changedCheckbox(bool newValue,String t){
    if(newValue)
      _interests.add(t);
    else{
      _interests.remove(t);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    _interests = user.interests?? null;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Speed Meeting'),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                initialValue: user.name,
                decoration: textInputDecoration.copyWith(hintText: "Name"),
                validator: (val) => val.isEmpty ? "Enter your name" : null,
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                initialValue: user.email,
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                validator: (val) => val.isEmpty ? "Enter your email" : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),CheckboxListTile(title: Text("AI") ,value: user.interests.contains("AI")?true:_ai_tag, onChanged: (val){
                setState(() {
                  if(val!=_ai_tag)
                  _ai_tag = !_ai_tag;
                  changedCheckbox(_ai_tag, "AI");
                  print(_interests);
                });

              })
              ,
              CheckboxListTile(title: Text("Networks") ,value: user.interests.contains("Networks")?true:_nw_tag, onChanged: (val){
                setState(() {
                  if(val!=_nw_tag)
                  _nw_tag = !_nw_tag;
                  changedCheckbox(_nw_tag, "Networks");
                  print(_interests);
                });

              })
              ,
              CheckboxListTile(title: Text("Web") ,value: user.interests.contains("Web")?true:_wb_tag, onChanged: (val){
                setState(() {
                  if(val!=_wb_tag)
                  _wb_tag = !_wb_tag;
                  changedCheckbox(_wb_tag, "Web");
                  print(_interests);
                });

              })
              ,
              CheckboxListTile(title: Text("Cybersecurity") ,value: user.interests.contains("Cybersecurity")?true:_cs_tag, onChanged: (val){
                setState(() {
                  if(val!=_cs_tag)
                  _cs_tag = !_cs_tag;
                  changedCheckbox(_cs_tag, "Cybersecurity");
                  print(_interests);
                });

              })
              ,
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.red,
                child: Text(
                  "Update",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await _userService.updateUser(
                        new UserData(
                            uid: user.uid,
                            name: name ?? user.name,
                            email: email ?? user.email,
                            socialNetwork: socialNetwork ?? user.socialNetwork,
                            interests: _interests ?? user.interests),
                        false);
                    Navigator.pop(context);
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}