import 'package:flutter/material.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/change-password/blocs/change-password.bloc.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/menu-bar/menu-bar.page.dart';
import 'widgets/body.widget.dart';

class ChangePasswordPage extends StatelessWidget {
  final LogOutApi apiCall = LogOutApi();

  ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Body(), drawer: MenuBar());
  }
}
