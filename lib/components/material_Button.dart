import 'package:flutter/material.dart';

class materialButton extends StatelessWidget {
  materialButton(
      {@required this.colors, @required this.onPress, @required this.text});

  Function onPress;
  String text;
  Color colors;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: colors,
        borderRadius: BorderRadius.circular(30),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPress,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          minWidth: 200,
          height: 42,
        ),
      ),
    );
  }
}
