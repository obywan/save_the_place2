import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../bloc/firebase_sync/firebase_sync_bloc.dart';

class UserPage extends StatelessWidget {
  final Function stateSetterCallback;

  const UserPage({Key? key, required this.stateSetterCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        SizedBox(height: 16),
        TextButton.icon(
          onPressed: signOut,
          label: Text('Sign out'),
          icon: Icon(Icons.logout_rounded),
        ),
      ],
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    stateSetterCallback(false);
  }
}
