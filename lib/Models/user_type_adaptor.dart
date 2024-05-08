import 'package:count_my_game/Models/user_model.dart';
import 'package:hive/hive.dart';

class UserTypeAdaptor extends TypeAdapter<UserModel> {
  @override
  read(BinaryReader reader) {
    return UserModel(
      email: reader.readString(),
      friends: reader.readList().cast(),
      id: reader.readString(),
      name: reader.readString(),
      photo: reader.readString(),
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeString(obj.photo!);
    writer.writeString(obj.id!);
    writer.writeString(obj.name!);
    writer.writeString(obj.email!);
    writer.writeList(obj.friends!);
  }
}
