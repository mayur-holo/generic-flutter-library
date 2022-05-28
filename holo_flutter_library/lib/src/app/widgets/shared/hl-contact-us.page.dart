/*
 * Created on Sat Feb 06 2021
 * Created by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

import 'package:holo_flutter_library/src/app/widgets/shared/hl-background.widget.dart';

class ContactUs extends StatelessWidget {
  final List<int> contactNos;
  final List<String> emailIds;

  const ContactUs(
    this.contactNos,
    this.emailIds, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              SizedBox(height: size.height * 0.05),
              buildAboutUsText(),
            ],
          ),
        ),
      ),
    );
  }

  Text buildAboutUsText() {
    return Text(
      "You can write to us\n Email : " +
          emailIds.join(', ') +
          "\n" +
          "Or contact us at\n" +
          contactNos.join(', '),
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
