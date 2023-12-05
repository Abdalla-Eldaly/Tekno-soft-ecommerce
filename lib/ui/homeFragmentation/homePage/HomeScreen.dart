import 'package:esayshop/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../provider/currentprovider.dart';
import '../../CategoryFragmentation/CategoryTab.dart';
import '../../PersonFragmentation/PersonTab.dart';
import '../../common/product/productDetails/productDetails.dart';
import '../../wishListFragmentation/WishList.dart';
import 'BottomNavIcon.dart';
import 'HomeTab/HomeTab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  TextEditingController search = TextEditingController();
  String query = '';
  int cartCounter = 0;

  void _updateCartCounter(int newCounter) {
    setState(() {
      cartCounter = newCounter;
    });
  }

  @override
  Widget build(BuildContext context) {
    CounterProvider counterProvider = Provider.of<CounterProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            toolbarHeight: 60,
            elevation: 0,
            title: TextFormField(
              cursorColor: Colors.white,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 21,
              ),
              controller: search,
              onChanged: (String value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: 32,
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      query = '';
                      search.clear();
                    });
                  },
                  icon: Icon(
                    Icons.close,
                    size: 32,
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // Handle shopping cart icon tap
                },
                icon: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.shopping_cart_outlined, size: 32),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          '${counterProvider.counter}',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            SalomonBottomBarItem(

              icon: Icon(Icons.home,size: 30,),

              title: Text('Home'),
              selectedColor: Colors.white,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.category,size: 30,),
              title: Text('Categories'),
              selectedColor: Colors.white,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.favorite,size: 30,),
              title: Text('Favorites'),
              selectedColor: Colors.white,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.account_circle,size: 30,),
              title: Text('Account'),
              selectedColor: Colors.white,
            ),
          ],
          selectedItemColor: Colors.white, // Customize the selected item color
          unselectedItemColor: Colors.white, // Customize the unselected item color
          backgroundColor:MyTheme.BottonColor, // Customize the bottom bar background color
          itemPadding: EdgeInsets.all(7),
        ),
        body: tabs[selectedIndex],
      ),
    );
  }

  List<Widget> tabs = [
    HomeTab(),
    CategoryTab(),
    WishListTab(),
    PersonTab(),
  ];
}
