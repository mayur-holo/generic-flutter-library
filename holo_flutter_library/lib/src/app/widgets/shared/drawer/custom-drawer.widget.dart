/*
 * Created on Sat Feb 06 2021
 * Created by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'package:flutter/material.dart';

import 'package:holo_flutter_library/src/app/widgets/shared/drawer/unsigned_drawer_widgets_list.widget.dart';

enum DrawerType { signed, unsigned }

class CustomDrawer extends StatelessWidget {
  final DrawerType? drawerType;

  const CustomDrawer({
    Key? key,
    this.drawerType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: drawerListType(context),
      ),
    );
  }

  List<Widget> drawerListType(BuildContext context) {
    switch (drawerType) {
      case DrawerType.unsigned:
      case DrawerType.signed:
      case null:
        return UnsignedDrawerWidgetsList().getDrawerWidgetsList(context);
    }
  }
}
