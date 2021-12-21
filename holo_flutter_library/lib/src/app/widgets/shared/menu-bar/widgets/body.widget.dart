import 'package:holo_flutter_library/src/app/widgets/shared/change-password/blocs/change-password.bloc.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/login/login.page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  MyHomePage createState() {
    return MyHomePage();
  }
}

class MyHomePage extends State<Body> {
  LogOutApi apiCall = new LogOutApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("demo")),
      // drawer: CustomDrawer(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(title: const Text('Logout'), onTap: () => onLogout()),
          ],
        ),
      ),
    );
  }

  onLogout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiCall.logout(sharedPreferences.getString('userId') as String,
        sharedPreferences.getString('accessToken') as String);
    sharedPreferences.clear();
    if (sharedPreferences.getString('accessToken') == null) {
      print('logout successfull');
    }
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        (Route<dynamic> route) => false);
  }
}
