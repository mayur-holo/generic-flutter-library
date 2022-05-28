/*
 * Created on Sun Feb 14 2021
 * Created by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */

import 'package:flutter/material.dart';

class HLDialogBox {
  final BuildContext context;

  HLDialogBox(this.context);

  // Showing Alert Dialog with Response JSON Message.
  void customShowDialog(paramMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(paramMessage),
          actions: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
