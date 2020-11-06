import 'package:flutter/material.dart';
import 'package:speed_meeting/services/auth.dart';
import 'package:speed_meeting/shared/constants.dart';
import 'package:speed_meeting/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";
  String name = "";
  double padd = 6.0;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('Register to Speed Meeting'),
        actions: <Widget>[
          FlatButton.icon(onPressed: () {
            widget.toggleView();
          }, icon: Icon(Icons.person), label: Text("Sign In"))
        ],
      ),
      body: Stack(
        children: [
          Container(
              alignment: Alignment.center,
              child: Image.asset(
                'images/fundo.png',
                fit: BoxFit.cover,
                width: 350,)
          ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 120.0, horizontal: 70.0),
        child: Form(
          key: _formKey,
          child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: [
          Column(
            children: <Widget>[
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Name"),
                validator: (val) => val.isEmpty ? "Enter your name" : null,
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
              ),
              SizedBox(height: 18.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                validator: (val) => val.isEmpty ? "Enter an email" : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 18.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                validator: (val) => val.length < 8 ? "Enter a password 8+ characters long" : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 18.0),

              Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                          "IOT",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                          "AI",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                          "Deep Learning",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                          )
                      ),
                    ),
                  ]
              ),
              Row(
                children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                      "Operative Systems",
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                      )
                  ),
                ),
              ]),


              RaisedButton(
                color: Colors.red,
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        error = "Error: Something went wrong. User registration failed.";
                        loading = false;
                      });
                    }
                  }
                },
              ),


              SizedBox(height: 10.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ]),
      ),
      )]),
    );
  }
}
