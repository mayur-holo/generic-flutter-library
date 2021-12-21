/*
 * Created on Sat Feb 06 2021
 * Created by - 2: Sachin Sehgal
 * Updated by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'package:flutter/material.dart';
import 'package:holo_flutter_library/src/app/utils/check_for_force_update.bloc.dart';
// import 'package:flutter_svg/svg.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

import 'package:holo_flutter_library/src/app/constants/palette.constant.dart';
import 'package:holo_flutter_library/src/app/constants/static.constant.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-button.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/login/login.page.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/sign-up/widgets/background.widget.dart';
import 'package:holo_flutter_library/src/config/flavor.config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    if (FlavorConfig.isProd()) {
      _checkForForceUpdate();
    }

    super.initState();
  }

  // Function to check for Version Force Update
  _checkForForceUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    CheckForForceUpdateBloc bloc = CheckForForceUpdateBloc();

    bloc.check(version).then((value) => {
          if (value?['code'] == 200)
            {
              if (value?['updateType'] == "force")
                {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("New Update!"),
                      content: const Text(
                          "Please update your app to use it without Disruption."),
                      actions: [
                        ElevatedButton(
                          onPressed: () async {
                            const url = Static.APP_URL;
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text("Update"),
                        ),
                      ],
                    ),
                  ),
                }
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildWelcomeText(),
            SizedBox(height: size.height * 0.05),
            // buildSvgPicture(size),
            SizedBox(height: size.height * 0.05),
            buildLoginSignupButton(context),
            buildSkipButton(context),
          ],
        ),
      ),
    );
  }

  Text buildWelcomeText() {
    return const Text(
      "Welcome to EduCare",
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  // SvgPicture buildSvgPicture(Size size) {
  //   return SvgPicture.asset(
  //     "assets/icons/chat.svg",
  //     height: size.height * 0.45,
  //   );
  // }

  HLButton buildLoginSignupButton(BuildContext context) {
    return HLButton(
      text: "LOGIN / SIGNUP",
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginPage();
            },
          ),
        );
      },
    );
  }

  HLButton buildSkipButton(BuildContext context) {
    return HLButton(
      text: "SKIP LOGIN",
      color: Palette.hlPrimaryLightColor,
      textColor: Colors.black,
      onPressed: () {},
    );
  }
}
