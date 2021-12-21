import 'package:flutter/material.dart';
import 'package:holo_flutter_library/src/app/constants/palette.constant.dart';

class BatchSelectionButton extends StatelessWidget {
  const BatchSelectionButton({
    Key? key,
    this.isSelected = true,
    required this.press,
    required this.label,
  }) : super(key: key);

  final bool isSelected;
  final Function()? press;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: Colors.black54),
      ),
      elevation: isSelected ? 2 : 0,
      color: isSelected ? Palette.hlPrimaryLightColor : Colors.white,
      onPressed: press,
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.red : Palette.hlPrimaryColor,
          fontSize: 12,
        ),
      ),
    );
  }
}
