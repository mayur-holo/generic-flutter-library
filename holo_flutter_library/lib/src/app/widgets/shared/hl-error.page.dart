import 'package:flutter/material.dart';

import 'package:holo_flutter_library/src/app/constants/palette.constant.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Internal Server Error\nPlease try again Later!",
        style: TextStyle(color: Palette.hlPrimaryColor, fontSize: 22),
      ),
    );
  }
}
