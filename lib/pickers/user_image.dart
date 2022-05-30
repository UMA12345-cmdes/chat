  import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
class UserImage extends StatefulWidget {
  UserImage(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File ? _pickedImage;
  Future _pickImage() async{
   final File pickedImageFile = (await ImagePicker().pickImage(
      source: ImageSource.camera,
        imageQuality: 50,
      maxWidth: 150,
    )) as File;
  setState(() {
    _pickedImage = pickedImageFile as File;
  });
  widget.imagePickFn(
      pickedImageFile
  );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage != null
              ? FileImage(_pickedImage as File) : null,
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('add image'),
        ),
      ],
    );
  }
}
