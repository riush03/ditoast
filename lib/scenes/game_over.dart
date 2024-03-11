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
  final String jwt = 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJkZW5pc2tleXNAYXJjb3JlaGFja3Rob24uaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLCJhdWQiOiJnb29nbGUiLCJvcmlnaW5zIjpbImh0dHA6Ly9sb2NhbGhvc3Q6MzAwMCJdLCJ0eXAiOiJzYXZldG93YWxsZXQiLCJwYXlsb2FkIjp7ImdlbmVyaWNPYmplY3RzIjpbeyJpZCI6IjMzODgwMDAwMDAwMjIzMjA4MzUuZGl0b2FzdF9vYmplY3QiLCJjbGFzc0lkIjoiMzM4ODAwMDAwMDAyMjMyMDgzNS5nYW1lX2NsYXNzIiwiZ2VuZXJpY1R5cGUiOiJHRU5FUklDX1RZUEVfVU5TUEVDSUZJRUQiLCJoZXhCYWNrZ3JvdW5kQ29sb3IiOiIjMjE3MzQwIiwibG9nbyI6eyJzb3VyY2VVcmkiOnsidXJpIjoiaHR0cHM6Ly9kZW5ub3RlY2guY28ua2Uvd3AtY29udGVudC91cGxvYWRzLzIwMjQvMDMvaWNvbnM4LXNhdmUtZWFydGgtNjQucG5nIn19LCJjYXJkVGl0bGUiOnsiZGVmYXVsdFZhbHVlIjp7Imxhbmd1YWdlIjoiZW4tVVMiLCJ2YWx1ZSI6IkdhbWUgUmVkZWVtaW5nIFBhc3MifX0sInN1YmhlYWRlciI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiRGl0b2FzdCJ9fSwiaGVhZGVyIjp7ImRlZmF1bHRWYWx1ZSI6eyJsYW5ndWFnZSI6ImVuLVVTIiwidmFsdWUiOiJQYXNzIGZvciByZWRlZW1pbmcgZ2FtZSJ9fSwiYmFyY29kZSI6eyJ0eXBlIjoiUVJfQ09ERSIsInZhbHVlIjoiMzM4ODAwMDAwMDAyMjMyMDgzNS5kaXRvYXN0X29iamVjdCJ9LCJoZXJvSW1hZ2UiOnsic291cmNlVXJpIjp7InVyaSI6Imh0dHBzOi8vZGVubm90ZWNoLmNvLmtlL3dwLWNvbnRlbnQvdXBsb2Fkcy8yMDI0LzAyL1NjcmVlbnNob3RfMS0xNTM2eDcyNy5wbmcifX0sInRleHRNb2R1bGVzRGF0YSI6W3siaGVhZGVyIjoiUE9JTlRTIiwiYm9keSI6IjEyMzQiLCJpZCI6InBvaW50cyJ9LHsiaGVhZGVyIjoiQ09OVEFDVFMiLCJib2R5IjoiMjAiLCJpZCI6ImNvbnRhY3RzIn1dfV19LCJpYXQiOjE3MTAxNDQ2MDd9.Ak6R2AP8xRdVCPpV0FCh-dWxbhchNLOw5dKPxngKvv5L1Cp4S0cYM8LIInolCSvNt8mlEpECS9Hm3d3zKCZMzxeutXMp1YvIB-85GUfCOmLM4av4Z2QjJe3448kaT2kcqmKA6k2zqk2SdZfqtbUh5fBGI3V-Dgp8mAMozQHRms4rRjX9jHxx_WpOU4F4mDNEJwy2EvyouR7dEfaToaE4rlDaZ5ZlBuoIYyI1d8ZWLJDynJsBbgV_e96tzzsFulVOqVjutTE20dcV2HgH-QVmg8Geq0H65IUG8v4l8KbgT0FAdlGNqckcUzEZado5yJ2rYT3WraUKMJXBWIjyYz1OzQ';

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
                               context.pop<GameOverAction>(GameOverAction.continueGame);
                             },
                             onSuccess:  () async {
                                _showSnackBar(context, 'Added to wallet successfully');
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
const String _issuerEmail = 'deniskeys@arcorehackthon.iam.gserviceaccount.com';


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
            "hexBackgroundColor": "#217340",
            "logo": {
              "sourceUri": {
                "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/pass_google_logo.jpg"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "en",
                "value": "Game Redeeming Pass"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "en",
                "value": "Ditoast"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "Pass for redeeming game"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "$_passId"
            },
            "heroImage": {
              "sourceUri": {
                "uri": "https://dennotech.co.ke/wp-content/uploads/2024/02/Screenshot_1-1536x727.png"
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