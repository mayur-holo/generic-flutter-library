/*
 * Created on Tue Dec 09 2020
 * Created by - 2: Sachin Sehgal
 * Updated by - 1: Chaman Mandal
 * Updated by - 3: Mayur Ranjan
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */

import 'package:holo_flutter_library/src/app/widgets/core/my-button.widget.dart';

import 'package:holo_flutter_library/src/app/widgets/core/my-text-field.widget.dart';
import 'package:flutter/material.dart';

import 'background.widget.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  bool isVisible = false;
  bool _isEditable = true;
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildEmailField(),
            isVisible == false ? buildConfirmWidget() : Container(),
            isVisible == true ? buildOTPField() : Container(),
            isVisible == true ? buildResendWidget() : Container(),
            // HlDivider('MESSAGES'),
            // buildMessageField(),
            const SizedBox(height: 50),
            isVisible == true ? buildSubmitWidget() : Container(),
          ],
        ),
      ),
    );
  }

  MyTextField buildEmailField() {
    return MyTextField(
      MyTextFieldType.Others,
      inputFieldController: null,
      icon: Icons.person,
      labelText: "Email",
      hintText: "Email/Phone number",
      editable: _isEditable,
    );
  }

  MyTextField buildOTPField() {
    return MyTextField(
      MyTextFieldType.Others,
      inputFieldController: null,
      icon: Icons.person,
      labelText: "OTP",
      hintText: "OTP",
    );
  }

  MyButton buildConfirmWidget() {
    return MyButton(
      text: "Forgot Password",
      onPressed: () {
        setState(() {
          isVisible = true;
          _isEditable = false;
        });
      },
    );
  }

  MyButton buildResendWidget() {
    return MyButton(
      text: "Resend ",
      onPressed: () {
        setState(() {});
      },
    );
  }

  MyButton buildSubmitWidget() {
    return MyButton(
      text: "Submit",
      onPressed: () => null,
    );
  }
}
