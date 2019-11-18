import 'package:busana/src/home/home.dart';
import 'package:busana/src/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = "REGISTRATION";

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerUser() async {
    FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    )).user;
    Fluttertoast.showToast(
        msg: "Please log in with your current account",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black54,
        fontSize: 16.0
    );

    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                height: 200,
                width: 200,
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                  children: <Widget>[
                    new TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Email',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide()
                          )
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => email = value,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide()
                          )
                      ),
                      onChanged: (value) => password = value,
                    ),
                  ]
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child:  CustomButton(
                color: Colors.green,
                text: 'Register',
                callback: () async {
                  await registerUser();
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Already have account ',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 16, decoration: TextDecoration.underline),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  )
                ],
              ),
            )
          ],
        ),
    );
  }
}


