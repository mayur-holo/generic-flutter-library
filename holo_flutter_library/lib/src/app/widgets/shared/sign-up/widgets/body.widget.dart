/*
 * Created on Fri Feb 12 2021
 * Created by - 2: Sachin Sehgal
 * Updated by - 1: Chaman Mandal
 * Updated by - 3: Mayur Ranjan
 * Updated by - 4: Murli
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'dart:convert';

import 'package:holo_flutter_library/src/app/constants/url.constant.dart';
import 'package:flutter/material.dart';
import 'package:holo_flutter_library/src/app/constants/palette.constant.dart';
import 'package:holo_flutter_library/src/app/utils/encrypt-password.util.dart';
import 'package:holo_flutter_library/src/app/widgets/core/hl-button.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/core/hl-calendar.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/core/hl-carousel-slider/hl-carousel-slider.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/core/hl-dropdown.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/core/hl-editing-controller.dart';
import 'package:holo_flutter_library/src/app/widgets/core/hl-multiselect-formfield/hl-multiselect-formfield.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/core/hl-text-field-link.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/core/hl-text-field.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/hl-dialog-box.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/login/login.page.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/sign-up/widgets/background.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/sign-up/widgets/or_divider.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/shared/sign-up/widgets/social_icon.widget.dart';
import 'package:holo_flutter_library/src/config/flavor.config.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _circularProgressIndicatorVisible = false;
  late List _myActivities;
  final _nameController = HLEditingController();
  final _emailController = HLEditingController();
  final _mobileController = HLEditingController();
  final _dobController = HLEditingController();
  final _passwordController = HLEditingController();
  String _radioTypeInput = 'trainer';
  String _radioTypeLocation = HLEditingController().text;
  final _locationController = HLEditingController();
  final _currentStudentsController = HLEditingController();
  final _trainedStudentsController = HLEditingController();
  final _experienceInYearController = HLEditingController();
  final _websiteYoutubeController = HLEditingController();
  final _aboutYourselfController = HLEditingController();
  final _genderController = HLEditingController();
  var _enableAutoPlay = false;
  late List _parentCourses;
  var _signupEnabled = false;

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    getParentCourses();
  }

  Future signUp() async {
    setState(() {
      _circularProgressIndicatorVisible = true;
    });

    var _encryptedPassword = getEncryptedPassword(_passwordController.text);

    var uri = Uri.https(FlavorConfig.instance.values.baseUrl,
        FlavorValues.baseApiPath + '/auth/createUserAccount');

    Map<String, dynamic> data = {
      "userName": _nameController.text,
      "email": _emailController.text,
      "mobile": _mobileController.text,
      "dateOfBirth": _dobController.text,
      "loginType": _radioTypeInput,
      "password": _encryptedPassword,
      "gender": _genderController.text,
      "latitude": 10, //TODO add latitude and longitude change
      "longitude": 10, //TODO add latitude and longitude change
    };
    if (_radioTypeInput == 'student') {
      final List _parentCoursesValues =
          _parentCourses.map((e) => e['value']).toList();
      data["interestedCourses"] = _parentCoursesValues;
    } else if (_radioTypeInput == 'trainer') {
      String websiteLink = _websiteYoutubeController.text;
      if (websiteLink == "")
        websiteLink = "hobbieslobbies.com";
      else if (websiteLink.startsWith("http://"))
        websiteLink = websiteLink.substring(7);
      else if (websiteLink.startsWith("https://"))
        websiteLink = websiteLink.substring(8);

      data["trainedTrainers"] = int.parse(_trainedStudentsController.text);
      data["currentTrainers"] = int.parse(_currentStudentsController.text);
      data["totalExperience"] = int.parse(_experienceInYearController.text);
      data["websiteLink"] = websiteLink;
      data["description"] = _aboutYourselfController.text;
    }

    var response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    var responseMessage = jsonDecode(response.body);

    if (responseMessage['code'] == 200 || responseMessage['code'] == 201) {
      setState(() {
        _circularProgressIndicatorVisible = false;
      });

      prefs = await SharedPreferences.getInstance();

      prefs.setString('accessToken', responseMessage['accessToken']);
      prefs.setString('loginType', responseMessage['loginType']);
      prefs.setString('userName', responseMessage['userName']);
      prefs.setString('email', responseMessage['email']);
      prefs.setString('mobile', responseMessage['mobile']);

      prefs.setString('signedStatus', 'signed');

      if (responseMessage['userId'] != null) {
        prefs.setString('userId', responseMessage['userId']);
      }
      if (prefs.getString("accessToken") != null) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       if (responseMessage['loginType'] == "trainer") {
        //         // return TeacherHomePage();
        //       } else {
        //         // return StudentHomePage(
        //         // userId: responseMessage['userId'],
        //         // );
        //       }
        //     },
        //   ),
        // );
      }
    } else if (responseMessage['code'] == 10001) {
      setState(() {
        _circularProgressIndicatorVisible = false;
      });

      new HLDialogBox(context).customShowDialog(responseMessage['message']);
    } else if (responseMessage['statusCode'] == 400) {
      setState(() {
        _circularProgressIndicatorVisible = false;
      });

      new HLDialogBox(context).customShowDialog(responseMessage['message'][0]);
    } else {
      setState(() {
        _circularProgressIndicatorVisible = false;
      });

      new HLDialogBox(context).customShowDialog("Internal Server Error");
    }
  }

  Future getParentCourses() async {
    var uri = Uri.https(
        FlavorConfig.instance.values.baseUrl,
        FlavorValues.baseCMPath + '/getParentCourses',
        Url.takeAndSkipQueryParams());

    var response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    var responseData = jsonDecode(response.body);

    if (responseData == null || responseData['code'] != 200) {
    } else {
      _parentCourses = [];

      var courses = responseData['courses'];
      for (var course in courses) {
        var tempCourse = {
          "display": course['courseName'],
          "value": course['courseName'],
        };
        _parentCourses.add(tempCourse);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSignUpText(),
              SizedBox(height: size.height * 0.03),
              // buildSvgPicture(size),
              buildCarouselSlider(size),
              buildUserTypeField(),
              buildSignUpWidget(context),
              buildAlreadyHaveAnAccountCheckWidget(context),
              OrDivider(),
              buildSocialWidget(),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Text buildSignUpText() {
    return Text(
      "SIGNUP",
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  // SvgPicture buildSvgPicture(Size size) {
  //   return SvgPicture.asset(
  //     "assets/icons/signup.svg",
  //     height: size.height * 0.35,
  //   );
  // }

  HLTextField buildNameField() {
    return HLTextField(
      TextFieldType.Name,
      inputFieldController: _nameController,
    );
  }

  HLTextField buildEmailField() {
    return HLTextField(
      TextFieldType.Email,
      mandatory: false,
      inputFieldController: _emailController,
    );
  }

  HLTextField buildMobileNumberField() {
    return HLTextField(
      TextFieldType.PhoneNumber,
      inputFieldController: _mobileController,
    );
  }

  DateOfBirthCalendar buildDateOfBirthPicker(BuildContext context) {
    return DateOfBirthCalendar(
      textController: _dobController,
    );
  }

  HLTextField buildPasswordField(BuildContext context) {
    return HLTextField(
      TextFieldType.Password,
      inputFieldController: _passwordController,
      textInputAction: TextInputAction.next,
    );
  }

  Row buildUserTypeField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio(
            value: 'student',
            groupValue: _radioTypeInput,
            toggleable: false,
            onChanged: (value) {
              // TODO - @Mayur: enable it once Student login is launched
              // _enableAutoPlay = true;
              // setState(() {
              //   _radioTypeInput = value;
              // });
            }),
        Text('Student'),
        Radio(
            value: 'trainer',
            groupValue: _radioTypeInput,
            onChanged: (value) {
              _enableAutoPlay = true;
              setState(() {
                _radioTypeInput = value as String;
              });
            }),
        Text('Trainer'),
      ],
    );
  }

  Row buildUseLocationField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio(
            value: 'location',
            groupValue: _radioTypeLocation,
            onChanged: (value) {
              _enableAutoPlay = false;
              setState(() {
                _radioTypeLocation = value as String;
              });
            }),
        Text('Use your current location'),
      ],
    );
  }

  CarouselSlider buildCarouselSlider(Size size) {
    return CarouselSlider(
      items: buildItemsInCarousel(size),
      options: CarouselOptions(
        height: 600.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        aspectRatio: 16 / 9,
        autoPlay: _enableAutoPlay,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayInterval: Duration(milliseconds: 200),
        autoPlayAnimationDuration: Duration(milliseconds: 500),
        viewportFraction: 0.8,
        onPageChanged: (index, reason) {
          _enableAutoPlay = false;
          setState(() {});
        },
      ),
    );
  }

  List<Widget> buildItemsInCarousel(Size size) {
    if (_radioTypeInput.isEmpty) {
      return [
        mainSignUp(size),
      ];
    } else {
      return [
        mainSignUp(size),
        secondarySignUp(size),
      ];
    }
  }

  _onFormComplete() {
    // _formSubmitted = true;
    setState(() {});
    String validation = "";

    List<HLEditingController> controllers = [
      _nameController,
      _emailController,
      _mobileController,
      _dobController,
      _passwordController,
      _genderController
    ];

    switch (_radioTypeInput) {
      case 'trainer':
        controllers.addAll([
          _locationController,
          _currentStudentsController,
          _trainedStudentsController,
          _experienceInYearController,
          _websiteYoutubeController,
          _aboutYourselfController
        ]);
        break;
      case 'student':
        controllers.addAll([_locationController]);
        break;
      default:
    }

    controllers.forEach((eachController) {
      if (eachController == _websiteYoutubeController) {
        if (!eachController.isValid &&
            eachController.validationErrorMessage.isNotEmpty) {
          validation = eachController.validationErrorMessage;
        }
      } else {
        // mandatory check
        if (eachController.text.isEmpty) {
          validation = "Mandatory Fields can not be empty.";
        }
        if (!eachController.isValid &&
            eachController.validationErrorMessage.isNotEmpty) {
          validation = eachController.validationErrorMessage;
        }
      }
    });

    _signupEnabled = true;

    if (validation.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(validation),
          duration: Duration(minutes: 2),
          action: SnackBarAction(
            label: 'Dismiss',
            textColor: Colors.yellow,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
      _circularProgressIndicatorVisible = false;
      _signupEnabled = false;
    }

    if (_signupEnabled) {
      return FutureBuilder<void>(
          future: signUp(),
          builder: (context, AsyncSnapshot<void> snapshot) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: RaisedButton(
                  child: Text('Push'),
                  onPressed: () {
                    if (prefs.getString("accessToken") != null) {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       // return TeacherHomePage();
                      //     },
                      //   ),
                      // );
                    }
                  },
                ),
              ),
            );
          });
    }
  }

  Widget buildSignUpWidget(BuildContext context) {
    return _circularProgressIndicatorVisible
        ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Palette.hlPrimaryColor),
          )
        : HLButton(
            text: "SIGNUP",
            onPressed: () => _onFormComplete(),
          );
  }

  AlreadyHaveAnAccountCheck buildAlreadyHaveAnAccountCheckWidget(
      BuildContext context) {
    return AlreadyHaveAnAccountCheck(
      loginScreen: false,
      press: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginPage();
            },
          ),
        );
      },
    );
  }

  Row buildSocialWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocalIcon(
          iconSrc: "assets/icons/facebook.svg",
          press: () {},
        ),
        SocalIcon(
          iconSrc: "assets/icons/twitter.svg",
          press: () {},
        ),
        SocalIcon(
          iconSrc: "assets/icons/google-plus.svg",
          press: () {},
        ),
      ],
    );
  }

  mainSignUp(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildNameField(),
        buildEmailField(),
        buildMobileNumberField(),
        buildGenderDropdownField(),
        buildDateOfBirthPicker(context),
        buildPasswordField(context),
      ],
    );
  }

  secondarySignUp(Size size) {
    if (_radioTypeInput == 'trainer') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildAddressField(),
          buildTrainedStudentsField(),
          buildCurrentStudentsField(),
          buildExperienceInYearField(),
          buildWebsiteLinkField(),
          buildAboutYourselfField(),
        ],
      );
    } else if (_radioTypeInput == 'student') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildUseLocationField(),
          buildAddressField(),
          buildInterestedCoursesField(),
        ],
      );
    }
  }

  HLTextField buildAddressField() {
    return HLTextField(
      TextFieldType.StreetAddress,
      inputFieldController: _locationController,
    );
  }

  buildInterestedCoursesField() {
    return Container(
      padding: EdgeInsets.all(16),
      child: MultiSelectFormField(
        autovalidate: false,
        title: Text('Interested Courses'),
        validator: (value) {
          if (value == null || value.length == 0) {
            return 'Please select courses which you like';
          }
          return null;
        },
        dataSource: _parentCourses,
        textField: 'display',
        valueField: 'value',
        okButtonLabel: 'OK',
        cancelButtonLabel: 'CANCEL',
        hintWidget: Text('Please select courses which you like'),
        initialValue: _myActivities,
        onSaved: (value) {
          if (value == null) return;
          setState(() {
            _myActivities = value;
          });
        },
      ),
    );
  }

  buildTrainedStudentsField() {
    return HLTextField(
      TextFieldType.Numeric,
      hintText: "Trained students",
      icon: Icons.book_rounded,
      inputFieldController: _trainedStudentsController,
    );
  }

  buildCurrentStudentsField() {
    return HLTextField(
      TextFieldType.Numeric,
      hintText: "Current students",
      icon: Icons.book_outlined,
      inputFieldController: _currentStudentsController,
    );
  }

  buildExperienceInYearField() {
    return HLTextField(
      TextFieldType.Numeric,
      hintText: "Experience in years",
      icon: Icons.explore,
      inputFieldController: _experienceInYearController,
    );
  }

  buildWebsiteLinkField() {
    return HLTextField(
      TextFieldType.URL,
      inputFieldController: _websiteYoutubeController,
      errorText: "",
    );
  }

  buildAboutYourselfField() {
    return HLTextField(
      TextFieldType.Description,
      hintText: "About Yourself",
      inputFieldController: _aboutYourselfController,
    );
  }

  buildGenderDropdownField() {
    return HLDropdownField(
      {'Male': 'male', 'Female': 'female', 'Others': 'others'},
      _genderController,
      hintText: 'Gender',
      icon: Icons.add_circle_outlined,
    );
  }
}
