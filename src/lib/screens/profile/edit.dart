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

  String email;
  String name;
  String socialNetwork;
  List<String> interests;
  String error = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

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
              ),
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
                        UserData(
                            uid: user.uid,
                            name: name ?? user.name,
                            email: email ?? user.email,
                            socialNetwork: socialNetwork ?? user.socialNetwork,
                            interests: interests ?? user.interests),
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
