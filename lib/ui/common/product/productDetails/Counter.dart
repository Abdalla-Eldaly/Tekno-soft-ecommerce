import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../my_theme.dart';

class CounterWidget extends StatelessWidget {
  final int counter;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  CounterWidget({
    required this.counter,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0), // Adjust the radius as needed
      child: Container(
        color: MyTheme.BottonColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.white),
              onPressed: onDecrement,
            ),
            SizedBox(width: 6.0),
            Text(
              '$counter',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            SizedBox(width: 6.0),
            IconButton(
              icon: Icon(Icons.add_circle, color: Colors.white),
              onPressed: onIncrement,
            ),
          ],
        ),
      ),
    );
  }
}
