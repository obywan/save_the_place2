import 'package:flutter/material.dart';

import '../ui/screens/auth_screen.dart';
import '../ui/screens/place_add_screen.dart';
import '../ui/screens/place_details_screen.dart';
import '../ui/screens/place_direction_screen.dart';
import '../ui/tabs/places_list_screen.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routesTable = {
    LocationsListScreen.route: (context) => LocationsListScreen(),
    PlaceAddScreen.route: (context) => PlaceAddScreen(),
    PlaceDetailsScreen.route: (context) => PlaceDetailsScreen(),
    PlaceDirectionScreen.route: (context) => PlaceDirectionScreen(),
    AuthScreen.route: (context) => AuthScreen(),
  };
}
