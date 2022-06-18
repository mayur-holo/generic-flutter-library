/*
 * Created on Sun Feb 14 2021
 * Created by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'package:flutter/material.dart';
import 'package:holo_flutter_library/my_widget.lib.dart';
import 'package:holo_flutter_library/src/app/constants/palette.constant.dart';
import 'package:holo_flutter_library/src/app/utils/validators/validators.dart';

///Others will not have any validation.
enum MyTextFieldType {
  Others,
  Email,
  Name,
  Description,
  PhoneNumber,
  StreetAddress,
  Numeric,
  URL,
  Password,
  EmailPhoneNumber,
  Calender,
  Gender,
  Roll,
}

class MyTextField extends StatefulWidget with TextFieldValidator {
  final MyTextFieldType textFieldType;
  final bool mandatory;
  final MyEditingController? inputFieldController;
  final String hintText;
  final String labelText;
  final String? border;
  final String errorText;
  final String validationFailureText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final bool validate;
  final bool editable;
  final int minLines;
  final int maxLines;

  MyTextField(
    this.textFieldType, {
    Key? key,
    this.mandatory = true,
    this.inputFieldController,
    this.hintText = '',
    this.labelText = '',
    this.border,
    this.errorText = '',
    this.validationFailureText = '',
    this.icon,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.validate = true,
    this.editable = true,
    this.minLines = 1,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  String get _text => widget.inputFieldController!.text;
  bool get _defaultValue => widget.inputFieldController!.defaultValue;
  String _textFieldErrorText = '';

  void _validateOthers() {}

  void _validateEmail() {
    _textFieldErrorText = widget.emailValidator.getErrorText(
        _text,
        widget.mandatory,
        widget.errorText,
        widget.validationFailureText,
        _defaultValue);
  }

  void _validateName() {
    _textFieldErrorText = widget.nameValidator.getErrorText(
        _text,
        widget.mandatory,
        widget.errorText,
        widget.validationFailureText,
        _defaultValue);
  }

  void _validateDescription() {
    _textFieldErrorText = widget.descriptionValidator.getErrorText(
        _text,
        widget.mandatory,
        widget.errorText,
        widget.validationFailureText,
        _defaultValue);
  }

  void _validatePhoneNumber() {
    _textFieldErrorText = widget.phoneNumberValidator.getErrorText(
        _text,
        widget.mandatory,
        widget.errorText,
        widget.validationFailureText,
        _defaultValue);
  }

  void _validateStreetAddress() {
    _textFieldErrorText = widget.streetAddressValidator.getErrorText(
        _text,
        widget.mandatory,
        widget.errorText,
        widget.validationFailureText,
        _defaultValue);
  }

  void _validateNumeric() {
    _textFieldErrorText = widget.numericValidator.getErrorText(
        _text,
        widget.mandatory,
        widget.errorText,
        widget.validationFailureText,
        _defaultValue);
  }

  void _validateURL() {
    _textFieldErrorText = widget.urlValidator.getErrorText(
        _text,
        widget.mandatory,
        widget.errorText,
        widget.validationFailureText,
        _defaultValue);
  }

  void _validatePassword() {
    _textFieldErrorText = widget.passwordValidator.getErrorText(
        _text,
        widget.mandatory,
        widget.errorText,
        widget.validationFailureText,
        _defaultValue,
        validate: widget.validate);
  }

  void _validateEmailPhoneNumber() {
    if (_text.isNotEmpty) {
      if (widget.emailValidator.isValid(_text)) {
        _textFieldErrorText = '';
      } else if (widget.phoneNumberValidator.isValid(_text)) {
        _textFieldErrorText = '';
      } else {
        _textFieldErrorText = "Email/Mobile is not valid";
      }
    } else {
      _textFieldErrorText = "Email/Mobile cannot be empty";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyTextFieldContainer(
      child: Column(
        children: [
          widget.labelText.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.labelText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Palette.hlPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : const SizedBox(),
          SizedBox(
            height:
                widget.errorText.isNotEmpty || _textFieldErrorText.isNotEmpty
                    ? 40.0
                    : 30.0,
            child: TextField(
              obscureText: widget.textFieldType == MyTextFieldType.Password
                  ? true
                  : false,
              onChanged: _onChanged,
              autocorrect: true,
              readOnly: !widget.editable,
              style: TextStyle(
                color: widget.editable ? Colors.black : Colors.grey,
              ),
              cursorColor: Palette.hlPrimaryColor,
              controller: widget.inputFieldController,
              decoration: InputDecoration(
                icon: Icon(
                  icon(),
                  color: Palette.hlPrimaryColor,
                ),
                hintText: hintText(),
                border: InputBorder.none,
                errorText: (widget.errorText.isEmpty)
                    ? _textFieldErrorText.isEmpty
                        ? null
                        : _textFieldErrorText
                    : widget.errorText,
              ),
              keyboardType: keyboardType(),
              textInputAction: textInputAction(),
              minLines: widget.minLines,
              maxLines: widget.maxLines,
            ),
          ),
        ],
      ),
    );
  }

  IconData? icon() {
    if (widget.icon == null) {
      switch (widget.textFieldType) {
        case MyTextFieldType.Others:
          return null;
        case MyTextFieldType.Email:
          return Icons.email;
        case MyTextFieldType.Name:
          return Icons.verified_user;
        case MyTextFieldType.Description:
          return Icons.description;
        case MyTextFieldType.PhoneNumber:
          return Icons.phone;
        case MyTextFieldType.StreetAddress:
          return Icons.location_city;
        case MyTextFieldType.Numeric:
          return Icons.confirmation_number;
        case MyTextFieldType.URL:
          return Icons.web;
        case MyTextFieldType.Password:
          return Icons.lock;
        case MyTextFieldType.EmailPhoneNumber:
          return Icons.email;
        case MyTextFieldType.Calender:
          return Icons.calendar_today;
        case MyTextFieldType.Gender:
          return Icons.transgender;
        case MyTextFieldType.Roll:
          return Icons.camera_roll;
      }
    } else {
      return widget.icon;
    }
  }

  TextInputAction? textInputAction() {
    if (widget.textInputAction == null) {
      return TextInputAction.next;
    } else {
      return widget.textInputAction;
    }
  }

  TextInputType? keyboardType() {
    if (widget.keyboardType == null) {
      switch (widget.textFieldType) {
        case MyTextFieldType.Others:
          return null;
        case MyTextFieldType.Email:
          return TextInputType.emailAddress;
        case MyTextFieldType.Name:
          return TextInputType.name;
        case MyTextFieldType.Description:
          return TextInputType.text;
        case MyTextFieldType.PhoneNumber:
          return TextInputType.phone;
        case MyTextFieldType.StreetAddress:
          return TextInputType.streetAddress;
        case MyTextFieldType.Numeric:
          return TextInputType.number;
        case MyTextFieldType.URL:
          return TextInputType.url;
        case MyTextFieldType.Password:
          return TextInputType.visiblePassword;
        case MyTextFieldType.EmailPhoneNumber:
          return TextInputType.emailAddress;
        case MyTextFieldType.Calender:
          // TODO: Handle this case.
          break;
        case MyTextFieldType.Gender:
          // TODO: Handle this case.
          break;
        case MyTextFieldType.Roll:
          // TODO: Handle this case.
          break;
      }
    } else {
      return widget.keyboardType;
    }
    return null;
  }

  String? hintText() {
    if (widget.hintText.isEmpty) {
      switch (widget.textFieldType) {
        case MyTextFieldType.Others:
          return null;
        case MyTextFieldType.Email:
          return widget.emailValidator.getHintText(_text);
        case MyTextFieldType.Name:
          return widget.nameValidator.getHintText(_text);
        case MyTextFieldType.Description:
          return widget.descriptionValidator.getHintText(_text);
        case MyTextFieldType.PhoneNumber:
          return widget.phoneNumberValidator.getHintText(_text);
        case MyTextFieldType.StreetAddress:
          return widget.streetAddressValidator.getHintText(_text);
        case MyTextFieldType.Numeric:
          return widget.numericValidator.getHintText(_text);
        case MyTextFieldType.URL:
          return widget.urlValidator.getHintText(_text);
        case MyTextFieldType.Password:
          return widget.passwordValidator.getHintText(_text);
        case MyTextFieldType.EmailPhoneNumber:
          return "Email/Phone number";
        case MyTextFieldType.Calender:
          // TODO: Handle this case.
          break;
        case MyTextFieldType.Gender:
          // TODO: Handle this case.
          break;
        case MyTextFieldType.Roll:
          // TODO: Handle this case.
          break;
      }
    } else {
      return widget.hintText;
    }
    return null;
  }

  _onChanged(value) {
    switch (widget.textFieldType) {
      case MyTextFieldType.Others:
        _validateOthers();
        break;
      case MyTextFieldType.Email:
        _validateEmail();
        break;
      case MyTextFieldType.Name:
        _validateName();
        break;
      case MyTextFieldType.Description:
        _validateDescription();
        break;
      case MyTextFieldType.PhoneNumber:
        _validatePhoneNumber();
        break;
      case MyTextFieldType.StreetAddress:
        _validateStreetAddress();
        break;
      case MyTextFieldType.Numeric:
        _validateNumeric();
        break;
      case MyTextFieldType.URL:
        _validateURL();
        break;
      case MyTextFieldType.Password:
        _validatePassword();
        break;
      case MyTextFieldType.EmailPhoneNumber:
        _validateEmailPhoneNumber();
        break;
      case MyTextFieldType.Calender:
        // TODO: Handle this case.
        break;
      case MyTextFieldType.Gender:
        // TODO: Handle this case.
        break;
      case MyTextFieldType.Roll:
        // TODO: Handle this case.
        break;
    }
    widget.inputFieldController!.isValid = _textFieldErrorText == '';
    widget.inputFieldController!.validationErrorMessage = _textFieldErrorText;

    setState(() {});
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }
}
