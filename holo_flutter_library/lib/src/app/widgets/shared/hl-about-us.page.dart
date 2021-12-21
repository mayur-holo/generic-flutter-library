/*
 * Created on Sat Feb 06 2021
 * Created by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

import 'package:holo_flutter_library/src/app/widgets/shared/hl-background.widget.dart';

class AboutUs extends StatelessWidget {
  final String aboutUsMessage;

  AboutUs(this.aboutUsMessage);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              // buildSvgPicture(size),
              SizedBox(height: size.height * 0.05),
              buildAboutUsText(),
            ],
          ),
        ),
      ),
    );
  }

  Text buildAboutUsText() {
    return Text(
      this.aboutUsMessage,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  // SvgPicture buildSvgPicture(Size size) {
  //   return SvgPicture.asset(
  //     "assets/icons/chat.svg",
  //     height: size.height * 0.45,
  //   );
  // }
}
