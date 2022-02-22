import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/firebase_sync/firebase_sync_bloc.dart';
import 'spinny_thing.dart';

class UserPage extends StatelessWidget {
  final Function stateSetterCallback;
  final User user;

  const UserPage({Key? key, required this.stateSetterCallback, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseSyncBloc fbc = BlocProvider.of<FirebaseSyncBloc>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Signed in as:'),
        SizedBox(height: 8),
        Text(
          user.displayName ?? 'unknown',
          style: Theme.of(context).textTheme.headline5,
        ),
        BlocConsumer<FirebaseSyncBloc, FirebaseSyncState>(
          bloc: fbc,
          listener: (context, state) {
            if (state is FirebaseSyncError) {
              _showMessage(context, -1);
            } else if (state is FirebaseSyncReady) {
              _showMessage(context, 1);
            }
          },
          builder: (context, state) {
            if (state is FirebaseSyncError || state is FirebaseSyncInitial || state is FirebaseSyncReady) {
              return _getControls(fbc);
            } else
              return SpinnyThing();
          },
        ),
      ],
    );
  }

  Column _getControls(FirebaseSyncBloc fbc) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton.icon(
          onPressed: () {
            fbc.add(SyncPlaces(user));
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

  // -1 == fail
  // 0 == info
  // 1 == success
  void _showMessage(BuildContext context, int messageType, {String message = ''}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          color: Colors.grey.shade300,
          child: Row(
            children: [_getMessageIcon(messageType), Text(_getMessageText(messageType))],
          ),
        ),
      ),
    );
  }

  String _getMessageText(int t) {
    switch (t) {
      case -1:
        return 'Failed';
      case 0:
        return '';
      case 1:
        return 'Success';
      default:
        return '';
    }
  }

  Icon _getMessageIcon(int t) {
    switch (t) {
      case -1:
        return Icon(
          Icons.error,
          color: Colors.red,
        );
      case 0:
        return Icon(
          Icons.info,
          color: Colors.grey,
        );
      case 1:
        return Icon(
          Icons.done,
          color: Colors.green,
        );
      default:
        return Icon(
          Icons.info,
          color: Colors.grey,
        );
    }
  }
}
