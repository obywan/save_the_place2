import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:save_the_place/bloc/firebase_sync/firebase_sync_bloc.dart';

import 'bloc/places/places_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlacesBloc>(create: (context) => PlacesBloc(lpr)),
        BlocProvider<FirebaseSyncBloc>(create: (context) => FirebaseSyncBloc(lpr)),
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
