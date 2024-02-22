import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:ditoast/i18n/strings.g.dart';
import 'package:ditoast/themes/dialog_button.dart';

class RestartGameDialog extends StatelessWidget {
  const RestartGameDialog({
    super.key,
    required this.restartGame,
  });

  final VoidCallback restartGame;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: NesContainer(
          backgroundColor: colorScheme.surface,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.restartGameDialog.title,
                  style: const TextStyle(
                    fontSize: kToolbarHeight,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 400,
                  child: Text(
                    t.restartGameDialog.areYouSure,
                    style: TextStyle(
                      fontSize: kToolbarHeight / 2,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                DialogButton(
                  onPressed: () {
                    restartGame();
                    context.pop(true);
                  },
                  type: NesButtonType.error,
                  icon: NesIcons.redo,
                  text: t.restartGameDialog.yesImSure,
                ),
                const SizedBox(height: 32),
                DialogButton(
                  onPressed: () => context.pop(false),
                  type: NesButtonType.normal,
                  icon: NesIcons.leftArrowIndicator,
                  text: t.restartGameDialog.waitCancel,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
