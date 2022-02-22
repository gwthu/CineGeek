import 'package:flutter/material.dart';

import '../../../../helper/theme.dart';
import '../../../../widgets/customAppBar.dart';
import '../../../../widgets/customWidgets.dart';
import '../../../../widgets/newWidget/title_text.dart';
import '../../widgets/headerWidget.dart';
import '../../widgets/settingsRowWidget.dart';

class DisplayAndSoundPage extends StatelessWidget {
  const DisplayAndSoundPage({Key? key}) : super(key: key);

  void openBottomSheet(
    BuildContext context,
    double height,
    Widget child,
  ) async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: height,
          decoration: const BoxDecoration(
            color: TwitterColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: child,
        );
      },
    );
  }

  void openDarkModeSettings(BuildContext context) {
    openBottomSheet(
      context,
      250,
      Column(
        children: <Widget>[
          const SizedBox(height: 5),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: TwitterColor.paleSky50,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TitleText('Dark Mode'),
          ),
          const Divider(height: 0),
          _row("On"),
          const Divider(height: 0),
          _row("Off"),
          const Divider(height: 0),
          _row("Automatic at sunset"),
        ],
      ),
    );
  }

  void openDarkModeAppearanceSettings(BuildContext context) {
    openBottomSheet(
      context,
      190,
      Column(
        children: <Widget>[
          const SizedBox(height: 5),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: TwitterColor.paleSky50,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TitleText('Dark mode appearance'),
          ),
          const Divider(height: 0),
          _row("Dim"),
          const Divider(height: 0),
          _row("Light out"),
        ],
      ),
    );
  }

  Widget _row(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      child: RadioListTile(
        value: false,
        groupValue: true,
        onChanged: (dynamic val) {},
        title: Text(text),
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TwitterColor.white,
      appBar: CustomAppBar(
        isBackButton: true,
        title: customTitleText(
          'Display and Sound',
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          const HeaderWidget('Media'),
          const SettingRowWidget(
            "Media Previews",
            showCheckBox: true,
          ),
          const Divider(height: 0),
          const HeaderWidget('Display'),
          SettingRowWidget(
            "Dark Mode",
            subtitle: 'Off',
            onPressed: () {
              openDarkModeSettings(context);
            },
            showDivider: false,
          ),
          SettingRowWidget(
            "Dark Mode appearance",
            subtitle: 'Dim',
            onPressed: () {
              openDarkModeAppearanceSettings(context);
            },
            showDivider: false,
          ),
          const SettingRowWidget(
            "Emoji",
            subtitle:
                'Use the Fwitter set instead of your device\'s default set',
            showDivider: false,
            showCheckBox: true,
          ),
          const HeaderWidget(
            'Sound',
            secondHeader: true,
          ),
          const SettingRowWidget(
            "Sound effects",
            // vPadding: 15,
            showCheckBox: true,
          ),
          const HeaderWidget(
            'Web browser',
            secondHeader: true,
          ),
          const SettingRowWidget(
            "Use in-app browser",
            subtitle: 'Open external links with Fwitter browser',
            showCheckBox: true,
          ),
        ],
      ),
    );
  }
}
