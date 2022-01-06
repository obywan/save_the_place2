import 'package:flutter/material.dart';
import 'package:save_the_place/helpers/permission_helper.dart';
import 'package:save_the_place/ui/widgets/spinny_thing.dart';
import '../tabs/settings_screen.dart';

import '../../localization/localizations.dart';
import '../tabs/compass_screen.dart';
import '../tabs/places_list_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedTab = 0;

  Widget _getTab() {
    switch (_selectedTab) {
      case 0:
        return LocationsListScreen();
      case 1:
        return CompassScreen();
      case 2:
        return SettingsScreen();

      default:
        return Container(
          color: Colors.amber,
        );
    }
  }

  Widget _getChild() {
    return FutureBuilder<LocationPermissionStatus>(
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data) {
              case LocationPermissionStatus.Alright:
                return _getTab();
              case LocationPermissionStatus.Denied:
                return Text('We need location permission to proceed');
              case LocationPermissionStatus.DeniedForever:
                return Text('We need location permission to proceed');
              case LocationPermissionStatus.NotEnabled:
                return Text('We need location enabled to proceed');
              case null:
                return Text('This was not supposed to happen');
            }
          }
          return SpinnyThing();
        },
        future: PermissionHelper.checkPermissions());
  }

  String _getTabName() {
    final translations = CustomLocalizations.of(context);
    switch (_selectedTab) {
      case 0:
        return translations.pageTitles.homePageTitle;
      case 1:
        return translations.pageTitles.compassPageTitle;
      case 2:
        return 'Settings';

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
