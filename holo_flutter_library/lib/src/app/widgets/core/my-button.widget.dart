/*
 * Created on Sun Feb 14 2021
 * Created by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'package:flutter/material.dart';
import 'package:holo_flutter_library/src/app/constants/palette.constant.dart';

class MyButton extends StatelessWidget {
  final String? text;
  final Function()? onPressed;
  final Color? color, textColor;
  // final bool disabled;
  const MyButton({
    Key? key,
    this.text,
    this.onPressed,
    this.color,
    this.textColor,
    // this.disabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: MaterialButton(
          // disabledColor:
          //     disabled ? Palette.hlPrimaryLightColor : Palette.hlPrimaryColor,
          // disabledTextColor: disabled ? Palette.hlPrimaryColor : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color ?? Palette.hlPrimaryColor,
          // onPressed: disabled ? null : onPressed,
          onPressed: onPressed,
          child: Text(
            text as String,
            style: TextStyle(color: textColor ?? Colors.white),
          ),
        ),
      ),
    );
  }
}
