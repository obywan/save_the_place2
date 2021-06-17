import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class NewLocationForm extends StatefulWidget {
  const NewLocationForm({Key? key}) : super(key: key);

  @override
  _NewLocationFormState createState() => _NewLocationFormState();
}

class _NewLocationFormState extends State<NewLocationForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: 'Place name'),
          ),
          SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(hintText: 'Place description'),
          ),
          SizedBox(height: 24),
          DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(15),
            color: Colors.grey.shade400,
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.add,
                color: Colors.grey.shade400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
