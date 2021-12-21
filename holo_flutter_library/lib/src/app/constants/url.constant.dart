/*
 * Created on Sat Feb 06 2021
 * Created by - 3: Mayur Ranjan
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */

class Url {
  static const String LOGIN_URL = '';

  static Map<String, String> takeAndSkipQueryParams(
      {int take = 0, int skip = 0}) {
    return {'take': take.toString(), 'skip': skip.toString()};
  }
}
