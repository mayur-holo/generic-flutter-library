import 'dart:convert';

import 'package:holo_flutter_library/src/config/flavor.config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

_forgotPassword() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("accessToken") as String;
  var uri = Uri.https(FlavorConfig.instance.values.baseUrl,
      FlavorValues.baseUMPath + '/auth/forgotPassword');
  var response = await http.post(
    uri,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  var output = jsonDecode(response.body);
  if (output['code'] == 200) {
    debugPrint("Send Forgot Request");

    ScaffoldMessenger.of(output).showSnackBar(
      SnackBar(
        content: Text(
          output['message'].toString(),
        ),
      ),
    );
  }
}

//
//  var output = jsonDecode(response.body);

//     if (output['code'] == 200) {
//       print("Send Forgot Request");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             output['message'].toString(),
//           ),
//         ),
//       );
//     }
