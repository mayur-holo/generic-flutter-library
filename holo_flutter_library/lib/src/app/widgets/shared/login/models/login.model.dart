/*
 * Created on Thu Dec 17 2020
 * Created by - 3: Mayur Ranjan
 *
 * Copyright (c) 2020 Hobbies-Lobbies Pvt Ltd.
 */

class Login {
  final String message;
  final int code;
  final String userId;
  final int roleId;

  Login(
      {required this.message,
      required this.code,
      required this.userId,
      required this.roleId});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      message: json['message'],
      code: json['code'],
      userId: json['userId'],
      roleId: json['roleId'],
    );
  }
}
