/*
 * Created on Sat Feb 08 2021
 * Created by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'package:flutter/material.dart';

import 'package:holo_flutter_library/src/app/widgets/shared/drawer/custom-drawer-widgets-list.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/welcome/welcome.page.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SignedDrawerWidgetsList extends CustomDrawerWidgetsList {
  String? mobile;
  String? email;
  String name = 'User';

  @override
  SignedDrawerWidgetsList() {
    this.fetchdata();
  }

  fetchdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobile = prefs.getString("mobile");
    email = prefs.getString("email");
    name = prefs.getString("name") as String;
  }

  Future<Null> logoutUser(BuildContext _context) async {
    showDialog(
        context: _context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Logout"),
            content: Text("Are you sure want to logout?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await logoutPreferences();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return WelcomePage();
                      },
                    ),
                    (route) => false,
                  );
                },
                child: Text("Yes"),
              )
            ],
          );
        });
  }

  @override
  Widget headerWidget(BuildContext context) {
    return FutureBuilder(
        future: fetchdata(),
        builder: (context, AsyncSnapshot<void> snapshot) {
          return GestureDetector(
            onTap: () async {},
            child: UserAccountsDrawerHeader(
              accountName: Text(name),
              accountEmail: Text(email == null
                  ? mobile == null
                      ? ''
                      : mobile as String
                  : email as String),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar.jpg"),
              ),
            ),
          );
        });
  }

  Widget homeWidget(BuildContext context);

  Widget updateProfileWidget(BuildContext context);

  Widget logoutWidget(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.logout),
      title: Text("Logout"),
      onTap: () => logoutUser(context),
    );
  }

  logoutPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('signedStatus', 'unsigned');
  }
}
