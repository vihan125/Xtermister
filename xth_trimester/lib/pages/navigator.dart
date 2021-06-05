import 'package:flutter/material.dart';
import 'package:xth_trimester/pages/calculator.dart';
import 'package:xth_trimester/pages/calender.dart';
import 'package:xth_trimester/pages/home.dart';

class MyNavigator extends StatefulWidget {
  @override
  _MyNavigatorState createState() => _MyNavigatorState();
}

class _MyNavigatorState extends State<MyNavigator> {


  int _selectedIndex = 0;
  PageController _pageController = PageController();
  List<Widget> _screens = [Home(),Calender(),Calculator(),];
  void _onPageChanged(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.cyan[500],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items:[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home") ,
              backgroundColor: Colors.cyan[200]
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text("Calender") ,
              backgroundColor: Colors.cyan[200]
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.exposure),
              title: Text("Calculator") ,
              backgroundColor: Colors.cyan[200]
          )
        ],
      ),
    );
  }
}


