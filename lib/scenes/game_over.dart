import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:ditoast/game/ditoast.dart';
import 'package:ditoast/i18n/strings.g.dart';
import 'package:ditoast/themes/dialog_button.dart';
import 'package:ditoast/utils/prefs.dart';

class GameOverDialog extends StatelessWidget {
  const GameOverDialog({
    super.key,
    required this.score,
    required this.game,
  });

  final int score;
  final RicochlimeGame game;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: NesContainer(
          backgroundColor: colorScheme.surface,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  children: [
                    Text(
                      t.gameOverPage.title,
                      style: const TextStyle(
                        fontSize: kToolbarHeight,
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 300,
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          style: TextStyle(
                            fontSize: kToolbarHeight / 2,
                            color: colorScheme.onSurface,
                          ),
                          children: [
                            if (score > Prefs.highScore.value &&
                                Prefs.highScore.value > 0)
                              t.gameOverPage.highScoreBeaten(
                                pOld: TextSpan(
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: kToolbarHeight / 20,
                                    decorationColor:
                                        colorScheme.onSurface.withOpacity(0.6),
                                  ),
                                  text: ' ${Prefs.highScore.value} ',
                                ),
                                pNew: TextSpan(
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: kToolbarHeight / 2,
                                  ),
                                  text: '$score',
                                ),
                              )
                            else
                              TextSpan(
                                text: t.gameOverPage.highScoreNotBeaten(
                                  p: score,
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                   
                    DialogButton(
                      onPressed: () {
                        context.pop<GameOverAction>(GameOverAction.restartGame);
                      },
                      type: NesButtonType.primary,
                      icon: NesIcons.redo,
                      text: t.gameOverPage.restartGameButton,
                    ),
                    const SizedBox(height: 32),
                    DialogButton(
                      onPressed: () {
                        context
                          // pop dialog
                          ..pop<GameOverAction>(GameOverAction.nothingYet)
                          // pop play page
                          ..pop();
                      },
                      icon: NesIcons.leftArrowIndicator,
                      text: t.gameOverPage.homeButton,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum GameOverAction {
  continueGame,
  restartGame,
  nothingYet,
}
