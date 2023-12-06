
// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


@HiveType(typeId: 0)
class MyImage {
  @HiveField(0)
  final String imagePath;

  MyImage(this.imagePath);
}

class MyImageAdapter extends TypeAdapter<MyImage> {
  @override
  final int typeId = 0;

  @override
  MyImage read(BinaryReader reader) {
    return MyImage(reader.readString());
  }

  @override
  void write(BinaryWriter writer, MyImage obj) {
    writer.writeString(obj.imagePath);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _imagePicker = ImagePicker();
   Box<MyImage>? imageBox; 

  @override
  void initState() {
    super.initState();
    openImageBox();
  }

  Future<void> openImageBox() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    imageBox = await Hive.openBox<MyImage>('images');
  }

  Future<void> _openCamera() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
      imageBox?.add(MyImage(image.path));
      setState(() {}); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
     body: Center(
  child: imageBox == null
      ? Text('empty') 
      : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
          ),
          itemCount: imageBox?.length ?? 0,
          itemBuilder: (context, index) {
            final myImage = imageBox?.getAt(index); 
            return SizedBox(
              width: 200, 
              height: 200, 
              child: Image.file(File(myImage?.imagePath ?? '')),
            );
          },
        ),
),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openCamera();
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
