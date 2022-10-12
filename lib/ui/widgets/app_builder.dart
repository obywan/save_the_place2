import 'package:flutter/material.dart';

class AppBuilder extends StatefulWidget {
  final Function(BuildContext) builder;
  const AppBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  State<AppBuilder> createState() => AppBuilderState();

  static AppBuilderState? of(BuildContext context) {
    return context.findAncestorStateOfType<AppBuilderState>();
  }
}

class AppBuilderState extends State<AppBuilder> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }

  void rebuild() {
    setState(() {
      debugPrint('Rebuild called');
      counter++;
    });
  }
}
