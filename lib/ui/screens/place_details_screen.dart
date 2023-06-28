import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/models/place.dart';
import '../../localization/localizations.dart';
import '../widgets/details_text_row.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const String route = '/place_details_screen';
  @override
  Widget build(BuildContext context) {
    final Place place = ModalRoute.of(context)!.settings.arguments as Place;
    final translations = CustomLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(place.name)),
      body: SafeArea(
        child: Column(
          children: [
            DetailsTextRow(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on_outlined),
                  SizedBox(width: 8),
                  Text('${place.location.latitude}, ${place.location.longitude}'),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: '${place.location.latitude}, ${place.location.longitude}'));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(translations.messages.copied)));
                    },
                  )
                ],
              ),
            ),
            DetailsTextRow(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.height),
                  SizedBox(width: 8),
                  Text('${place.location.elevation} m'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(place.description),
            ),
            _getImage(place.imagePath, context)
          ],
        ),
      ),
    );
  }

  Padding _getTagChip(String e) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: Chip(label: Text(e)),
    );
  }

  Expanded _getImage(String imagePath, BuildContext context) {
    return Expanded(
      flex: 1,
      child: Stack(
        children: [
          Container(
            // height: 200,
            width: double.infinity,
            child: (imagePath.isNotEmpty)
                ? Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
