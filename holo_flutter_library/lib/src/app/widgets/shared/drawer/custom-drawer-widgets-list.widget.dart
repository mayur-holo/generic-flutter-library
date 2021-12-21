/*
 * Created on Sat Feb 06 2021
 * Created by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'package:flutter/material.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/hl-about-us.page.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/hl-contact-us.page.dart';
import 'package:holo_flutter_library/src/app/constants/static.constant.dart';

abstract class CustomDrawerWidgetsList {
  Widget headerWidget(BuildContext context);

  List<Widget> getDrawerWidgetsList(BuildContext context);

  static List<Widget> defaultDrawerWidgetsList(BuildContext context) {
    return [
      const Divider(
        height: 1,
        thickness: 1,
      ),
      aboutUsWidget(context),
      contactUsWidget(context),
      feedbackWidget(context),
    ];
  }

  static Widget aboutUsWidget(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.info),
        title: const Text("About us"),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AboutUs(Static.ABOUT_US_MESSAGE);
          }));
        });
  }

  static Widget contactUsWidget(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.contact_page),
        title: const Text("Contact us"),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ContactUs(Static.CONTACT_US_MOBILE_TRAINER,
                Static.CONTACT_US_EMAIL_TRAINER);
          }));
        });
  }

  static Widget feedbackWidget(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.feedback),
        title: const Text("Feedback"),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AboutUs(Static.ABOUT_US_MESSAGE);
          }));
        });
  }
}
