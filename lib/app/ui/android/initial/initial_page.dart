import 'package:despesas_pessoais/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashscreen/splashscreen.dart';

class InitialPage extends GetWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SplashScreen(
            gradientBackground: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                // Color(0xff00416A),
                // Color(0xff00416A),
                Color(0xff000000),
                Color(0xff2C3E50),
                // Color(0xff003973),
                // Color(0xffE5E5BE),
                // Color(0xff8E0E00),
                // Color(0xff1F1C18),
              ],
            ),
            seconds: 5,
            image: Image.asset('assets/images/logo.png'),
            title: Text(
              'Despesas Pessoais',
              style: TextStyle(fontSize: 28),
            ),
            navigateAfterSeconds: Routes.TRANSACTION,
          ),
        ],
      ),
    );
  }
}
