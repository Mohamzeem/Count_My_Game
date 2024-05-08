import 'package:equatable/equatable.dart';
import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:count_my_game/Models/friend_model.dart';

class UserModel extends Equatable {
  final String? id;
  final String? photo;
  final String? name;
  final String? email;

  final List<FriendModel>? friends;

  const UserModel({
    this.id,
    this.photo,
    this.name,
    this.email,
    this.friends,
  });

  String getFriend(String friendId) {
    for (var friend in friends!) {
      friendId = friend.id!;
    }
    return friendId;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<FriendModel> friendsList = [];
    if (json['teams'] != null) {
      List<dynamic> teamsData = json['teams'];
      friendsList =
          teamsData.map((teamMap) => FriendModel.fromJson(teamMap)).toList();
    }
    return UserModel(
      id: json['id'] ?? "",
      photo: json['photo'] ?? "",
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      friends: friendsList,
    );
  }

  Map<String, dynamic> toJson() {
    List<FriendModel> friendsMapList = [];
    if (friends != null) {
      friends!.map((team) => team.toJson()).toList();
    }

    return <String, dynamic>{
      'id': id,
      'photo': photo ?? "",
      'name': name ?? "",
      'email': email ?? "",
      'friends': friendsMapList,
    };
  }

  String get isPhoto {
    if (photo!.isEmpty || photo == "" || photo == null) {
      return AppStrings.defaultAppPhoto;
    }
    return photo!;
  }

  @override
  List<Object?> get props => [id, photo, name, email, friends];
}
