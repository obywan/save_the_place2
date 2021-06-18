import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  final Function callback;
  const ImageSelector({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  late File _image;
  bool _imagePicked = false;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _getImage();
        },
        child: _imagePicked ? _imagePreview() : _placeholder(context));
  }

  Widget _imagePreview() {
    return Container(
      height: 150,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.file(
          _image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imagePicked = true;
        widget.callback(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget _placeholder(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(15),
      color: Colors.grey.shade400,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: Colors.grey.shade400,
            ),
            Text(
              'Add image',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.grey.shade400),
            ),
          ],
        ),
      ),
    );
  }
}
