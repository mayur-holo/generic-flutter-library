import 'package:holo_flutter_library/src/app/widgets/shared/change-password/blocs/change-password.bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/login-body.widget.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LogOutApi apiCall = LogOutApi();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }

  onLogout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiCall.logout(sharedPreferences.getString('userId') as String,
        sharedPreferences.getString('accessToken') as String);
    sharedPreferences.clear();
  }
}
