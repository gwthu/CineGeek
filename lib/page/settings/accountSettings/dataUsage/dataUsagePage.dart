import 'package:flutter/material.dart';

import '../../../../helper/theme.dart';
import '../../../../widgets/customAppBar.dart';
import '../../../../widgets/customWidgets.dart';
import '../../../../widgets/newWidget/title_text.dart';
import '../../widgets/headerWidget.dart';
import '../../widgets/settingsRowWidget.dart';

class DataUsagePage extends StatelessWidget {
  const DataUsagePage({Key? key}) : super(key: key);

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
              topRight: const Radius.circular(15),
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
            padding: EdgeInsets.symmetric(vertical: 15),
            child: TitleText('Data preference'),
          ),
          const Divider(height: 0),
          _row("Mobile data & Wi-Fi"),
          const Divider(height: 0),
          _row("Wi-Fi only"),
          const Divider(height: 0),
          _row("Never"),
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
          'Data Usage',
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          const HeaderWidget('Data Saver'),
          const SettingRowWidget(
            "Data saver",
            showCheckBox: true,
            vPadding: 15,
            showDivider: false,
            subtitle:
                'When enabled, video won\'t autoplay and lower-quality images load. This automatically reduces your data usage for all Fwitter accounts on this device.',
          ),
          const Divider(height: 0),
          const HeaderWidget('Images'),
          SettingRowWidget(
            "High quality images",
            subtitle:
                'Mobile data & Wi-Fi \n\nSelect when high quality images should load.',
            vPadding: 15,
            onPressed: () {
              openDarkModeSettings(context);
            },
            showDivider: false,
          ),
          const HeaderWidget(
            'Video',
            secondHeader: true,
          ),
          SettingRowWidget(
            "High-quality video",
            subtitle:
                'Wi-Fi only \n\nSelect when the highest quality available should play.',
            vPadding: 15,
            onPressed: () {
              openDarkModeSettings(context);
            },
          ),
          SettingRowWidget(
            "Video autoplay",
            subtitle:
                'Wi-Fi only \n\nSelect when video should play automatically.',
            vPadding: 15,
            onPressed: () {
              openDarkModeSettings(context);
            },
          ),
          const HeaderWidget(
            'Data sync',
            secondHeader: true,
          ),
          const SettingRowWidget(
            "Sync data",
            showCheckBox: true,
          ),
          const SettingRowWidget(
            "Sync interval",
            subtitle: 'Daily',
          ),
          const SettingRowWidget(
            null,
            subtitle:
                'Allow Fwitter to sync data in the background to enhance your experience.',
            vPadding: 10,
          ),
        ],
      ),
    );
  }
}
