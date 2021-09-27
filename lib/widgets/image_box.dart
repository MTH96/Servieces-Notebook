import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro/models/auth.dart';
import 'package:pro/models/storage.dart';

class ImageBox extends StatefulWidget {
  const ImageBox(
      {Key? key, required this.imageSavingFn, this.height, this.width})
      : super(key: key);

  final double? height;
  final double? width;
  final void Function(String) imageSavingFn;

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  late File image;
  bool displayImage = false;

  void _picImage() async {
    final _storage = Storage();
    final _auth = Auth();
    final _picker = ImagePicker();
    final fileRef =
        await _picker.pickImage(source: ImageSource.camera, maxWidth: 300);
    if (fileRef != null) {
      setState(() async {
        image = File(fileRef.path);

        final imageUrl = await _storage.uploadImage(image, _auth.user!.uid);
        widget.imageSavingFn(
          imageUrl,
        );
        displayImage = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey),
      ),
      child: GridTile(
        footer: GestureDetector(
          child: const GridTileBar(
            backgroundColor: Colors.black45,
            leading: Text(
              'edit',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Icon(Icons.edit),
          ),
          onTap: _picImage,
        ),
        child: displayImage
            ? Image.file(image)
            : Text(
                'أضف صورة حسابك',
                style: TextStyle(color: Theme.of(context).errorColor),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
