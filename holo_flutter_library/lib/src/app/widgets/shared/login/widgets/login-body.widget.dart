/*
 * Created on Tue Dec 09 2020
 * Created by - 2: Sachin Sehgal
 * Updated by - 1: Chaman Mandal
 * Updated by - 3: Mayur Ranjan
 * Updated by - 4: Murli
 * Updated by - 5: Shivam
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'dart:convert';
import 'dart:developer';

import 'package:holo_flutter_library/src/app/constants/palette.constant.dart';
import 'package:holo_flutter_library/src/app/utils/encrypt-password.util.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-button.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-editing-controller.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-text-field-link.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-text-field.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/change-password/change-password.page.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/hl-dialog-box.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/login/widgets/background.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/sign-up/sign-up.page.dart';
import 'package:holo_flutter_library/src/config/flavor.config.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  final MyEditingController _emailMobileController = MyEditingController();
  final MyEditingController _passwordController = MyEditingController();

  // bool _formSubmitted = false;
  bool _circularProgressIndicatorVisible = false;

  _loginAPICall() async {
    setState(() {
      _circularProgressIndicatorVisible = true;
    });

    // SERVER LOGIN API URL
    var uri = Uri.https(FlavorConfig.instance.values.baseUrl,
        FlavorValues.baseApiPath + '/auth/login');

    var _encryptedPassword = getEncryptedPassword(_passwordController.text);

    // Store all data with Param Name.
    Map<String, dynamic> data = {
      "email": _emailMobileController.text,
      "mobile": _emailMobileController.text,
      "password": _encryptedPassword,
    };

    // Starting Web API Call.
    var response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    // Getting Server response into variable.
    var responseMessage = jsonDecode(response.body);

    // If the Response Message is Matched.
    if (responseMessage['code'] == 200) {
      // Hiding the CircularProgressIndicator.
      setState(() {
        _circularProgressIndicatorVisible = false;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(responseMessage['accessToken']);
      prefs.setString('accessToken', responseMessage['accessToken'] ?? '');
      //TODO show an error as, try after some time if user id, access token, login type ,name is empty
      prefs.setString('userId', responseMessage['userId']);
      prefs.setString('loginType', responseMessage['loginType']);
      prefs.setString('name', responseMessage['name']);
      prefs.setString('email', responseMessage['email'] ?? '');
      prefs.setString('mobile', responseMessage['mobile'] ?? '');
      prefs.setString('signedStatus', 'signed');
      inspect('Shared preferences : ' + prefs.toString());
      // Navigate to Next Screen.
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            switch (responseMessage['loginType']) {
              default:
                {
                  return Container();
                }
            }
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
      new HLDialogBox(context).customShowDialog(responseMessage['message']);
    }
  }

  _onFormComplete() {
    setState(() {});
    if (_emailMobileController.isValid && _passwordController.isValid) {
      return _loginAPICall();
    } else {
      new HLDialogBox(context)
          .customShowDialog("Please provide valid email/mobile and password");
    }
  }

  // Function to call Forgot Password API.
  _forgotPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("accessToken") as String;

    var uri = Uri.https(
      FlavorConfig.instance.values.baseUrl,
      FlavorValues.baseUMPath + '/forgotPassword',
    );

    var response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var output = jsonDecode(response.body);

    if (output['code'] == 200) {
      print("Send Forgot Request");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            output['message'].toString(),
          ),
        ),
      );
    }
  }

  // Function to Navigate to Feedback Page.
  _feedbackPage() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => FeedbackPage(),
    //   ),
    // );
  }

  @override
  void initState() {
    super.initState();

    prefillLogin();
  }

  Future<void> prefillLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    setState(() {
      if (email != null) {
        this._emailMobileController.text = email;
        this._emailMobileController.isValid = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // bool submitEnabled = _formSubmitted;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildHeadText(),
            SizedBox(height: size.height * 0.03),
            // buildSvgPicture(size),
            // SizedBox(height: size.height * 0.03),
            buildEmailMobileField(),
            buildRoundedPasswordField(),
            buildLoginWidget(),
            SizedBox(height: size.height * 0.01),
            buildForgotPassword(),
            // SizedBox(height: size.height * 0.02),
            // buildFeedbackPage(),
            // SizedBox(height: size.height * 0.02),
            // buildAlreadyHaveAnAccountCheck(context),
            // OrDivider(),
            // buildSocialIcons()
          ],
        ),
      ),
    );
  }

  Text buildHeadText() {
    return Text(
      "LOGIN",
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget buildForgotPassword() {
    return GestureDetector(
      child: Text(
        "FORGOT PASSWORD",
        style: TextStyle(
          color: Palette.hlPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/forgot-password/');
      },
    );
  }

  GestureDetector buildChangePassword(BuildContext context) {
    return GestureDetector(
      child: Text(
        "CHANGE PASSWORD",
        style: TextStyle(
          color: Palette.hlPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChangePasswordPage()));
      },
    );
  }

  Widget buildFeedbackPage() {
    return GestureDetector(
      child: Text(
        "FEEDBACK PAGE",
        style: TextStyle(
          color: Palette.hlPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: _feedbackPage,
    );
  }

  MyTextField buildEmailMobileField() {
    return MyTextField(
      MyTextFieldType.EmailPhoneNumber,
      inputFieldController: _emailMobileController,
    );
  }

  MyTextField buildRoundedPasswordField() {
    return MyTextField(
      MyTextFieldType.Password,
      inputFieldController: _passwordController,
      validate: false,
      textInputAction: TextInputAction.done,
    );
  }

  Widget buildLoginWidget() {
    return _circularProgressIndicatorVisible
        ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Palette.hlPrimaryColor),
          )
        : MyButton(
            text: "LOGIN",
            onPressed: () => _onFormComplete(),
          );
  }

  AlreadyHaveAnAccountCheck buildAlreadyHaveAnAccountCheck(
      BuildContext context) {
    return AlreadyHaveAnAccountCheck(
      loginScreen: true,
      press: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SignUpPage();
            },
          ),
        );
      },
    );
  }

  // Row buildSocialIcons() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       SocalIcon(
  //         iconSrc: "assets/icons/facebook.svg",
  //         press: () {},
  //       ),
  //       SocalIcon(
  //         iconSrc: "assets/icons/twitter.svg",
  //         press: () {},
  //       ),
  //       SocalIcon(
  //         iconSrc: "assets/icons/google-plus.svg",
  //         press: () {},
  //       ),
  //     ],
  //   );
  // }
}
