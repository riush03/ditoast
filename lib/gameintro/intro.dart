import 'package:ditoast/game/ditoast.dart';
import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';

class GameIntroDialog extends StatelessWidget{
  const GameIntroDialog({
    super.key,
    required this.game,
  });

  final DitoastGame game;
  final String introScreen = 'Hello , global citizen. Pollutants are trying to fill the earth. In this game'
                         'your role is to fight the monster pollutant before the encroach your village and finish you';

  @override
  Widget build(BuildContext context){
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: NesContainer (
          backgroundColor: colorScheme.surface,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  children: [
                    Text(
                      t.,
                      style: const TextStyle(
                        fontSize: kToolbarHeight
                      ),
                    )
                  ],
                  ),
              )
            ],
          ),
        ),
        )
    );
  }

}

