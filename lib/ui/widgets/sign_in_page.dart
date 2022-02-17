import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatelessWidget {
  final Function setStateCallback;
  const SignInPage({Key? key, required this.setStateCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(onPressed: () => signInWithGoogle(), icon: Icon(Icons.account_circle), label: Text('Sing in')),
    );
  }

  Future<void> signInWithGoogle() async {
    setStateCallback(true);
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      setStateCallback(false);
      return null;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

    if (googleAuth == null) {
      setStateCallback(false);
      return null;
    }

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    setStateCallback(false);
  }
}
