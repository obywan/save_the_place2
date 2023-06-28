import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:save_the_place/localization/localizations.dart';
import 'package:save_the_place/localization/translations.i69n.dart';
import 'package:save_the_place/ui/widgets/lang_selection.dart';
import '../screens/auth_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Translations trns = CustomLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text(trns.settings.account),
            onTap: () => Navigator.of(context).pushNamed(AuthScreen.route),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text(trns.settings.language),
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (ctx) => LangSelection(),
            ),
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.brightness_4_outlined),
              title: Text(trns.settings.darkTheme),
              trailing: Switch(
                  value: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
                  onChanged: (val) {
                    AdaptiveTheme.of(context).setThemeMode(val ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light);
                  })),
        ],
      ),
    );
  }
}
