/*
 * Created on Tue Dec 09 2020
 * Created by - 2: Sachin Sehgal
 * Updated by - 1: Chaman Mandal
 * Updated by - 3: Mayur Ranjan
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */

import 'package:holo_flutter_library/src/app/widgets/core/hl-button.widget.dart';

import 'package:holo_flutter_library/src/app/widgets/core/hl-text-field.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'background.widget.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

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

  HLTextField buildEmailField() {
    return HLTextField(
      TextFieldType.Others,
      inputFieldController: null,
      icon: Icons.person,
      labelText: "Email",
      hintText: "Email/Phone number",
      editable: _isEditable,
    );
  }

  HLTextField buildOTPField() {
    return HLTextField(
      TextFieldType.Others,
      inputFieldController: null,
      icon: Icons.person,
      labelText: "OTP",
      hintText: "OTP",
    );
  }

  HLButton buildConfirmWidget() {
    return HLButton(
      text: "Forgot Password",
      onPressed: () {
        setState(() {
          isVisible = true;
          _isEditable = false;
        });
      },
    );
  }

  HLButton buildResendWidget() {
    return HLButton(
      text: "Resend ",
      onPressed: () {
        setState(() {
          // isvisible = true;
        });
      },
    );
  }

  // HLTextField buildMessageField() {
  //   return HLTextField(
  //     TextFieldType.Description,
  //     labelText: "Messages",
  //     hintText:
  //         "New password generation link has been sent to you please open the link from mobile/email.",
  //     inputFieldController: null,
  //     textInputAction: TextInputAction.done,
  //     maxLines: 4,
  //   );
  // }

  HLButton buildSubmitWidget() {
    return HLButton(
      text: "Submit",
      onPressed: () => null,
    );
  }
}
