import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:uuid/uuid.dart';
import 'package:ditoast/game/ditoast.dart';
import 'package:flutter/foundation.dart';
import 'package:ditoast/i18n/strings.g.dart';
import 'package:ditoast/themes/dialog_button.dart';
import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:ditoast/utils/prefs.dart';

class GameOverDialog extends StatelessWidget {
  const GameOverDialog({
    super.key,
    required this.score,
    required this.game,
  });

  final int score;
  final DitoastGame game;

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
                    //google wallet button
                    
                          AddToGoogleWalletButton(
                             pass:_ditoastGamePass,
                             onSuccess: () async {
                                _showSnackBar(context, 'Added to wallet successfully');
                                context.pop<GameOverAction>(GameOverAction.continueGame);
                             },
                             onCanceled: () => _showSnackBar(context,'Action Cancelled'),
                             onError: (Object error) => _showSnackBar(context, error.toString()),
                             locale: const Locale.fromSubtags(
                                languageCode: 'en',
                                countryCode: 'US',
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

  void _showSnackBar(BuildContext context,String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

enum GameOverAction {
  continueGame,
  restartGame,
  nothingYet,
}

final String _passId = const Uuid().v4();
const String _passClass = 'codelab_class';
const String _issuerId = '3388000000022320835';
const String _issuerEmail = 'Dennzriush@gmail.com';


final String _ditoastGamePass = """ 
    {
      "iss": "$_issuerEmail",
      "aud": "google",
      "typ": "savetowallet",
      "origins": [],
      "payload": {
        "genericObjects": [
          {
            "id": "$_issuerId.$_passId",
            "classId": "$_issuerId.$_passClass",
            "genericType": "GENERIC_TYPE_UNSPECIFIED",
            "hexBackgroundColor": "#4285f4",
            "logo": {
              "sourceUri": {
                "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/pass_google_logo.jpg"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "en",
                "value": "DITOAST GAME '24 [DEMO ONLY]"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "en",
                "value": "Attendee"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "Alex McJacobs"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "$_passId"
            },
            "heroImage": {
              "sourceUri": {
                "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/google-io-hero-demo-only.jpg"
              }
            },
            "textModulesData": [
              {
                "header": "POINTS",
                "body": "1234",
                "id": "points"
              }
            ]
          }
        ]
      }
    }
""";