import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../localization/localizations.dart';
import '../../localization/translations.i69n.dart';
import 'confirmation_modal_sheet.dart';

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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 32),
        Text(user.displayName ?? 'unknown', style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
        SizedBox(height: 8),
        Text(user.email ?? '', textAlign: TextAlign.center),
        SizedBox(height: 8),
        BlocConsumer<FirebaseSyncBloc, FirebaseSyncState>(
          bloc: fbc,
          listener: (context, state) {
            if (state is FirebaseSyncError) {
              _showMessage(context, -1, message: state.message);
            } else if (state is FirebaseSyncReady) {
              _showMessage(context, 1);
            }
          },
          builder: (context, state) {
            if (state is FirebaseSyncError || state is FirebaseSyncInitial || state is FirebaseSyncReady) {
              return _getControls(context, fbc);
            } else
              return SpinnyThing();
          },
        ),
      ],
    );
  }

  Widget _getControls(BuildContext context, FirebaseSyncBloc fbc) {
    Translations trns = CustomLocalizations.of(context);
    return ListView(
      shrinkWrap: true,
      children: [
        Divider(),
        ListTile(
          onTap: () {
            fbc.add(SyncPlaces(user));
          },
          title: Text(trns.userPage.sync),
          leading: Icon(
            Icons.sync,
            color: Colors.black,
          ),
        ),
        Divider(),
        ListTile(
          onTap: () =>
              showModalBottomSheet<void>(context: context, builder: (_) => ConfirmationModalSheet(title: '${trns.userPage.signOut}?', onConfirm: signOut)),
          title: Text(trns.userPage.signOut),
          leading: Icon(
            Icons.logout_rounded,
            color: Colors.black,
          ),
        ),
        Divider(),
        Text('${trns.userPage.dangerZone}:', textAlign: TextAlign.center),
        Divider(),
        ListTile(
          onTap: () => showModalBottomSheet<void>(
              context: context,
              builder: (_) => ConfirmationModalSheet(
                  title: trns.userPage.wipeOutModalTitle,
                  descroption: trns.userPage.wipeOutModalDescription,
                  onConfirm: () async {
                    wipeData(fbc);
                  })),
          title: Text(
            trns.userPage.wipeOutCloudData,
            style: TextStyle(color: Colors.red),
          ),
          leading: Icon(
            Icons.delete_sweep_outlined,
            color: Colors.red,
          ),
        ),
        Divider(),
      ],
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    stateSetterCallback(false);
  }

  Future<void> wipeData(FirebaseSyncBloc fbc) async {
    fbc.add(WipeData(user));
    stateSetterCallback(false);
  }

  // -1 == fail
  // 0 == info
  // 1 == success
  void _showMessage(BuildContext context, int messageType, {String message = ''}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            _getMessageIcon(messageType),
            SizedBox(width: 16),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(message.isEmpty ? _getMessageText(messageType) : message),
              ),
            ),
          ],
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
