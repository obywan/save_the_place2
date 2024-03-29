import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../localization/localizations.dart';
import '../widgets/spinny_thing.dart';

import '../widgets/sign_in_page.dart';
import '../widgets/user_page.dart';

class AuthScreen extends StatefulWidget {
  static const String route = '/auth_screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final trns = CustomLocalizations.of(context);
    FirebaseAuth auth = FirebaseAuth.instance;
    // FirebaseSyncHelper firebaseSyncHelper = FirebaseSyncHelper(LocalPlacesRepository());
    return Scaffold(
      appBar: AppBar(
        title: Text(trns.pageTitles.accountPageTitle),
      ),
      body: _getContent(auth),
    );
  }

  Widget _getContent(FirebaseAuth auth) => _loading
      ? SpinnyThing()
      : (auth.currentUser != null
          ? UserPage(
              stateSetterCallback: setLoading,
              user: auth.currentUser!,
            )
          : SignInPage(setStateCallback: setLoading));

  void setLoading(bool b) {
    setState(() {
      _loading = b;
    });
  }
}
