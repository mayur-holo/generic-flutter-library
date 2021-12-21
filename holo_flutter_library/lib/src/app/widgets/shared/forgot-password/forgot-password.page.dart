import 'package:holo_flutter_library/src/app/widgets/core/my-scaffold.widget.dart';
import 'package:flutter/material.dart';

import 'widgets/body.widget.dart';

class ForgotPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      Body(),
      headerName: 'OTP',
    );
  }
}
