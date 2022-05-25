/*
 * Created on Sat Jan 30 2021
 * Created by - 3: Mayur Ranjan
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */

class StringUtils {
  static String enumName(String enumToString) {
    List<String> paths = enumToString.split(".");
    return paths[paths.length - 1];
  }

  static bool isPdf(String mime) {
    return (mime == 'application/pdf');
  }

  static bool isImage(String mime) {
    return (mime == 'image/jpeg');
  }

  static String getTextAvatar(String text) {
    String textAvatar = '';
    if (text.isNotEmpty) {
      textAvatar = text[0].toUpperCase();
    }
    if (text.split(" ").length > 1 && text.split(" ")[1].isNotEmpty) {
      textAvatar += text.split(" ")[1][0].toUpperCase();
    } else {
      if (text.length > 1) {
        textAvatar += text[1].toUpperCase();
      }
    }
    return textAvatar;
  }
}
