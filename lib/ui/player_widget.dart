import 'package:flutter/material.dart';
import 'package:tennis_counter_app/model/player.dart';

class PlayerWidget extends StatelessWidget {
  final Player player;
  final Function() onAddScore;
  const PlayerWidget({Key? key, required this.player, required this.onAddScore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48.0),
      child: Column(
        children: [
          PlayerInfoItem(
            title: 'Player ${player.id}',
            value: player.name,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //spacer
                const SizedBox(
                  height: 72,
                ),
                //currentGameScore

                PlayerInfoItem(
                  title: 'Games Score',
                  value: (player.gamesWonScore ?? 0).toString(),
                ),
                const SizedBox(
                  height: 12,
                ),
                //currentGame
                PlayerInfoItem(
                  title: 'Current Game Score',
                  value: player.currentGameScore?.name ?? '0',
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
                )
              ],
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(60),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                iconSize: 60,
                onPressed: onAddScore,
                icon: Image.asset(
                  'assets/tennis_ball.png',
                  colorBlendMode: BlendMode.xor,
                  height: 60,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerInfoItem extends StatelessWidget {
  final String title;
  final String value;
  final Widget? customValueChild;
  const PlayerInfoItem({Key? key, required this.title, required this.value, this.customValueChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
          )
        ],
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 12.0,
          bottom: customValueChild != null ? 12.0 : 0.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            SizedBox(
              height: 60,
              child: customValueChild ??
                  Center(
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
