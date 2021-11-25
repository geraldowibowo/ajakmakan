import 'package:flutter/material.dart';

import 'Explore/screens/home_explore/explore_home.dart';
import 'Orders/screens/Order_Screen.dart';
import 'Profile/screens/profile_home.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabscreen';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 50,
        child: BottomNavigationBar(
          elevation: 1,
          onTap: _selectPage,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black.withOpacity(0.4),
          selectedItemColor: Colors.black,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          iconSize: 22,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                // ignore: deprecated_member_use
                title: Text('Explore')),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
                // ignore: deprecated_member_use
                title: Text('Pesanan')),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                // ignore: deprecated_member_use
                title: Text('Profil')),
          ],
        ),
      ),
      body: IndexedStack(
        children: [
          ExploreHome(),
          OrderScreen(),
          ProfileHome(),
        ],
        index: _selectedPageIndex,
      ),
    );
  }
}
