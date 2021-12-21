/*
 * Created on Sat Feb 08 2021
 * Created by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'package:flutter/material.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/drawer/custom-drawer-widgets-list.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/login/login.page.dart';

class UnsignedDrawerWidgetsList extends CustomDrawerWidgetsList {
  @override
  Widget headerWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      child: DrawerHeader(
        margin: EdgeInsets.only(bottom: 5.0),
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 40),
        child: Text(
          'Join Us',
        ),
      ),
    );
  }

  @override
  List<Widget> getDrawerWidgetsList(BuildContext context) {
    List<Widget> customDrawerWidgetsList = [];
    customDrawerWidgetsList.add(headerWidget(context));
    customDrawerWidgetsList
        .addAll(CustomDrawerWidgetsList.defaultDrawerWidgetsList(context));
    return customDrawerWidgetsList;
  }
}
