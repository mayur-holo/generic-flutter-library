import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:holo_flutter_library/src/app/widgets/shared/login/models/login.model.dart';
import 'package:holo_flutter_library/src/config/flavor.config.dart';

class LoginBloc {
  Future<Login> login(String emailOrMobile, String password) async {
    var uri =
        Uri.https(FlavorConfig.instance.values.baseUrl, '/userMgmt/login');
    final http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'email': emailOrMobile,
        'mobile': emailOrMobile,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 OK response,
      // then parse the JSON.
      return Login.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 OK response,
      // then throw an exception.
      throw Exception('Failed to login');
    }
  }
}
