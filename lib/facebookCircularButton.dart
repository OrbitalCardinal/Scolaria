import 'package:flutter/material.dart';

import 'facebook_icon.dart';

class FacebookCircularButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width/7,
      child: RaisedButton(
        color: Colors.blue,
        child: Icon(FacebookIcon.facebook, size: 24, color: Colors.white,),
        shape: CircleBorder(),
        onPressed: () {
          print("google");
        },
      ),
    );
  }
}