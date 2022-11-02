import 'package:mobx/mobx.dart';
import 'package:tennis_counter_app/model/player.dart';
import 'package:tennis_counter_app/model/score.dart';

part 'game_store.g.dart';

const int PLAYER_1_ID = 1;
const int PLAYER_2_ID = 2;

class GameStore = _GameStore with _$GameStore;

abstract class _GameStore with Store {
  @observable
  Player? player1;

  @observable
  Player? player2;

  @computed
  Player? get gameWinner {
    if (player1 == null || player2 == null) {
      return null;
    }

    final player1Score = (player1!.gamesWonScore ?? 0);
    final player2Score = (player2!.gamesWonScore ?? 0);

    if (player1Score >= 6 && player1Score - player2Score >= 2) {
      return player1;
    }

    if (player2Score >= 6 && player2Score - player1Score >= 2) {
      return player2;
    }
    return null;
  }

  @action
  reset() {
    player1 = player1?.copyWith(
      gamesWonScore: null,
      currentGameScore: null,
    );

    player2 = player2?.copyWith(
      gamesWonScore: null,
      currentGameScore: null,
    );
  }

  @action
  removePlayers() {
    player1 = null;
    player2 = null;
  }

  @action
  initPlayers(String name1, String name2) {
    player1 = Player(id: PLAYER_1_ID, name: name1);
    player2 = Player(id: PLAYER_2_ID, name: name2);
  }

  @action
  addScore(int id) {
    if (player1 == null || player2 == null) {
      return;
    }

    if (id == PLAYER_1_ID) {
      player1 = player1!.copyWith(
        currentGameScore: (player1!.currentGameScore ?? Score.score0).getNext(),
      );
    } else if (id == PLAYER_2_ID) {
      player2 = player2!.copyWith(
        currentGameScore: (player2!.currentGameScore ?? Score.score0).getNext(),
      );
    }

    //check 40:40
    if (player1!.currentGameScore == Score.scoreA && player2!.currentGameScore == Score.scoreA) {
      player1 = player1!.copyWith(
        currentGameScore: Score.score40,
      );

      player2 = player2!.copyWith(
        currentGameScore: Score.score40,
      );

      return;
    }

    //check player1 win
    if (player1!.currentGameScore == Score.scoreWin ||
        player1!.currentGameScore == Score.scoreA && player2!.currentGameScore != Score.score40) {
      player1 = player1!.copyWith(
        gamesWonScore: (player1!.gamesWonScore ?? 0) + 1,
        currentGameScore: Score.score0,
      );

      player2 = player2!.copyWith(
        currentGameScore: Score.score0,
      );
      return;
    }

    //check player2 win
    if (player2!.currentGameScore == Score.scoreWin ||
        player2!.currentGameScore == Score.scoreA && player1!.currentGameScore != Score.score40) {
      player2 = player2!.copyWith(
        gamesWonScore: (player2!.gamesWonScore ?? 0) + 1,
        currentGameScore: Score.score0,
      );

      player1 = player1!.copyWith(
        currentGameScore: Score.score0,
      );
      return;
    }
  }
}
