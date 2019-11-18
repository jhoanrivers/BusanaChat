

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  final VoidCallback callback;
  final String text;
  final Color color;

  const CustomButton({Key key, this.callback, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Material(
        color: color,
        elevation: 6.0,
        textStyle: TextStyle(color: Colors.white),
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: callback,
          minWidth: 200,
          height: 45.0,
          child: Text(text),
        ),
      ),
    );

  }

}

