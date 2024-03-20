import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class TeamModel extends Equatable {
  final String? id;
  final String? name;
  final String? photo;
  final String? score;
  final bool? isWinner;

  const TeamModel({
    this.id,
    this.name,
    this.photo,
    this.score,
    this.isWinner,
  });

  Map<String, dynamic> toMap() {
    var uuid = const Uuid();
    final randomId = uuid.v4();
    return {
      'id': id == null || id == "" || id!.isEmpty ? randomId : id,
      'name': name ?? "",
      'photo': photo ?? "",
      'score': score ?? "",
      'isWinner': isWinner ?? false,
    };
  }

  factory TeamModel.fromMap(Map<String, dynamic> map) {
    return TeamModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      photo: map['photo'] ?? "",
      score: map['score'] ?? "",
      isWinner: map['isWinner'] ?? false,
    );
  }

  String get isPhoto {
    if (photo!.isEmpty || photo == "") {
      return AppStrings.defaultAppPhoto;
    }
    return photo!;
  }

  @override
  List<Object?> get props => [id, name, isWinner, score, photo];
}
