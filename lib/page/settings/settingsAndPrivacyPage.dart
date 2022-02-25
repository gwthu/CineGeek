import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/theme.dart';
import '../../model/user.dart';
import '../../state/authState.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/customWidgets.dart';
import 'widgets/headerWidget.dart';
import 'widgets/settingsRowWidget.dart';

class SettingsAndPrivacyPage extends StatelessWidget {
  const SettingsAndPrivacyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthState>(context).userModel ?? UserModel();
    return Scaffold(
      backgroundColor: TwitterColor.white,
      appBar: CustomAppBar(
        isBackButton: true,
        title: customTitleText(
          'Settings and privacy',
        ),
      ),
      body: ListView(
        children: <Widget>[
          HeaderWidget(user.userName),
          const SettingRowWidget(
            "Account",
            navigateTo: 'AccountSettingsPage',
          ),
          const Divider(height: 0),
          const SettingRowWidget("Privacy and Policy",
              navigateTo: 'PrivacyAndSaftyPage'),
          const HeaderWidget(
            'General',
            secondHeader: true,
          ),
          const SettingRowWidget(
            "About CineGeek",
            navigateTo: "AboutPage",
          ),
          const SettingRowWidget(
            null,
            showDivider: false,
            vPadding: 10,
            subtitle:
                'These settings affect all of your CineGeek accounts on this devce.',
          )
        ],
      ),
    );
  }
}
