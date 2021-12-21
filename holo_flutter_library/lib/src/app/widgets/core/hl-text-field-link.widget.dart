/*
 * Created on Sun Feb 14 2021
 * Created by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */

import 'package:flutter/material.dart';
import 'package:holo_flutter_library/src/app/constants/palette.constant.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool loginScreen;
  final Function()? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.loginScreen = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          loginScreen
              ? "Don’t have an Account ? "
              : "Already have an Account ? ",
          style: const TextStyle(color: Palette.hlPrimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            loginScreen ? "Sign Up" : "Sign In",
            style: const TextStyle(
              color: Palette.hlPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
