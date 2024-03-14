import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:equatable/equatable.dart';

class GameModel extends Equatable {
  final List? members;
  final String? lastMessageTime;
  final String? lastMessage;
  final String? createdAt;
  final String? id;
  final String? senderId;
  final String? senderName;
  final String? senderPhoto;
  final String? contactId;
  final String? contactName;
  final String? contactPhoto;

  const GameModel({
    this.members,
    this.lastMessageTime,
    this.lastMessage,
    this.createdAt,
    this.id,
    this.senderId,
    this.senderName,
    this.senderPhoto,
    this.contactId,
    this.contactName,
    this.contactPhoto,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'members': members,
      'lastMessageTime': lastMessageTime,
      'lastMessage': lastMessage,
      'createdAt': createdAt,
      'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'senderPhoto': senderPhoto,
      'contactId': contactId,
      'contactName': contactName,
      'contactPhoto': contactPhoto,
    };
  }

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      members: map['members'] ?? [],
      lastMessageTime: map['lastMessageTime'] ?? "",
      lastMessage: map['lastMessage'] ?? "",
      createdAt: map['createdAt'] ?? "",
      id: map['id'] ?? "",
      senderId: map['senderId'] ?? "",
      senderName: map['senderName'] ?? "",
      senderPhoto: map['senderPhoto'] ?? "",
      contactId: map['contactId'] ?? "",
      contactName: map['contactName'] ?? "",
      contactPhoto: map['contactPhoto'] ?? "",
    );
  }
  @override
  List<Object> get props {
    return [
      members!,
      lastMessageTime!,
      lastMessage!,
      createdAt!,
      id!,
      senderId!,
      senderName!,
      senderPhoto!,
      contactId!,
      contactName!,
      contactPhoto!,
    ];
  }

  String get isSenderPhoto {
    if (senderPhoto!.isEmpty || senderPhoto == "") {
      return AppStrings.defaultAppPhoto;
    }
    return senderPhoto!;
  }

  String get iscontactPhoto {
    if (contactPhoto!.isEmpty || contactPhoto == "") {
      return AppStrings.defaultAppPhoto;
    }
    return contactPhoto!;
  }
}
