import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bloc/places/places_bloc.dart';
import 'data/repositories/local_places_repository.dart';
import 'helpers/routes.dart';
import 'localization/localizations.dart';
import 'ui/screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlacesBloc>(create: (context) => PlacesBloc(LocalPlacesRepository())),
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
