import 'dart:io';

import 'package:first_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function setImage;
  final Product product;

  ImageInput(this.setImage, this.product);

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File _imageFile;

  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image) {
      setState(() {
        _imageFile = image;
      });
      widget.setImage(image);
      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    final buttonColor = Theme.of(context).primaryColor;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150.0,
          padding: EdgeInsets.all(10.0),
          child: Column(children: [
            Text(
              'Pick an Image',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            FlatButton(
              textColor: buttonColor,
              child: Text('Use Camera'),
              onPressed: () {
                _getImage(context, ImageSource.camera);
              },
            ),
            FlatButton(
              textColor: buttonColor,
              child: Text('Use Gallery'),
              onPressed: () {
                _getImage(context, ImageSource.camera);
              },
            ),
          ]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var buttonColor = Theme.of(context).accentColor;
    Widget previewImage = Text('Please select an image.');
    if (_imageFile != null) {
      previewImage = Image.file(
        _imageFile,
        fit: BoxFit.cover,
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
      );
    } else if (widget.product != null) {
      previewImage = Image.network(
        widget.product.image,
        fit: BoxFit.cover,
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
      );
    }
    return Column(
      children: <Widget>[
        OutlineButton(
          borderSide: BorderSide(
            color: buttonColor,
            width: 2.0,
          ),
          onPressed: () {
            _openImagePicker(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.camera_alt,
                color: buttonColor,
              ),
              SizedBox(width: 5.0),
              Text(
                'Add Image',
                style: TextStyle(color: buttonColor),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        previewImage,
        // _imageFile == null
        //     ? Text('Please pick an image')
        //     :
      ],
    );
  }
}
