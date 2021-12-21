import 'dart:convert';
import 'package:holo_flutter_library/src/app/widgets/shared/change-password/models/change-password.model.dart';
import 'package:http/http.dart' as http;

class LogOutApi {
  Future<Logout> logout(String userId, String accessToken) async {
    // var uri = Uri.https(FlavorConfig.instance.values.baseUrl, '/userMgmt/login');
    var uri =
        Uri.parse('https://dev.matricsdigital.com/edutech-api/{{UM}}/logOut');
    final http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'userId': "9807955280426795608",
        'accessToken':
            "eyJhbGciOiJIUzI1NiJ9.eyJwYXNzd29yZCI6IjEyMzQ1NiIsInVzZXJOYW1lIjoibXVybGkiLCJlbWFpbCI6Im11cmxpQGdtYWlsLmNvbSIsIm1vYmlsZSI6Ijk5NzE4MTcwNDQiLCJkYXRlT2ZCaXJ0aCI6IjE5OTUtMDgtMjdUMDA6MDA6MDAuMDAwWiIsImxvZ2luVHlwZSI6InRyYWluZXIifQ.1MMgQFzxz4ImOsnTgamW2BmATI2GuAFHRKe4FiYv4fA",
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 OK response,
      // then parse the JSON.
      return Logout.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 OK response,
      // then throw an exception.
      throw Exception('Failed to logout');
    }
  }
}
