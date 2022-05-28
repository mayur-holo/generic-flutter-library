import 'package:flutter/material.dart';
import 'package:holo_flutter_library/src/app/utils/date.util.dart'
    as my_date_utils;
import 'package:holo_flutter_library/src/app/constants/palette.constant.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-text-field-container.widget.dart';

class MyTimePickerWidget extends StatefulWidget {
  final String? hintText, labelText;
  final TextEditingController? textController;
  final Function()? onTapFunction;

  const MyTimePickerWidget({
    Key? key,
    this.hintText,
    this.labelText,
    this.textController,
    this.onTapFunction,
  }) : super(key: key);

  @override
  _MyTimePickerWidgetState createState() => _MyTimePickerWidgetState();
}

class _MyTimePickerWidgetState extends State<MyTimePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return MyTextFieldContainer(
      child: TextFormField(
        readOnly: true,
        onTap: () {
          _onTap(context);
        },
        cursorColor: Palette.hlPrimaryColor,
        controller: widget.textController,
        decoration: InputDecoration(
          icon: const Icon(
            Icons.timelapse_rounded,
            color: Palette.hlPrimaryColor,
          ),
          hintText: widget.hintText,
          labelText: widget.labelText,
          border: InputBorder.none,
        ),
      ),
    );
  }

  _onTap(BuildContext context) async {
    TimeOfDay time = TimeOfDay.now();
    FocusScope.of(context).requestFocus(FocusNode());
    final now = DateTime.now();
    TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: time);
    widget.textController!.text =
        DateTime(now.year, now.month, now.day, picked!.hour, picked.minute)
            .toString();
    setState(() {
      time = picked;
    });
    if (widget.textController!.text != "") {
      widget.textController!.text =
          my_date_utils.DateUtils.getClockDateTimeAsString(
              dateTime: DateTime.parse(widget.textController!.text));
    }
    widget.onTapFunction!();
  }
}
