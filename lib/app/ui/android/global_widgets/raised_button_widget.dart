import 'package:flutter/material.dart';

class RaisedButtonWidget extends StatelessWidget {

  final IconData iconData;
  final String label;
  final Function onPressed;

  RaisedButtonWidget({this.iconData, this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton .icon(
      icon: Icon(iconData),
      label: Text(label),
      onPressed: onPressed,
    );
  }
}
