import 'package:ecommerce_c8_online/ui/home/bottom_nav_icon.dart';
import 'package:ecommerce_c8_online/ui/home/tabs/home_tab/home_tab.dart';
import 'package:ecommerce_c8_online/ui/my_theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(width:1,
                          color:Theme.of(context).primaryColor)
                    ),
                    child: TextField())
            ), ImageIcon(
              AssetImage('assets/images/ic_cart.png'),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index){
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: BottomNavIcon(
              iconName: 'ic_home',isSelected: true,
            ),label: ''),
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: BottomNavIcon(
              iconName: 'ic_categories',isSelected: true,
            ),label: ''),
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: BottomNavIcon(
              iconName: 'ic_favorites',isSelected: true,
            ),label: ''),
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: BottomNavIcon(
              iconName: 'ic_account',isSelected: true,
            ),label: ''),
          ],
        ),
      ),
      body: HomeTab(),
    );
  }
}
