import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:equatable/equatable.dart';

class FriendModel extends Equatable {
  final String? id;
  final String? photo;
  final String? name;
  final bool? isOnline;

  const FriendModel({
    this.id,
    this.photo,
    this.name,
    this.isOnline,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      id: json['id'] ?? "",
      photo: json['photo'] ?? "",
      name: json['name'] ?? "",
      isOnline: json['isOnline'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'photo': photo ?? "",
      'name': name ?? "",
      'isOnline': isOnline ?? false,
    };
  }

  String get isPhoto {
    if (photo!.isEmpty || photo == "" || photo == null) {
      return AppStrings.defaultAppPhoto;
    } else {
      return photo!;
    }
  }

  @override
  List<Object?> get props => [id, photo, name, isOnline];
}
