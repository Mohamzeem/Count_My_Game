import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:count_my_game/Models/friend_model.dart';
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
  final List? teamPhotos;
  final List<FriendModel>? friends;

  const UserModel({
    this.id,
    this.photo,
    this.name,
    this.email,
    this.mobileNum,
    this.tokenFcm,
    this.isLoged,
    this.isOnline,
    this.teamPhotos,
    this.friends,
  });

  // deleteFriend(String friendId) async {
  //   List updatedList = [];
  //   for (FriendModel friend in friends!) {
  //     updatedList = friends!.where((friend) => friend.id != friendId).toList();
  //   }
  // }

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
      mobileNum: json['mobileNum'] ?? "",
      tokenFcm: json['tokenFcm'] ?? "",
      isLoged: json['isLoged'] ?? false,
      isOnline: json['isOnline'] ?? false,
      teamPhotos: json['teamPhotos'] ?? [],
      friends: friendsList,
    );
  }

  Map<String, dynamic> toJson() {
    List<dynamic> friendsMapList =
        friends!.map((team) => team.toJson()).toList();

    return <String, dynamic>{
      'id': id,
      'photo': photo ?? "",
      'name': name ?? "",
      'email': email ?? "",
      'mobileNum': mobileNum ?? "",
      'tokenFcm': tokenFcm ?? "",
      'isLoged': isLoged ?? false,
      'isOnline': isOnline ?? false,
      'teamPhotos': teamPhotos ?? [],
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
  List<Object?> get props => [
        id,
        photo,
        name,
        email,
        mobileNum,
        tokenFcm,
        isLoged,
        isOnline,
        teamPhotos,
        friends
      ];
}
