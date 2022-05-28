/*
 * Created on Sat Feb 06 2021
 * Created by - 3: Mayur Ranjan
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'package:flutter/material.dart';
import 'package:holo_flutter_library/src/app/constants/palette.constant.dart';
import 'package:holo_flutter_library/src/app/utils/string.util.dart';

class MyCircleAvatar extends StatefulWidget {
  final String? titleText;
  final ImageProvider<Object>? backgroundImage;
  final Color? backgroundColor;
  final double? radius;

  const MyCircleAvatar({
    Key? key,
    this.titleText,
    this.backgroundImage,
    this.backgroundColor,
    this.radius,
  }) : super(key: key);

  @override
  _MyCircleAvatarState createState() => _MyCircleAvatarState();
}

class _MyCircleAvatarState extends State<MyCircleAvatar> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: widget.titleText != null
          ? Text(StringUtils.getTextAvatar(widget.titleText ?? ''))
          : null,
      backgroundColor: widget.backgroundColor ?? Palette.hlPrimaryColor,
      backgroundImage: widget.backgroundImage,
      radius: widget.radius,
    );
  }
}
