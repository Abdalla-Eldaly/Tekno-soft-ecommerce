import 'package:flutter/material.dart';

class BottomNavIcon extends StatelessWidget {
  String iconName;
  bool isSelected;
  BottomNavIcon({required this.iconName, required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return isSelected?
    Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24)
      ),
      child: ImageIcon(AssetImage(
        'assets/images/$iconName.png'),
      color: Theme.of(context).primaryColor,
      ),
    ): Container(
      padding: EdgeInsets.all(4),
      child: ImageIcon(AssetImage(
          'assets/images/$iconName.png'),
        color: Colors.white,),
    )
    ;
  }
}
