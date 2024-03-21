import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:equatable/equatable.dart';

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
    return {
      'id': id ?? "",
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
    if (photo!.isEmpty || photo == "" || photo == null) {
      return AppStrings.defaultAppPhoto;
    }
    return photo!;
  }

  @override
  List<Object?> get props => [id, name, isWinner, score, photo];
}
