/*
 * Created on Fri Feb 12 2021
 * Created by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'dart:convert';

import 'package:crypto/crypto.dart';

String getEncryptedPassword(String password) {
  var bytes = utf8.encode(password); // data being hashed

  var _encryptedPassword = md5.convert(bytes);

  return _encryptedPassword.toString();
}
