import 'package:flutter/material.dart';
import 'places_list_screen.dart';
import '../widgets/places_list.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedTab = 0;

  Widget _getChild() {
    switch (_selectedTab) {
      case 0:
        return LocationsListScreen();
      case 1:
        return Container(
          color: Colors.green,
        );
      case 2:
        return Container(
          color: Colors.blue,
        );

      default:
        return Container(
          color: Colors.amber,
        );
    }
  }

  BottomNavigationBarItem _getNavBarItem(String name, IconData iconData) {
    return BottomNavigationBarItem(icon: Icon(iconData), label: name);
  }

  void _selectTab(int tabIndex) {
    setState(() {
      _selectedTab = tabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(child: _getChild()),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            _getNavBarItem('Saved', Icons.list),
            _getNavBarItem('Compass', Icons.compass_calibration),
            _getNavBarItem('Settings', Icons.settings),
          ],
          onTap: _selectTab,
          currentIndex: _selectedTab,
        ),
      ),
    );
  }
}
