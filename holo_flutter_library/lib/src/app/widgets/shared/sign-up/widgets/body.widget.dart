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
import 'package:holo_flutter_library/src/app/widgets/core/my-button.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-calendar.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-carousel-slider/my-carousel-slider.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-dropdown.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-editing-controller.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-multiselect-formfield/my-multiselect-formfield.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-text-field-link.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-text-field.widget.dart';
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
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _circularProgressIndicatorVisible = false;
  late List _myActivities;
  final _nameController = MyEditingController();
  final _emailController = MyEditingController();
  final _mobileController = MyEditingController();
  final _dobController = MyEditingController();
  final _passwordController = MyEditingController();
  String _radioTypeInput = 'trainer';
  String _radioTypeLocation = MyEditingController().text;
  final _locationController = MyEditingController();
  final _currentStudentsController = MyEditingController();
  final _trainedStudentsController = MyEditingController();
  final _experienceInYearController = MyEditingController();
  final _websiteYoutubeController = MyEditingController();
  final _aboutYourselfController = MyEditingController();
  final _genderController = MyEditingController();
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
      if (websiteLink == "") {
        websiteLink = "hobbieslobbies.com";
      } else if (websiteLink.startsWith("http://")) {
        websiteLink = websiteLink.substring(7);
      } else if (websiteLink.startsWith("https://")) {
        websiteLink = websiteLink.substring(8);
      }

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

      HLDialogBox(context).customShowDialog(responseMessage['message']);
    } else if (responseMessage['statusCode'] == 400) {
      setState(() {
        _circularProgressIndicatorVisible = false;
      });

      HLDialogBox(context).customShowDialog(responseMessage['message'][0]);
    } else {
      setState(() {
        _circularProgressIndicatorVisible = false;
      });

      HLDialogBox(context).customShowDialog("Internal Server Error");
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
    return const Text(
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

  MyTextField buildNameField() {
    return MyTextField(
      MyTextFieldType.Name,
      inputFieldController: _nameController,
    );
  }

  MyTextField buildEmailField() {
    return MyTextField(
      MyTextFieldType.Email,
      mandatory: false,
      inputFieldController: _emailController,
    );
  }

  MyTextField buildMobileNumberField() {
    return MyTextField(
      MyTextFieldType.PhoneNumber,
      inputFieldController: _mobileController,
    );
  }

  DateOfBirthCalendar buildDateOfBirthPicker(BuildContext context) {
    return DateOfBirthCalendar(
      textController: _dobController,
    );
  }

  MyTextField buildPasswordField(BuildContext context) {
    return MyTextField(
      MyTextFieldType.Password,
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
        const Text('Student'),
        Radio(
            value: 'trainer',
            groupValue: _radioTypeInput,
            onChanged: (value) {
              _enableAutoPlay = true;
              setState(() {
                _radioTypeInput = value as String;
              });
            }),
        const Text('Trainer'),
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
        const Text('Use your current location'),
      ],
    );
  }

  MyCarouselSlider buildCarouselSlider(Size size) {
    return MyCarouselSlider(
      items: buildItemsInCarousel(size),
      options: CarouselOptions(
        height: 600.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        aspectRatio: 16 / 9,
        autoPlay: _enableAutoPlay,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayInterval: const Duration(milliseconds: 200),
        autoPlayAnimationDuration: const Duration(milliseconds: 500),
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

    List<MyEditingController> controllers = [
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

    for (var eachController in controllers) {
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
    }

    _signupEnabled = true;

    if (validation.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(validation),
          duration: const Duration(minutes: 2),
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
                child: MaterialButton(
                  child: const Text('Push'),
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
        ? const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Palette.hlPrimaryColor),
          )
        : MyButton(
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
        SocialIcon(
          iconSrc: "assets/icons/facebook.svg",
          press: () {},
        ),
        SocialIcon(
          iconSrc: "assets/icons/twitter.svg",
          press: () {},
        ),
        SocialIcon(
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

  MyTextField buildAddressField() {
    return MyTextField(
      MyTextFieldType.StreetAddress,
      inputFieldController: _locationController,
    );
  }

  buildInterestedCoursesField() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: MyMultiSelectFormField(
        autovalidate: false,
        title: const Text('Interested Courses'),
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
        hintWidget: const Text('Please select courses which you like'),
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
    return MyTextField(
      MyTextFieldType.Numeric,
      hintText: "Trained students",
      icon: Icons.book_rounded,
      inputFieldController: _trainedStudentsController,
    );
  }

  buildCurrentStudentsField() {
    return MyTextField(
      MyTextFieldType.Numeric,
      hintText: "Current students",
      icon: Icons.book_outlined,
      inputFieldController: _currentStudentsController,
    );
  }

  buildExperienceInYearField() {
    return MyTextField(
      MyTextFieldType.Numeric,
      hintText: "Experience in years",
      icon: Icons.explore,
      inputFieldController: _experienceInYearController,
    );
  }

  buildWebsiteLinkField() {
    return MyTextField(
      MyTextFieldType.URL,
      inputFieldController: _websiteYoutubeController,
      errorText: "",
    );
  }

  buildAboutYourselfField() {
    return MyTextField(
      MyTextFieldType.Description,
      hintText: "About Yourself",
      inputFieldController: _aboutYourselfController,
    );
  }

  buildGenderDropdownField() {
    return MyDropdownField(
      const {'Male': 'male', 'Female': 'female', 'Others': 'others'},
      _genderController,
      hintText: 'Gender',
      icon: Icons.add_circle_outlined,
    );
  }
}
