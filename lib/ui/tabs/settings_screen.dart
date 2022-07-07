import 'package:flutter/material.dart';
import '../screens/auth_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text('Account'),
            onTap: () => Navigator.of(context).pushNamed(AuthScreen.route),
          ),
          Divider(),
        ],
      ),
    );
  }
}
