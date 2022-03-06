import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bloc/firebase_sync/firebase_sync_bloc.dart';
import 'bloc/places/places_bloc.dart';
import 'data/repositories/firebase_places_repository.dart';
import 'data/repositories/local_places_repository.dart';
import 'helpers/routes.dart';
import 'localization/localizations.dart';
import 'ui/screens/tabs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalPlacesRepository lpr = LocalPlacesRepository();
    FirebasePlacesRepository fpr = FirebasePlacesRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlacesBloc>(create: (context) => PlacesBloc(lpr, fpr), lazy: false),
        BlocProvider<FirebaseSyncBloc>(create: (context) => FirebaseSyncBloc(lpr, fpr), lazy: false),
      ],
      child: MaterialApp(
        title: 'SaveThePlace',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TabsScreen(),
        routes: Routes.routesTable,
        localizationsDelegates: [
          CustomLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: CustomLocalizations.supportedLocales,
      ),
    );
  }
}
