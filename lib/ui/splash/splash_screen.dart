import 'package:ecommerce_c8_online/ui/login/login_screen.dart';
import 'package:ecommerce_c8_online/ui/register/register_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash';
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Image.asset('assets/images/splash_screen.png',
      fit: BoxFit.fill,
      width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
