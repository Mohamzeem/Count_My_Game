import 'package:count_my_game/Models/team_model.dart';
import 'package:equatable/equatable.dart';

class GameModel extends Equatable {
  final String? id;
  final String? name;
  final List? members;
  final int? maxScore;
  final String? winner;
  final String? createdAt;
  final List<TeamModel>? teams;
  final bool? isEnded;
  const GameModel({
    this.id,
    this.name,
    this.members,
    this.maxScore,
    this.winner,
    this.createdAt,
    this.teams,
    this.isEnded,
  });

  String getWinnerScore() {
    String winnerScore = '';
    for (TeamModel team in teams!) {
      if (team.isWinner == true) {
        winnerScore = team.score!;
      }
    }
    return winnerScore;
  }

  String getWinnerId() {
    String winnerId = '';
    for (TeamModel team in teams!) {
      if (team.isWinner == true) {
        winnerId = team.id!;
      }
    }
    return winnerId;
  }

  String getWinnerName() {
    String winnerName = '';
    for (TeamModel team in teams!) {
      if (team.isWinner == true) {
        winnerName = team.name!;
      }
    }
    return winnerName;
  }

  String getWinnerPhoto() {
    String winnerPhoto = '';
    for (TeamModel team in teams!) {
      if (team.isWinner == true) {
        winnerPhoto = team.photo!;
      }
    }
    return winnerPhoto;
  }

  Map<String, dynamic> toMap() {
    List<dynamic> teamsMapList = teams!.map((team) => team.toMap()).toList();
    return {
      'id': id ?? "",
      'name': name ?? "",
      'members': members ?? [],
      'maxScore': maxScore ?? 0,
      'winner': winner ?? "",
      'teams': teamsMapList,
      'createdAt': createdAt ?? "",
      'isEnded': isEnded ?? false,
    };
  }

  factory GameModel.fromMap(Map<String, dynamic> map) {
    List<TeamModel> teamsList = [];
    if (map['teams'] != null) {
      List<dynamic> teamsData = map['teams'];
      teamsList =
          teamsData.map((teamMap) => TeamModel.fromMap(teamMap)).toList();
    }
    return GameModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      members: map['members'],
      maxScore: map['maxScore'] ?? 0,
      winner: map['winner'] ?? "",
      teams: teamsList,
      createdAt: map['createdAt'] ?? "",
      isEnded: map['isEnded'] ?? true,
    );
  }
  @override
  List<Object?> get props =>
      [id, name, members, maxScore, winner, teams, createdAt];
}
