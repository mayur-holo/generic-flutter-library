/*
 * Created on Sat Feb 06 2021
 * Created by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
abstract class StringValidator {
  late String emptyErrorText;
  late String validationFailureText;
  late String hintText;

  bool isEmpty(String value);
  bool isValid(String value);

  String getErrorText(String value, bool mandatory, String paramEmptyErrorText,
      String paramValidationFailureText, bool defaultValue,
      {bool validate});
  String getHintText(String value);
}

abstract class NonEmptyStringValidator implements StringValidator {
  @override
  bool isEmpty(String value) {
    return (value.isEmpty);
  }

  @override
  String getErrorText(String value, bool mandatory, String paramEmptyErrorText,
      String paramValidationFailureText, bool defaultValue,
      {bool validate = true}) {
    if (defaultValue) {
      return '';
    } else if (isEmpty(value) && mandatory) {
      return paramEmptyErrorText;
    } else if (validate && !isValid(value)) {
      return paramValidationFailureText;
    }
    return '';
  }

  @override
  String getHintText(String value) {
    return hintText;
  }
}

class EmailValidator extends NonEmptyStringValidator {
  @override
  String emptyErrorText;

  @override
  String validationFailureText;

  @override
  String hintText;

  EmailValidator({
    this.emptyErrorText = 'Email can\'t be empty',
    this.validationFailureText = 'Invalid email id',
    this.hintText = 'hobbies-lobbies@hotmail.com',
  });

  @override
  bool isValid(String value) {
    final RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        multiLine: false);
    return emailRegex.hasMatch(value);
  }
}

class PasswordValidator extends NonEmptyStringValidator {
  @override
  String emptyErrorText;

  @override
  String validationFailureText;

  @override
  String hintText;

  PasswordValidator({
    this.emptyErrorText = 'Password can\'t be empty',
    this.validationFailureText = "Invalid Password",
    this.hintText = 'Password',
  });

  @override
  bool isValid(String value) {
    final RegExp bigCapRegex = RegExp(r"[A-Z]+", multiLine: false);
    final RegExp smallCapRegex = RegExp(r"[a-z]+", multiLine: false);
    final RegExp numberRegex = RegExp(r"[0-9]+", multiLine: false);
    final RegExp specialRegex =
        RegExp(r"[^A-Za-z0-9 ]", multiLine: false); //()[]\;:"<>

    if (!bigCapRegex.hasMatch(value)) {
      validationFailureText = "Password should consist 1 capital letter";
      return false;
    }

    if (!smallCapRegex.hasMatch(value)) {
      validationFailureText = "Password should consist 1 small letter";
      return false;
    }

    if (!numberRegex.hasMatch(value)) {
      validationFailureText = "Password should consist 1 number";
      return false;
    }

    if (!specialRegex.hasMatch(value)) {
      validationFailureText =
          "Password should consist 1 special character .!#\$%&'*+-/=?^_`{|}~";
      return false;
    }

    if (!((value.length > 8) && (value.length < 253))) {
      validationFailureText = "Password should be of length more than 8";
      return false;
    }

    return true;
  }
}

class NameValidator extends NonEmptyStringValidator {
  @override
  String emptyErrorText;

  @override
  String validationFailureText;

  @override
  String hintText;

  NameValidator({
    this.emptyErrorText = 'Name can\'t be empty',
    this.validationFailureText =
        'Please provide a name with lesser than the length of 255',
    this.hintText = 'Name',
  });

  @override
  bool isValid(String value) {
    final RegExp lengthRegex =
        RegExp(r"^[a-zA-Z0-9.|_ ]{1,253}$", multiLine: false);
    return lengthRegex.hasMatch(value);
  }
}

class DescriptionValidator extends NonEmptyStringValidator {
  @override
  String emptyErrorText;

  @override
  String validationFailureText;

  @override
  String hintText;

  DescriptionValidator({
    this.emptyErrorText = 'Description can\'t be empty',
    this.validationFailureText = 'Please provide some description',
    this.hintText = 'I like to teach students.',
  });

  @override
  bool isValid(String value) {
    return true;
  }
}

class PhoneNumberValidator extends NonEmptyStringValidator {
  @override
  String emptyErrorText;

  @override
  String validationFailureText;

  @override
  String hintText;

  PhoneNumberValidator({
    this.emptyErrorText = 'Phone number can\'t be empty',
    this.validationFailureText = 'Please provide a valid phone number',
    this.hintText = '+919090901010',
  });

  @override
  bool isValid(String value) {
    final RegExp mobileRegex =
        RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$', multiLine: false);
    return mobileRegex.hasMatch(value);
  }
}

class StreetAddressValidator extends NonEmptyStringValidator {
  @override
  String emptyErrorText;

  @override
  String validationFailureText;

  @override
  String hintText;

  StreetAddressValidator({
    this.emptyErrorText = 'Address can\'t be empty',
    this.validationFailureText = 'Please provide a valid address',
    this.hintText = 'Fun academy, Kormanagala, Bangalore.',
  });

  @override
  bool isValid(String value) {
    return true;
  }
}

class NumericValidator extends NonEmptyStringValidator {
  @override
  String emptyErrorText;

  @override
  String validationFailureText;

  @override
  String hintText;

  NumericValidator({
    this.emptyErrorText = 'Description can\'t be empty',
    this.validationFailureText = 'Please provide some description',
    this.hintText = 'I like to teach students.',
  });

  @override
  bool isValid(String value) {
    final RegExp mobileRegex = RegExp(r"^[0-9]{1,255}$", multiLine: false);
    return mobileRegex.hasMatch(value);
  }
}

class URLValidator extends NonEmptyStringValidator {
  @override
  String emptyErrorText;

  @override
  String validationFailureText;

  @override
  String hintText;

  URLValidator({
    this.emptyErrorText = 'Website can\'t be empty',
    this.validationFailureText = 'Please provide a valid url',
    this.hintText = 'Website/Youtube Link. (Optional)',
  });

  @override
  bool isValid(String value) {
    final RegExp mobileRegex = RegExp(
        r"^(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+$",
        multiLine: false);
    return mobileRegex.hasMatch(value);
  }
}

class TextFieldValidator {
  final StringValidator emailValidator = EmailValidator();
  final StringValidator nameValidator = NameValidator();
  final StringValidator descriptionValidator = DescriptionValidator();
  final StringValidator phoneNumberValidator = PhoneNumberValidator();
  final StringValidator streetAddressValidator = StreetAddressValidator();
  final StringValidator numericValidator = NumericValidator();
  final StringValidator urlValidator = URLValidator();
  final StringValidator passwordValidator = PasswordValidator();
}
