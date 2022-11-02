import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:tennis_counter_app/player_widget.dart';
import 'package:tennis_counter_app/start_overlay_screen.dart';
import 'package:tennis_counter_app/store/game_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GameStore store = GameStore();

  @override
  void initState() {
    autorun((_) async {
      if (store.gameWinner != null) {
        await showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              title: const Center(child: Text("Winner!")),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Text("${store.gameWinner!.name} won the game!"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 16.0,
                    bottom: 8,
                  ),
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ),
                ),
              ],
            );
          },
        );
        store.reset();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Tennis Tracker"),
        actions: [
          IconButton(
              onPressed: () {
                store.removePlayers();
              },
              icon: const Icon(Icons.person_off))
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Observer(
              builder: (context) => Row(
                children: [
                  Expanded(
                    child: store.player1 == null
                        ? Container()
                        : PlayerWidget(
                            onAddScore: () {
                              store.addScore(store.player1!.id);
                            },
                            player: store.player1!,
                          ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: store.player2 == null
                        ? Container()
                        : PlayerWidget(
                            onAddScore: () {
                              store.addScore(store.player2!.id);
                            },
                            player: store.player2!,
                          ),
                  )
                ],
              ),
            ),
          ),
          Observer(builder: (context) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: store.player1 != null && store.player2 != null
                  ? Container()
                  : StartOverlayScreen(
                      onStarted: ({required String user1, required String user2}) {
                        store.initPlayers(user1, user2);
                      },
                    ),
            );
          }),
        ],
      ),
    );
  }
}
