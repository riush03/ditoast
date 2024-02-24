import 'dart:async';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:ditoast/utils/prefs.dart';

abstract class PassState{
  static bool _initializeStarted = false;
  static bool _initializeCompleted = false;

  static late final String _ditoastGamePass;

  static final String _passId = const Uuid().v4();
  static const String _passClass = 'example';
  static const String _issuerId = '3333000000000000000';
  static const String _issuerEmail = 'example@example.com';

  //check wether the google wallet pass is supported on the platform
  static bool get walletSupported => _ditoastGamePass.isNotEmpty;

  //check wether the user is old enough to use the wallet feature
    static bool get rewardedAdsSupported {
    if (!walletSupported) return false;
    final age = PassState.age;
    return age != null && age >= minAgeForWalletUsage;
  }

   /// The minimum age required to use google wallet.
  static const int minAgeForWalletUsage = 16;


  /// The user's age,
  /// calculated from their birth year,
  /// or null if the user has not entered their birth year.
  static int? get age {
    assert(Prefs.birthYear.loaded);

    final birthYear = Prefs.birthYear.value;
    if (birthYear == null) return null;

    // Subtract 1 because the user might not have
    // had their birthday yet this year.
    return DateTime.now().year - birthYear - 1;
  }

    /// Initializes pass.
  static void init() {
    if (kDebugMode) {
      // test ads
      if (kIsWeb) {
        _ditoastGamePass = '';
      } else if (Platform.isAndroid) {
        _ditoastGamePass = """ 
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
                "value": "Google I/O '22 [DEMO ONLY]"
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
      } else if (Platform.isIOS) {
        _ditoastGamePass = '';
      } 
    } else {
      // actual ads
      if (kIsWeb) {
              _ditoastGamePass = """ 
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
                "value": "Google I/O '22 [DEMO ONLY]"
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
      } else if (Platform.isAndroid) {
           _ditoastGamePass = """ 
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
                "value": "Google I/O '22 [DEMO ONLY]"
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
      } else if (Platform.isIOS) {
        _ditoastGamePass = '';
      } else {
        _ditoastGamePass = '';
      }
    }

    if (walletSupported) _startInitialize();
  }

    static Future<void> _startInitialize() async {
    if (_initializeStarted) return;

    final age = PassState.age;
    final canConsent = age != null && age >= minAgeForWalletUsage;
    if (canConsent) {
      if (!kIsWeb && Platform.isIOS) {
        var status = await AppTrackingTransparency.trackingAuthorizationStatus;
        if (status == TrackingStatus.notDetermined) {
          // wait to avoid crash
          await Future.delayed(const Duration(seconds: 3));

          status = await AppTrackingTransparency.requestTrackingAuthorization();
        }
    } 
    }


    assert(_ditoastGamePass.isNotEmpty);
    assert(!_initializeCompleted);
    _initializeStarted = true;
    _initializeCompleted = true;
  }

}