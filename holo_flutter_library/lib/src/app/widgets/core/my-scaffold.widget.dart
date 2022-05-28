/*
 * Created on Sun Oct 31 2021
 * Created by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'package:holo_flutter_library/src/app/constants/palette.constant.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/drawer/custom-drawer.widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyScaffold extends StatefulWidget implements PreferredSizeWidget {
  final Widget customBody;
  final String? headerName;
  final Widget? customFloatingActionButton;

  const MyScaffold(this.customBody,
      {Key? key, this.headerName, this.customFloatingActionButton})
      : super(key: key);

  @override
  _MyScaffoldState createState() => _MyScaffoldState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _MyScaffoldState extends State<MyScaffold> {
  late AppBar customAppBar;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: buildAppBar(),
        builder: (context, AsyncSnapshot<DrawerType> snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            return Scaffold(
              body: widget.customBody,
              appBar: customAppBar,
              drawer: CustomDrawer(
                drawerType: snapshot.data as DrawerType,
              ),
              floatingActionButton: widget.customFloatingActionButton,
            );
          } else {
            return Scaffold(
              body: widget.customBody,
            );
          }
        });
  }

  Future<DrawerType> buildAppBar() async {
    DrawerType drawerType = await getDrawerType();
    if (drawerType != DrawerType.unsigned) {
      customAppBar = AppBar(
        title: Text(
          widget.headerName as String,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Palette.hlPrimaryLightColor,
          ),
        ),
        elevation: 10,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
        backgroundColor: Palette.hlPrimaryColor,
      );
    }
    return drawerType;
  }

  Future<DrawerType> getDrawerType() async {
    DrawerType sharedPrefDrawerType = DrawerType.unsigned;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String signedStatus = prefs.getString("signedStatus") as String;
    String loginType = prefs.getString("loginType") as String;

    if (signedStatus == 'unsigned') {
      sharedPrefDrawerType = DrawerType.unsigned;
    } else if (signedStatus == 'signed') {
      switch (loginType) {
        default:
          sharedPrefDrawerType = DrawerType.unsigned;
          break;
      }
    }
    return sharedPrefDrawerType;
  }
}
