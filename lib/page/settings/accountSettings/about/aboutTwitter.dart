import 'package:flutter/material.dart';

import '../../../../helper/theme.dart';
import '../../../../helper/utility.dart';
import '../../../../widgets/customAppBar.dart';
import '../../../../widgets/customWidgets.dart';
import '../../widgets/headerWidget.dart';
import '../../widgets/settingsRowWidget.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TwitterColor.white,
      appBar: CustomAppBar(
        isBackButton: true,
        title: customTitleText(
          'About CineGeek',
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          const HeaderWidget(
            'Help',
            secondHeader: true,
          ),
          SettingRowWidget(
            "Help Centre",
            vPadding: 15,
            showDivider: false,
            onPressed: () {
              launchURL(
                  "https://github.com/TheAlphamerc/flutter_twitter_clone/issues");
            },
          ),
          const HeaderWidget('Legal'),
          const SettingRowWidget(
            "Terms of Service",
            showDivider: true,
          ),
          const SettingRowWidget(
            "Privacy policy",
            showDivider: true,
          ),
          const SettingRowWidget(
            "Cookie use",
            showDivider: true,
          ),
          SettingRowWidget(
            "Legal notices",
            showDivider: true,
            onPressed: () async {
              showLicensePage(
                context: context,
                applicationName: 'CineGeek',
                applicationVersion: '1.0.0',
                useRootNavigator: true,
              );
            },
          )
        ],
      ),
    );
  }
}
