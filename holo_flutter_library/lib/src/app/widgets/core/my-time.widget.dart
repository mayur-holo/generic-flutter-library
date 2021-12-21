import 'package:flutter/material.dart';
import 'package:holo_flutter_library/src/app/utils/date.util.dart'
    as my_date_utils;
import 'package:holo_flutter_library/src/app/constants/palette.constant.dart';
import 'package:holo_flutter_library/src/app/widgets/core/my-text-field-container.widget.dart';

class TimePickerWidget extends StatefulWidget {
  final String? hintText;
  final TextEditingController? textController;
  final Function()? onTapFunction;
  const TimePickerWidget(
      {Key? key, this.hintText, this.textController, this.onTapFunction})
      : super(key: key);

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return HLTextFieldContainer(
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
