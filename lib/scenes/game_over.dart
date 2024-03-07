import 'dart:async';
import 'dart:io';

import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:uuid/uuid.dart';
import 'package:ditoast/game/ditoast.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:ditoast/i18n/strings.g.dart';
import 'package:ditoast/themes/dialog_button.dart';
import 'package:add_to_google_web_wallet/widgets/add_to_google_web_wallet_button.dart';
import 'package:add_to_google_wallet/add_to_google_wallet.dart';
import 'package:ditoast/utils/prefs.dart';

class GameOverDialog extends StatelessWidget {
  const GameOverDialog({
    super.key,
    required this.score,
    required this.game,
  });

  final int score;
  final DitoastGame game;
  final String jwt = 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJkZW5pc2tleXNAYXJjb3JlaGFja3Rob24uaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLCJhdWQiOiJnb29nbGUiLCJvcmlnaW5zIjpbImh0dHA6Ly9sb2NhbGhvc3Q6MzAwMCJdLCJ0eXAiOiJzYXZldG93YWxsZXQiLCJwYXlsb2FkIjp7ImdlbmVyaWNPYmplY3RzIjpbeyJpZCI6IjMzODgwMDAwMDAwMjIzMjA4MzUuY29kZWxhYl9vYmplY3QiLCJjbGFzc0lkIjoiMzM4ODAwMDAwMDAyMjMyMDgzNS5jb2RlbGFiX2NsYXNzIiwiZ2VuZXJpY1R5cGUiOiJHRU5FUklDX1RZUEVfVU5TUEVDSUZJRUQiLCJoZXhCYWNrZ3JvdW5kQ29sb3IiOiIjNDI4NWY0IiwibG9nbyI6eyJzb3VyY2VVcmkiOnsidXJpIjoiaHR0cHM6Ly9zdG9yYWdlLmdvb2dsZWFwaXMuY29tL3dhbGxldC1sYWItdG9vbHMtY29kZWxhYi1hcnRpZmFjdHMtcHVibGljL3Bhc3NfZ29vZ2xlX2xvZ28uanBnIn19LCJjYXJkVGl0bGUiOnsiZGVmYXVsdFZhbHVlIjp7Imxhbmd1YWdlIjoiZW4tVVMiLCJ2YWx1ZSI6Ikdvb2dsZSBJL08gJzIyIn19LCJzdWJoZWFkZXIiOnsiZGVmYXVsdFZhbHVlIjp7Imxhbmd1YWdlIjoiZW4tVVMiLCJ2YWx1ZSI6IkF0dGVuZGVlIn19LCJoZWFkZXIiOnsiZGVmYXVsdFZhbHVlIjp7Imxhbmd1YWdlIjoiZW4tVVMiLCJ2YWx1ZSI6IkFsZXggTWNKYWNvYnMifX0sImJhcmNvZGUiOnsidHlwZSI6IlFSX0NPREUiLCJ2YWx1ZSI6IjMzODgwMDAwMDAwMjIzMjA4MzUuY29kZWxhYl9vYmplY3QifSwiaGVyb0ltYWdlIjp7InNvdXJjZVVyaSI6eyJ1cmkiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vd2FsbGV0LWxhYi10b29scy1jb2RlbGFiLWFydGlmYWN0cy1wdWJsaWMvZ29vZ2xlLWlvLWhlcm8tZGVtby1vbmx5LmpwZyJ9fSwidGV4dE1vZHVsZXNEYXRhIjpbeyJoZWFkZXIiOiJQT0lOVFMiLCJib2R5IjoiMTIzNCIsImlkIjoicG9pbnRzIn0seyJoZWFkZXIiOiJDT05UQUNUUyIsImJvZHkiOiIyMCIsImlkIjoiY29udGFjdHMifV19XX0sImlhdCI6MTcwOTgxNjAwMX0.GlOqq16xffx81VAEXjr_4GarjYCOYFgo8R1Tl-c7LxRT-x-axfXIXISvRCpCIKSbzA7ralpkuYqyFXDGsncaaz_iv2S93Vk16ZZ2fpFycqXVBsCgfDdS2_bix5E1ZAqr15ENdnzsBGEjYRZxKI5Klz2et5j5yHTzeXnaKWX9spVsP3Gjgwxj--XeekktfT_0fRR3UYiC-6r-QBxqlC-iRhu8DAQWY1Z1J6z3c3Nm2MJiG9BR_eEoL-3dvQ1wgp_vqNqDBP-8otBA3suyfxhbblqCIFren4ta7iLEzyk72ftHIfDJKfse25Y9W-V6HzcF4GvDvaMDVyCfOqmM_7vdFA';

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
                    const SizedBox(height: 10),
                    //google wallet button
                    if(kIsWeb)...[
                         AddToGoogleWebWalletButton(
                             onPressed: () {
                               _savePassBrowser();
                             },
                             onSuccess:  () async {
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
                    ] else if(Platform.isAndroid)...[
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
                    ] else ...[
                      //Show nothing for other platforms
                    ],
                      
                    
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

    Future<void> _savePassBrowser() async{
      String url = "https://pay.google.com/gp/v/save/${jwt}";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not open Google Wallet via web';
    }
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
                "value": "Gamer"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "Player"
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