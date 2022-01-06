import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:save_the_place/data/repositories/local_places_repository.dart';
import 'package:save_the_place/data/repositories/place_repository.dart';
import 'package:save_the_place/helpers/firebase_sync_helper.dart';

class AuthScreen extends StatelessWidget {
  static const String route = '/auth_screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: auth.currentUser != null ? _userDetails() : _getButton(),
    );
  }

  Widget _userDetails() {
    PlacesRepository pr = LocalPlacesRepository();
    FirebaseSyncHelper firebaseSyncHelper = FirebaseSyncHelper(pr);
    return Column(
      children: [
        Text(FirebaseAuth.instance.currentUser!.displayName ?? 'unknown'),
        TextButton(
            onPressed: () {
              firebaseSyncHelper.sync();
            },
            child: Text('Sync data')),
      ],
    );
  }

  Widget _getButton() {
    return Center(
      child: TextButton.icon(onPressed: () => _signInWithGoogle(), icon: Icon(Icons.account_circle), label: Text('Sing in')),
    );
  }

  Future _signInWithGoogle() async {
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
