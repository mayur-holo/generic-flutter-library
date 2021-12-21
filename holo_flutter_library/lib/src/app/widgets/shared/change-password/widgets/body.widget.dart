/*
 * Created on Tue Dec 09 2020
 * Created by - 2: Sachin Sehgal
 * Updated by - 1: Chaman Mandal
 * Updated by - 3: Mayur Ranjan
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:holo_flutter_library/src/app/constants/palette.constant.dart';
import 'package:holo_flutter_library/src/app/utils/encrypt-password.util.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-button.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-editing-controller.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-text-field.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/change-password/blocs/change-password.bloc.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/hl-dialog-box.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/login/login.page.dart';
import 'package:holo_flutter_library/src/change_password.dart';
import 'package:holo_flutter_library/src/config/flavor.config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  final MyEditingController _currentPasswordController = MyEditingController();
  final MyEditingController _newPasswordController = MyEditingController();
  final MyEditingController _confirmPasswordController = MyEditingController();

  LogOutApi apiCall = new LogOutApi();

  // bool _formSubmitted = false;
  bool _circularProgressIndicatorVisible = false;

  _loginAPICall() async {
    setState(() {
      _circularProgressIndicatorVisible = true;
    });

    // SERVER LOGIN API URL
    var uri = Uri.https(FlavorConfig.instance.values.baseUrl,
        FlavorValues.baseApiPath + '/auth/login');

    var _encryptedPassword = getEncryptedPassword(_newPasswordController.text);

    // Store all data with Param Name.
    Map<String, dynamic> data = {
      "email": _currentPasswordController.text,
      "mobile": _currentPasswordController.text,
      "password": _encryptedPassword,
    };

    // Starting Web API Call.
    var response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    var responseMessage = jsonDecode(response.body);
    if (responseMessage['code'] == 200) {
      setState(() {
        _circularProgressIndicatorVisible = false;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('accessToken', responseMessage['accessToken']);
      prefs.setString('userId', responseMessage['userId']);
      prefs.setString('loginType', responseMessage['loginType']);
      prefs.setString('userName', responseMessage['userName']);
      prefs.setString('email', responseMessage['email']);
      prefs.setString('mobile', responseMessage['mobile']);

      prefs.setString('signedStatus', 'signed');

      // Navigate to Next Screen.
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            if (responseMessage['loginType'] == "trainer") {
              // return TeacherHomePage();
            } else {
              // return StudentHomePage();
            }
            return Container();
          },
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        _circularProgressIndicatorVisible = false;
      });

      // Showing Alert Dialog with Response JSON Message.
      HLDialogBox(context).customShowDialog(responseMessage['message']);
    }
  }

  _onFormComplete() {
    setState(() {});
    if (_currentPasswordController.isValid && _newPasswordController.isValid) {
      return _loginAPICall();
    } else {
      HLDialogBox(context)
          .customShowDialog("Please provide valid email/mobile and password");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // bool submitEnabled = _formSubmitted;
    return Scaffold(
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildHeadText(),
            SizedBox(height: size.height * 0.03),
            // buildSvgPicture(size),
            SizedBox(height: size.height * 0.03),
            buildCurrentPasswordField(),
            buildNewPasswordField(),
            buildNewConfirmPasswordField(),
            buildLoginWidget(),
            SizedBox(height: size.height * 0.01),
            buildLogoutButton(),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }

  Text buildHeadText() {
    return const Text(
      "Change Password",
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  GestureDetector buildChangePassword(BuildContext context) {
    return GestureDetector(
      child: const Text(
        "CHANGE PASSWORD",
        style: TextStyle(
          color: Palette.hlPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChangePassword()));
      },
    );
  }

  MyTextField buildCurrentPasswordField() {
    return MyTextField(
      MyTextFieldType.Password,
      inputFieldController: _currentPasswordController,
      hintText: 'Current Password',
    );
  }

  MyTextField buildNewPasswordField() {
    return MyTextField(
      MyTextFieldType.Password,
      inputFieldController: _newPasswordController,
      hintText: 'New Password',
    );
  }

  MyTextField buildNewConfirmPasswordField() {
    return MyTextField(
      MyTextFieldType.Password,
      inputFieldController: _confirmPasswordController,
      hintText: 'Confirm Password',
    );
  }

  MyTextField buildRoundedPasswordField() {
    return MyTextField(
      MyTextFieldType.Password,
      inputFieldController: _newPasswordController,
      validate: false,
      textInputAction: TextInputAction.done,
    );
  }

  Widget buildLoginWidget() {
    return _circularProgressIndicatorVisible
        ? const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Palette.hlPrimaryColor),
          )
        : MyButton(
            text: "CHANGE PASSWORD",
            onPressed: () => _onFormComplete(),
          );
  }

  Widget buildLogoutButton() {
    return _circularProgressIndicatorVisible
        ? const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Palette.hlPrimaryColor),
          )
        : MyButton(
            text: "LOGOUT",
            onPressed: () => onLogout(),
          );
  }

  onLogout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiCall.logout(sharedPreferences.getString('userId') as String,
        sharedPreferences.getString('accessToken') as String);
    sharedPreferences.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        (Route<dynamic> route) => false);
  }
}
