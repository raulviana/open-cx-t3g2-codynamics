import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:speed_meeting/models/user.dart';
import 'package:speed_meeting/services/database.dart';
import 'package:speed_meeting/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:speed_meeting/shared/loading.dart';

class EditProfile extends StatefulWidget {

  final Function toggleView;
  EditProfile({this.toggleView});

  @override
  _EditState createState() => _EditState();

}

class _EditState extends State<EditProfile> {

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email;
  String name;
  String socialNetwork;
  List<String> interests;
  String error = "";

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Speed Meeting'),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if(snapshot.hasData) {

              UserData userData = snapshot.data;

              return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData.name,
                      decoration: textInputDecoration.copyWith(hintText: "Name"),
                      validator: (val) => val.isEmpty ? "Enter your name" : null,
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      initialValue: userData.email,
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
                        if(_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              name ?? userData.name,
                              email ?? userData.email,
                              socialNetwork ?? userData.socialNetwork,
                              interests ?? userData.interests
                          );
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
              );
            } else {
              return Loading();
            }
          }
        ),
      ),
    );
  }
}
