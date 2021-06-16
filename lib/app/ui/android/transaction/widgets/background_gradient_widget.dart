import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
          colors: [
            Color(0xff000000),
            Color(0xff2C3E50),
            // Color(0xff00416A),
            // Color(0xffE4E5E6),
          ],
        ),
      ),
    );
  }
}
