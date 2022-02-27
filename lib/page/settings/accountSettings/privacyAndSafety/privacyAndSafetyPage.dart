import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helper/theme.dart';
import '../../../../model/user.dart';
import '../../../../state/authState.dart';
import '../../widgets/headerWidget.dart';
import '../../widgets/settingsAppbar.dart';
import '../../widgets/settingsRowWidget.dart';

class PrivacyAndSaftyPage extends StatelessWidget {
  const PrivacyAndSaftyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthState>(context).userModel ?? UserModel();
    return Scaffold(
      backgroundColor: TwitterColor.white,
      appBar: SettingsAppBar(
        title: 'Privacy and safety',
        subtitle: user.userName,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: const <Widget>[
          HeaderWidget(
            'Live Video',
            secondHeader: true,
          ),
          SettingRowWidget(
            "Go Live",
            subtitle:
                'If selected, you can go live , and people will be able to see and comment you on live.',
            vPadding: 15,
            showDivider: false,
            visibleSwitch: true,
          ),
          HeaderWidget(
            'Safety',
            secondHeader: true,
          ),
          SettingRowWidget(
            "Display media that may contain sensitive content",
            vPadding: 15,
            showDivider: false,
            visibleSwitch: true,
          ),
          SettingRowWidget(
            "Blocked Accounts",
            showDivider: false,
          ),
          SettingRowWidget(
            "Muted Accounts",
            showDivider: false,
          ),
          SettingRowWidget(
            "Muted Words",
            showDivider: false,
          ),
          HeaderWidget(
            'Location',
            secondHeader: true,
          ),
          SettingRowWidget(
            "Precise location",
            subtitle:
                'Disabled \n\n\nIf enabled, CineGeek will collect, store, and use your device\'s precise location, such as your GPS information. This lets CineGeek improve your experience - for rxample, showing you more local content, ads, and recommendations.',
          ),
        ],
      ),
    );
  }
}
