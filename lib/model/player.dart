// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tennis_counter_app/model/score.dart';

part 'player.freezed.dart';

@freezed
class Player with _$Player {
  factory Player({
    required final int id,
    required final String name,
    final int? gamesWonScore,
    final Score? currentGameScore,
  }) = _Player;
}

extension ListPlayersExt on List<Player> {
  Player? getSafe(int index) {
    if (length > index) {
      return this[index];
    }

    return null;
  }
}
