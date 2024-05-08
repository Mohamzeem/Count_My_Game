import 'package:count_my_game/Models/game_model.dart';
import 'package:hive/hive.dart';

class GameTypeAdaptor extends TypeAdapter<GameModel> {
  @override
  read(BinaryReader reader) {
    return GameModel(
      id: reader.readString(),
      name: reader.readString(),
      createdAt: reader.readString(),
      isEnded: reader.readBool(),
      maxScore: reader.readInt(),
      members: reader.readList(),
      teams: reader.readList().cast(),
    );
  }

  @override
  int get typeId => 2;

  @override
  void write(BinaryWriter writer, GameModel obj) {
    writer.writeString(obj.id!);
    writer.writeString(obj.name!);
    writer.writeString(obj.createdAt!);
    writer.writeBool(obj.isEnded!);
    writer.writeInt(obj.maxScore!);
    writer.writeList(obj.members!);
    writer.writeList(obj.teams!);
  }
}
