import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'data/repositories/local_places_repository.dart';
import 'data/repositories/place_repository.dart';
import 'helpers/app_settings.dart';
import 'ui/widgets/app_builder.dart';

import 'bloc/firebase_sync/firebase_sync_bloc.dart';
import 'bloc/places/places_bloc.dart';
import 'data/repositories/firebase_places_repository.dart';
import 'helpers/routes.dart';
import 'localization/localizations.dart';
import 'ui/screens/tabs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppSettings.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // LocalPlacesRepository lpr = LocalPlacesRepository();
    // PlacesRepository lpr = FakePlacesRepository();
    PlacesRepository lpr = LocalPlacesRepository();
    FirebasePlacesRepository fpr = FirebasePlacesRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlacesBloc>(create: (context) => PlacesBloc(lpr, fpr), lazy: false),
        BlocProvider<FirebaseSyncBloc>(create: (context) => FirebaseSyncBloc(lpr, fpr), lazy: false),
      ],
      child: AppBuilder(
        builder: (context) => AdaptiveTheme(
          light: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
          ),
          dark: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
          ),
          initial: AdaptiveThemeMode.light,
          builder: (theme, darkTheme) => MaterialApp(
            title: 'PointMe',
            theme: darkTheme,
            home: TabsScreen(),
            routes: Routes.routesTable,
            localizationsDelegates: [
              CustomLocalizations.delegate,
              ...GlobalMaterialLocalizations.delegates,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: CustomLocalizations.supportedLocales,
            locale: AppSettings.selectedLang,
          ),
        ),
      ),
    );
  }
}
