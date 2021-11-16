import 'package:flutter/material.dart';
import '../../localization/localizations.dart';
import '../widgets/new_location_form.dart';

class PlaceAddScreen extends StatelessWidget {
  static const String route = '/place_add_screen';

  void _onSuccess(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onError(BuildContext context, String errorMessage) {
    debugPrint('error');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
  }

  @override
  Widget build(BuildContext context) {
    final translations = CustomLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.pageTitles.addNewPageTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: NewLocationForm(
            successCallback: () => _onSuccess(context),
            failCallback: () => _onError(context, translations.messages.errorMessage),
          ),
        ),
      ),
    );
  }
}
