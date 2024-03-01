import 'package:ditoast/game/ditoast.dart';
import 'package:flutter/material.dart';

class GameIntroDialog extends StatelessWidget{
  const GameIntroDialog({
    super.key,
    required this.game,
  });

  final DitoastGame game;

  @override
  Widget build(BuildContext context){
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        )
    );
  }

}