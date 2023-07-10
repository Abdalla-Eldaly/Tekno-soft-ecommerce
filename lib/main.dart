import 'package:ecommerce_c8_online/di/di.dart';
import 'package:ecommerce_c8_online/provider/auth_provider.dart';
import 'package:ecommerce_c8_online/ui/home/home_screen.dart';
import 'package:ecommerce_c8_online/ui/login/login_screen.dart';
import 'package:ecommerce_c8_online/ui/my_theme.dart';
import 'package:ecommerce_c8_online/ui/register/register_screen.dart';
import 'package:ecommerce_c8_online/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  configureDependencies();
  runApp(BlocProvider(
      create: (context) {
        return UserProvider();
      },
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent
        ),

        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0
        ),
        primaryColor: MyTheme.primaryColor,
        textTheme: const TextTheme(
            labelLarge: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: MyTheme.primaryColor),
            labelMedium: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: MyTheme.primaryColor),
            labelSmall: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: MyTheme.primaryColor),
            bodyMedium : TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: MyTheme.primaryColor
            )
        ),
      ),
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
