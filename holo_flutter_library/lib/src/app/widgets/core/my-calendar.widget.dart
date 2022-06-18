/*
 * Created on Sat Feb 06 2021
 * Created by - 3: Mayur Ranjan
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */
import 'package:flutter/material.dart';
import 'package:holo_flutter_library/src/app/constants/palette.constant.dart';
import 'package:holo_flutter_library/src/app/constants/static.constant.dart';
import 'package:holo_flutter_library/src/app/utils/date.util.dart'
    as my_date_utils;
import 'package:holo_flutter_library/src/app/widgets/core/my-editing-controller.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-text-field-container.widget.dart';
import 'package:intl/intl.dart';

class MyCalendar extends StatefulWidget {
  final IconData? icon;
  final String? hintText;
  final String? labelText;
  final MyEditingController? textController;
  final Function? onTapFunction;
  final DateTime? startDateTime;
  final DateTime? firstDateTime;
  final DateTime? lastDateTime;
  final bool? editable;

  const MyCalendar({
    Key? key,
    this.icon = Icons.calendar_today,
    this.hintText,
    this.labelText = '',
    this.textController,
    this.onTapFunction,
    this.startDateTime,
    this.firstDateTime,
    this.lastDateTime,
    this.editable = true,
  }) : super(key: key);

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class DateOfBirthCalendar extends MyCalendar {
  final String? hintText;
  final String? labelText;
  final MyEditingController? textController;
  final Function? onTapFunction;
  final bool? editable;

  static final DateTime defaultFirstDateTime =
      my_date_utils.DateUtils.getAfterOrBeforeDate(
          type: my_date_utils.DateType.isBefore, years: 100);
  static final DateTime defaultLastDateTime =
      my_date_utils.DateUtils.getAfterOrBeforeDate(
          type: my_date_utils.DateType.isBefore, years: 2);

  DateOfBirthCalendar({
    Key? key,
    IconData? icon,
    this.hintText = Static.dobHintMessage,
    this.labelText = '',
    this.textController,
    this.onTapFunction,
    DateTime? firstDateTime,
    DateTime? lastDateTime,
    DateTime? startDateTime,
    this.editable = true,
  }) : super(
            key: key,
            icon: icon = Icons.calendar_today,
            hintText: hintText,
            labelText: labelText,
            textController: textController,
            onTapFunction: onTapFunction,
            startDateTime: startDateTime,
            firstDateTime: firstDateTime = defaultFirstDateTime,
            lastDateTime: lastDateTime = defaultLastDateTime);

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  @override
  Widget build(BuildContext context) {
    return MyTextFieldContainer(
      child: Column(
        children: [
          widget.labelText!.isNotEmpty
              ? Padding(
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
                )
              : const SizedBox(),
          SizedBox(
            height: 28.0,
            child: TextFormField(
              readOnly: !widget.editable!,
              onTap: () {
                if (widget.editable!) {
                  _onTap(context);
                }
              },
              style: TextStyle(
                color: widget.editable! ? Colors.black : Colors.grey,
              ),
              cursorColor: Palette.hlPrimaryColor,
              controller: widget.textController,
              decoration: InputDecoration(
                icon: Icon(
                  widget.icon,
                  color: Palette.hlPrimaryColor,
                ),
                hintText: widget.hintText,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onTap(BuildContext context) async {
    DateTime? currentDateTime = widget.startDateTime ?? widget.lastDateTime;

    final DateTime? selectedDateTime = await showDatePicker(
      context: context,
      initialDate: currentDateTime as DateTime, // Refer step 1
      firstDate: widget.firstDateTime as DateTime,
      lastDate: widget.lastDateTime as DateTime,
    );
    if (selectedDateTime != currentDateTime) {
      setState(() {
        currentDateTime = selectedDateTime;
        final DateFormat _formatter = DateFormat('dd-MMM-yyyy');
        final String _formatted =
            _formatter.format(selectedDateTime as DateTime);
        widget.textController!.text = _formatted;
        widget.textController!.isValid = true;
      });
    }
    return widget.onTapFunction;
  }
}
