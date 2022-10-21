import 'package:flutter/material.dart';

class TagsSelector extends StatefulWidget {
  const TagsSelector({Key? key}) : super(key: key);

  @override
  State<TagsSelector> createState() => _TagsSelectorState();
}

class _TagsSelectorState extends State<TagsSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DropdownButton(items: [DropdownMenuItem<String>(child: Text('data'))], onChanged: (s) {}),
    );
  }
}
