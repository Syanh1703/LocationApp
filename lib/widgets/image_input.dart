import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;

class ImageInput extends StatefulWidget {

  final Function onSelectImg;
  ImageInput(this.onSelectImg);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  File? _storedImage;
  _takePicture() async {
    final _picker = ImagePicker();
    final imgFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth:  600
    );
    if(imgFile == null){
      return;
    }
    setState(() {
      _storedImage = File(imgFile.path);
    });

    ///09_07: Where to copy the taken image
    final appDir = await sysPath.getApplicationDocumentsDirectory();
    final imgName = path.basename(_storedImage!.path); //get the name created by the camera after taking the shot
    final savedImage = await _storedImage!.copy('${appDir.path}/$imgName');
    widget.onSelectImg(savedImage);//Forward the image to another dart file
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null ? Image.file(_storedImage!,
            fit: BoxFit.cover,
            width: double.infinity,): const Text('No image taken', textAlign: TextAlign.center,),
          alignment: Alignment.center,
        ),
        const SizedBox(width: 10,),
        Expanded(
            child: TextButton.icon(
                onPressed: _takePicture,
                icon: const Icon(Icons.camera),
              label: const Text('Take Picture'),
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
            )
        ),
      ],
    );
  }
}
