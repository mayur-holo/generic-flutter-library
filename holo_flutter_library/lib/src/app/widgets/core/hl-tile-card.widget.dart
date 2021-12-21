/*
 * Created on Sun Feb 14 2021
 * Created by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */

import 'package:flutter/material.dart';

class HLTileCard extends StatelessWidget {
  const HLTileCard({
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
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.purple[50]),
          child: new InkWell(
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
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(
                    title,
                    style: new TextStyle(
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
