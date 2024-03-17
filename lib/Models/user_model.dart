import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String? photo;
  final String? name;
  final String? email;
  final String? mobileNum;
  final String? tokenFcm;
  final bool? isLoged;
  final bool? isOnline;
  const UserModel({
    this.id,
    this.photo,
    this.name,
    this.email,
    this.mobileNum,
    this.tokenFcm,
    this.isLoged,
    this.isOnline,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? "",
      photo: json['photo'] ?? "",
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      mobileNum: json['mobileNum'] ?? "",
      tokenFcm: json['tokenFcm'] ?? "",
      isLoged: json['isLoged'] ?? false,
      isOnline: json['isOnline'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'photo': photo ?? "",
      'name': name ?? "",
      'email': email ?? "",
      'mobileNum': mobileNum ?? "",
      'tokenFcm': tokenFcm ?? "",
      'isLoged': isLoged ?? false,
      'isOnline': isOnline ?? false,
    };
  }

  String get isPhoto {
    if (photo!.isEmpty || photo == "" || photo == null) {
      return AppStrings.defaultAppPhoto;
    }
    return photo!;
  }

  @override
  List<Object?> get props => [
        id,
        photo,
        name,
        email,
        mobileNum,
        tokenFcm,
        isLoged,
        isOnline,
      ];
}
