import 'package:flutter/material.dart';

class ConfirmationModalSheet extends StatelessWidget {
  final String title;
  final String? descroption;
  final Future Function() onConfirm;
  const ConfirmationModalSheet({Key? key, required this.title, this.descroption, required this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32, bottom: 32, left: 16, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline5,
          ),
          if (descroption != null) SizedBox(height: 16),
          if (descroption != null) Text(descroption!),
          if (descroption != null) SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Theme.of(context).colorScheme.primary)),
                child: TextButton(
                  onPressed: () {
                    onConfirm().then((value) => Navigator.of(context).pop());
                  },
                  child: Text('OK'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
