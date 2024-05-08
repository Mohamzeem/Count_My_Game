import 'package:count_my_game/Models/team_model.dart';
import 'package:hive/hive.dart';

class TeamTypeAdaptor extends TypeAdapter<TeamModel> {
  @override
  read(BinaryReader reader) {
    return TeamModel(
      id: reader.readString(),
      name: reader.readString(),
      photo: reader.readString(),
      score: reader.readString(),
      isWinner: reader.readBool(),
    );
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, TeamModel obj) {
    writer.writeString(obj.id!);
    writer.writeString(obj.name!);
    writer.writeString(obj.photo!);
    writer.writeString(obj.score!);
    writer.writeBool(obj.isWinner!);
  }
}
