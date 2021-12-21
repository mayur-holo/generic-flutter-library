/*
 * Created on Sat Jan 30 2021
 * Created by - 3: Mayur Ranjan
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */

import 'package:flutter/material.dart';
import 'package:holo_flutter_library/src/app/utils/string.util.dart';

enum Flavor { dev, qa, preProd, demo, prod }

class FlavorValues {
  FlavorValues({required this.baseUrl});

  final String baseUrl;

  static const String baseApiPath = '/edutech-api';

  // base path
  static const String baseAuthPath = FlavorValues.baseApiPath + '/auth';
  static const String baseUMPath = FlavorValues.baseApiPath + '/userMgmt';
  static const String baseCMPath = FlavorValues.baseApiPath + '/courseMgmt';
  static const String baseCLMPath = FlavorValues.baseApiPath + '/classMgmt';
  static const String baseTMPath = FlavorValues.baseApiPath + '/trainerMgmt';
  static const String baseSMPath = FlavorValues.baseApiPath + '/studentMgmt';
  static const String baseBMPath = FlavorValues.baseApiPath + '/batchMgmt';
  static const String baseAMPath = FlavorValues.baseApiPath + '/assignmentMgmt';
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final Color color;
  final FlavorValues values;
  static late FlavorConfig _instance;

  factory FlavorConfig(
      {required Flavor flavor,
      Color color: Colors.blue,
      required FlavorValues values}) {
    _instance = FlavorConfig._internal(
        flavor, StringUtils.enumName(flavor.toString()), color, values);
    return _instance;
  }

  FlavorConfig._internal(this.flavor, this.name, this.color, this.values);

  static FlavorConfig get instance {
    return _instance;
  }

  static bool isDev() => _instance.flavor == Flavor.dev;
  static bool isQA() => _instance.flavor == Flavor.qa;
  static bool isPreProd() => _instance.flavor == Flavor.preProd;
  static bool isDemo() => _instance.flavor == Flavor.demo;
  static bool isProd() => _instance.flavor == Flavor.prod;
}
