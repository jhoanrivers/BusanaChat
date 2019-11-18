

import 'package:busana/src/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String id = "LOGIN";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String email;
  String password;


  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser() async {

    FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    )).user;
    setState(() {
      Navigator.pop(context);
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeApp(user : user)));
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
                  TextFormField(
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
              text: 'Login',
              callback: () async {
                await loginUser();
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  child: Text(
                    'Create new Account',
                    style: TextStyle(
                        fontSize: 16, decoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RegistrationPage()));
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
