import 'package:flutter/material.dart';

import '../../localization/localizations.dart';
import 'compass_screen.dart';
import 'places_list_screen.dart';

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
        return CompassScreen();
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

  String _getTabName() {
    final translations = CustomLocalizations.of(context);
    switch (_selectedTab) {
      case 0:
        return translations.pageTitles.homePageTitle;
      case 1:
        return translations.pageTitles.compassPageTitle;
      case 2:
        return 'Tab3';

      default:
        return 'Noooooo';
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
        appBar: AppBar(
          title: Text(_getTabName()),
        ),
        body: _getChild(),
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
