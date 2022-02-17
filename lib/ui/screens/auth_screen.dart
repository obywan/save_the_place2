import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:save_the_place/bloc/firebase_sync/firebase_sync_bloc.dart';

import '../../data/repositories/local_places_repository.dart';
import '../../helpers/firebase_sync_helper.dart';

class AuthScreen extends StatelessWidget {
  static const String route = '/auth_screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    // FirebaseSyncHelper firebaseSyncHelper = FirebaseSyncHelper(LocalPlacesRepository());
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Center(
        child: auth.currentUser != null ? _userDetails(context) : _getButton(),
      ),
    );
  }

  Widget _userDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Signed in as:'),
        SizedBox(height: 8),
        Text(
          FirebaseAuth.instance.currentUser!.displayName ?? 'unknown',
          style: Theme.of(context).textTheme.headline5,
        ),
        TextButton.icon(
          onPressed: () {
            BlocProvider.of<FirebaseSyncBloc>(context, listen: false).add(SyncPlaces());
          },
          label: Text('Sync data'),
          icon: Icon(Icons.sync),
        ),
      ],
    );
  }

  Widget _getButton() {
    return Center(
      child: TextButton.icon(onPressed: () => signInWithGoogle(), icon: Icon(Icons.account_circle), label: Text('Sing in')),
    );
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

    if (googleAuth == null) return null;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
