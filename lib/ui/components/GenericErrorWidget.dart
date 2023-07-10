import 'package:flutter/material.dart';

class GenericErrorWidget extends StatelessWidget {
  String errorMessage;
  String? actionName;
  VoidCallback? action;
  GenericErrorWidget(this.errorMessage, {this.actionName,this.action,super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          children: [
            Text(errorMessage),
            actionName!=null?ElevatedButton(onPressed: action,
                child: Text(actionName!)):Container()
      ]
    ),
    );
  }
}
