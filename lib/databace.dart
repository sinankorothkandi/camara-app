import 'package:hive/hive.dart';
import 'home.dart';

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
