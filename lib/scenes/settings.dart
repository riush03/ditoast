import 'dart:math';

import 'package:collapsible/collapsible.dart';
import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:ditoast/i18n/strings.g.dart';
import 'package:ditoast/utils/prefs.dart';
import 'package:ditoast/utils/version.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const listTilePadding = EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 4,
    );
    const listTileContentPadding = EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    );
    const listTileShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    );
    final listTileColor = Color.lerp(
      colorScheme.surface,
      colorScheme.primary,
      0.1,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(t.settingsPage.title),
      ),
      body: ListView(
        children: [
          // ad consent
         
          // Hyperlegible font
          Padding(
            padding: listTilePadding,
            child: NesContainer(
              padding: EdgeInsets.zero,
              child: ValueListenableBuilder(
                valueListenable: Prefs.hyperlegibleFont,
                builder: (context, _, child) {
                  return CheckboxListTile.adaptive(
                    title: child,
                    secondary: NesIcon(
                      iconData: NesIcons.openEye,
                    ),
                    tileColor: listTileColor,
                    shape: listTileShape,
                    contentPadding: listTileContentPadding,
                    value: Prefs.hyperlegibleFont.value,
                    onChanged: (value) {
                      Prefs.hyperlegibleFont.value = value!;
                    },
                  );
                },
                child: Text(t.settingsPage.hyperlegibleFont),
              ),
            ),
          ),

          // Background music volume
          Padding(
            padding: listTilePadding,
            child: NesContainer(
              padding: EdgeInsets.zero,
              child: ListTile(
                tileColor: listTileColor,
                shape: listTileShape,
                contentPadding: listTileContentPadding,
                title: Text(t.settingsPage.bgmVolume),
                leading: NesIcon(
                  iconData: NesIcons.musicNote,
                ),
                trailing: SizedBox(
                  width: 200,
                  child: ListenableBuilder(
                    listenable: Prefs.bgmVolume,
                    builder: (context, _) {
                      return Slider.adaptive(
                        value: Prefs.bgmVolume.value,
                        onChanged: (value) {
                          Prefs.bgmVolume.value = value;
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          // Whether to show colliders
          Padding(
            padding: listTilePadding,
            child: NesContainer(
              padding: EdgeInsets.zero,
              child: ValueListenableBuilder(
                valueListenable: Prefs.showColliders,
                builder: (context, _, child) {
                  return CheckboxListTile.adaptive(
                    title: child,
                    secondary: NesIcon(
                      iconData: NesIcons.lamp,
                    ),
                    tileColor: listTileColor,
                    shape: listTileShape,
                    contentPadding: listTileContentPadding,
                    value: Prefs.showColliders.value,
                    onChanged: (value) {
                      Prefs.showColliders.value = value!;
                    },
                  );
                },
                child: Text(t.settingsPage.showColliders),
              ),
            ),
          ),

          // App info dialog
          Padding(
            padding: listTilePadding,
            child: NesContainer(
              padding: EdgeInsets.zero,
              child: ListTile(
                onTap: () {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final iconSize = min<double>(64, screenWidth * 0.15);
                  showAboutDialog(
                    context: context,
                    applicationName: t.appName,
                    applicationVersion: 'v$buildName ($buildNumber)',
                    applicationIcon: Image.asset(
                      'assets/icon/icon.png',
                      width: iconSize,
                      height: iconSize,
                    ),
                    applicationLegalese: t.settingsPage.licenseNotice(
                      buildYear: buildYear,
                    ),
                  );
                },
                tileColor: listTileColor,
                shape: listTileShape,
                contentPadding: listTileContentPadding,
                title: Text(t.settingsPage.appInfo),
                leading: NesIcon(
                  iconData: NesIcons.zoomIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
