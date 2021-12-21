import 'package:holo_flutter_library/src/app/widgets/shared/change-password/blocs/change-password.bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/login-body.widget.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LogOutApi apiCall = new LogOutApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }

  onLogout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiCall.logout(sharedPreferences.getString('userId') as String,
        sharedPreferences.getString('accessToken') as String);
    sharedPreferences.clear();
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
    //     (Route<dynamic> route) => false);
  }
}
