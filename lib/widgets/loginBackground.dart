import 'package:flutter/material.dart';

import 'loginBody.dart';

class LoginBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Image.asset(
              'assets/images/loguptri.png',
              width: size.width,
            ),
          ),
          Positioned(
            top: size.height - 112,
            child: Image.asset(
              'assets/images/logdowntri.png',
              width: size.width,
            ),
          ),
          LoginBody(),
        ],
      ),
    );
  }
}
