import 'package:flutter/material.dart';

class LoginRequired extends StatelessWidget {
  String message;
  VoidCallback voidCallBack;
   LoginRequired(this.message,this.voidCallBack,{super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          ElevatedButton(onPressed: voidCallBack, child: Text("Login"))
        ],
      ),
    );
  }
}
