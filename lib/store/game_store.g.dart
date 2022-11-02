// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GameStore on _GameStore, Store {
  Computed<Player?>? _$gameWinnerComputed;

  @override
  Player? get gameWinner =>
      (_$gameWinnerComputed ??= Computed<Player?>(() => super.gameWinner,
              name: '_GameStore.gameWinner'))
          .value;

  late final _$player1Atom = Atom(name: '_GameStore.player1', context: context);

  @override
  Player? get player1 {
    _$player1Atom.reportRead();
    return super.player1;
  }

  @override
  set player1(Player? value) {
    _$player1Atom.reportWrite(value, super.player1, () {
      super.player1 = value;
    });
  }

  late final _$player2Atom = Atom(name: '_GameStore.player2', context: context);

  @override
  Player? get player2 {
    _$player2Atom.reportRead();
    return super.player2;
  }

  @override
  set player2(Player? value) {
    _$player2Atom.reportWrite(value, super.player2, () {
      super.player2 = value;
    });
  }

  late final _$_GameStoreActionController =
      ActionController(name: '_GameStore', context: context);

  @override
  dynamic reset() {
    final _$actionInfo =
        _$_GameStoreActionController.startAction(name: '_GameStore.reset');
    try {
      return super.reset();
    } finally {
      _$_GameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removePlayers() {
    final _$actionInfo = _$_GameStoreActionController.startAction(
        name: '_GameStore.removePlayers');
    try {
      return super.removePlayers();
    } finally {
      _$_GameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic initPlayers(String name1, String name2) {
    final _$actionInfo = _$_GameStoreActionController.startAction(
        name: '_GameStore.initPlayers');
    try {
      return super.initPlayers(name1, name2);
    } finally {
      _$_GameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addScore(int id) {
    final _$actionInfo =
        _$_GameStoreActionController.startAction(name: '_GameStore.addScore');
    try {
      return super.addScore(id);
    } finally {
      _$_GameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
player1: ${player1},
player2: ${player2},
gameWinner: ${gameWinner}
    ''';
  }
}
