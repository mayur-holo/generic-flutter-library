import 'dart:convert';

import 'package:holo_flutter_library/src/config/flavor.config.dart';
import 'package:http/http.dart' as http;

class CheckForForceUpdateBloc {
  Future<Map?> check(String version) async {
    var queryParameters = {
      'version': version,
    };

    var uri = Uri.https(
      FlavorConfig.instance.values.baseUrl,
      FlavorValues.baseUMPath + '/isForceUpdate',
      queryParameters,
    );

    var response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic parsedJson = json.decode(response.body);
      if (parsedJson != null) {
        return json.decode(response.body);
      }
    } else {
      throw Exception('Failed to Check For Update!');
    }

    return null;
  }
}
