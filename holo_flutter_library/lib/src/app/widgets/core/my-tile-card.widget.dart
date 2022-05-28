/*
 * Created on Sun Feb 14 2021
 * Created by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */

import 'package:flutter/material.dart';

class MyTileCard extends StatelessWidget {
  const MyTileCard({
    Key? key,
    required this.context,
    required this.title,
    required this.path,
  }) : super(key: key);

  final BuildContext context;
  final String title;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1.0,
        margin: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.purple[50]),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    path,
                    width: 60,
                    height: 72,
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: Text(
                    title,
                    style:  TextStyle(
                      fontSize: 18.0,
                      color: Colors.purple[400],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
