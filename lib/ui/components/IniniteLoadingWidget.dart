import 'package:flutter/material.dart';

class InifiniteLoadingWidget extends StatelessWidget {
  String loadingMessage;
  InifiniteLoadingWidget(this.loadingMessage, {super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          children: [
          const CircularProgressIndicator(),
      Text(loadingMessage)
      ],
    ),
    );
  }
}
