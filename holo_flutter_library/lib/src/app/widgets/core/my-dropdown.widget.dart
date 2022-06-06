/*
 * Created on Fri Oct 01 2021
 * Created by - 1: Mayur Ranjan
 *
 * Copyright (c) 2021 Matrics Digital
 */

import 'package:holo_flutter_library/src/app/constants/palette.constant.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-dropdown-field-container.widget.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-editing-controller.dart';
import 'package:flutter/material.dart';

class MyDropdownField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final MyEditingController editingController;
  final Map<String, dynamic> paramItems;
  final Object? dropDownValue;
  final bool editable;
  final MyEditingController? inputFieldController;

  const MyDropdownField(
    this.paramItems,
    this.editingController, {
    Key? key,
    this.hintText = 'Select one of the options',
    this.labelText,
    this.icon,
    this.onChanged,
    this.dropDownValue,
    this.inputFieldController,
    this.editable = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyDropdownFieldState();
}

class _MyDropdownFieldState extends State<MyDropdownField> {
  @override
  Widget build(BuildContext context) {
    return MyDropdownFieldContainer(
      child: Column(
        children: [
          if (widget.labelText != null)
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.labelText as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Palette.hlPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          DropdownButtonFormField(
            onChanged: _onChanged,
            value: widget.dropDownValue,
            disabledHint: (widget.dropDownValue != null
                ? Text(widget.paramItems.entries
                    .firstWhere(
                        (element) => widget.dropDownValue == element.value)
                    .key)
                : Text("")),
            decoration: InputDecoration(
              icon: Icon(
                widget.icon,
                color: Palette.hlPrimaryColor,
              ),
              hintText: widget.hintText,
              border: InputBorder.none,
            ),
            items: widget.editable
                ? widget.paramItems.entries
                    .map((entry) => DropdownMenuItem<String>(
                          value: entry.value,
                          child: Text(entry.key),
                        ))
                    .toList()
                : null,
          ),
        ],
      ),
    );
  }

  _onChanged(value) {
    widget.editingController.isValid = true;
    widget.editingController.text = value;

    if (mounted) {
      setState(() {});
    }

    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }
}
