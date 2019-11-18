
import 'package:busana/src/view.dart';
import 'package:flutter/material.dart';


class IntroPage extends StatefulWidget {
  static const String id= "INTRO";
  @override
  _IntroPageState createState() => _IntroPageState();
}


class _IntroPageState extends State<IntroPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  width: 60.0,
                  child: Image.asset('assets/logo.png'),
                ),
              ),
              Text(
                'Busana Chat',
                style: TextStyle(
                    fontSize: 30.0
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          CustomButton(
            text: 'Log in',
            color: Colors.green,
            callback: (){
              Navigator.of(context).pushNamed(LoginPage.id);
            },
          ),
          CustomButton(
            text: 'Register',
            color: Colors.blueGrey,
            callback: (){
              Navigator.of(context).pushNamed(RegistrationPage.id);
            },
          )
        ],
      ),
    );
  }


}



