/*
 * Created on Sat Feb 06 2021
 * Created by - 1: Sachin Sehgal
 * Updated by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'package:flutter/material.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/welcome/widgets/body.widget.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
