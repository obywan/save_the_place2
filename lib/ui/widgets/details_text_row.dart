import 'package:flutter/material.dart';

class DetailsTextRow extends StatelessWidget {
  const DetailsTextRow({
    Key? key,
    required this.text,
    this.color = Colors.grey,
  }) : super(key: key);

  final Text text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      decoration: BoxDecoration(color: color),
      child: text,
    );
  }
}
