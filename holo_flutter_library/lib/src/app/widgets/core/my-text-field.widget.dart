/*
 * Created on Sun Feb 14 2021
 * Created by - 1: Chaman Mandal
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'package:flutter/material.dart';
import 'package:holo_flutter_library/src/app/constants/palette.constant.dart';
import 'package:holo_flutter_library/src/app/utils/validators/validators.dart';

import 'package:holo_flutter_library/src/app/widgets/core/my-text-field-container.widget.dart';

import 'my-editing-controller.dart';

///Others will not have any validation.
enum TextFieldType {
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

class HLTextField extends StatefulWidget with TextFieldValidator {
  final TextFieldType textFieldType;
  final bool mandatory;
  final HLEditingController? inputFieldController;
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

  HLTextField(
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
  _HLTextFieldState createState() => _HLTextFieldState();
}

class _HLTextFieldState extends State<HLTextField> {
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
    return HLTextFieldContainer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.labelText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Palette.hlPrimaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          TextField(
            obscureText:
                widget.textFieldType == TextFieldType.Password ? true : false,
            onChanged: _onChanged,
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
                  ? _textFieldErrorText
                  : widget.errorText,
            ),
            keyboardType: keyboardType(),
            textInputAction: textInputAction(),
            enabled: widget.editable,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
          ),
        ],
      ),
    );
  }

  IconData? icon() {
    if (widget.icon == null) {
      switch (widget.textFieldType) {
        case TextFieldType.Others:
          return null;
        case TextFieldType.Email:
          return Icons.email;
        case TextFieldType.Name:
          return Icons.verified_user;
        case TextFieldType.Description:
          return Icons.description;
        case TextFieldType.PhoneNumber:
          return Icons.phone;
        case TextFieldType.StreetAddress:
          return Icons.location_city;
        case TextFieldType.Numeric:
          return Icons.confirmation_number;
        case TextFieldType.URL:
          return Icons.web;
        case TextFieldType.Password:
          return Icons.lock;
        case TextFieldType.EmailPhoneNumber:
          return Icons.email;
        case TextFieldType.Calender:
          return Icons.calendar_today;
        case TextFieldType.Gender:
          return Icons.transgender;
        case TextFieldType.Roll:
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
        case TextFieldType.Others:
          return null;
        case TextFieldType.Email:
          return TextInputType.emailAddress;
        case TextFieldType.Name:
          return TextInputType.name;
        case TextFieldType.Description:
          return TextInputType.text;
        case TextFieldType.PhoneNumber:
          return TextInputType.phone;
        case TextFieldType.StreetAddress:
          return TextInputType.streetAddress;
        case TextFieldType.Numeric:
          return TextInputType.number;
        case TextFieldType.URL:
          return TextInputType.url;
        case TextFieldType.Password:
          return TextInputType.visiblePassword;
        case TextFieldType.EmailPhoneNumber:
          return TextInputType.emailAddress;
        case TextFieldType.Calender:
          // TODO: Handle this case.
          break;
        case TextFieldType.Gender:
          // TODO: Handle this case.
          break;
        case TextFieldType.Roll:
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
        case TextFieldType.Others:
          return null;
        case TextFieldType.Email:
          return widget.emailValidator.getHintText(_text);
        case TextFieldType.Name:
          return widget.nameValidator.getHintText(_text);
        case TextFieldType.Description:
          return widget.descriptionValidator.getHintText(_text);
        case TextFieldType.PhoneNumber:
          return widget.phoneNumberValidator.getHintText(_text);
        case TextFieldType.StreetAddress:
          return widget.streetAddressValidator.getHintText(_text);
        case TextFieldType.Numeric:
          return widget.numericValidator.getHintText(_text);
        case TextFieldType.URL:
          return widget.urlValidator.getHintText(_text);
        case TextFieldType.Password:
          return widget.passwordValidator.getHintText(_text);
        case TextFieldType.EmailPhoneNumber:
          return "Email/Phone number";
        case TextFieldType.Calender:
          // TODO: Handle this case.
          break;
        case TextFieldType.Gender:
          // TODO: Handle this case.
          break;
        case TextFieldType.Roll:
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
      case TextFieldType.Others:
        _validateOthers();
        break;
      case TextFieldType.Email:
        _validateEmail();
        break;
      case TextFieldType.Name:
        _validateName();
        break;
      case TextFieldType.Description:
        _validateDescription();
        break;
      case TextFieldType.PhoneNumber:
        _validatePhoneNumber();
        break;
      case TextFieldType.StreetAddress:
        _validateStreetAddress();
        break;
      case TextFieldType.Numeric:
        _validateNumeric();
        break;
      case TextFieldType.URL:
        _validateURL();
        break;
      case TextFieldType.Password:
        _validatePassword();
        break;
      case TextFieldType.EmailPhoneNumber:
        _validateEmailPhoneNumber();
        break;
      case TextFieldType.Calender:
        // TODO: Handle this case.
        break;
      case TextFieldType.Gender:
        // TODO: Handle this case.
        break;
      case TextFieldType.Roll:
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
