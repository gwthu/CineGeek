import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/theme.dart';
import '../../helper/utility.dart';
import '../../state/authState.dart';
import '../../widgets/customWidgets.dart';
import 'profilePage.dart';

class ProfileImageView extends StatelessWidget {
  const ProfileImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<Choice> choices = <Choice>[
      Choice(title: 'Share image link', icon: Icons.share),
      Choice(title: 'Open in browser', icon: Icons.open_in_browser),
      Choice(title: 'Save', icon: Icons.save),
    ];
    var authstate = Provider.of<AuthState>(context, listen: false);
    return Scaffold(
      backgroundColor: TwitterColor.white,
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<Choice>(
            onSelected: (d) {
              switch (d.title) {
                case "Share image link":
                  share(authstate.profileUserModel!.profilePic!);
                  break;
                case "Open in browser":
                  launchURL(authstate.profileUserModel!.profilePic!);
                  break;
                case "Save":
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title!),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: fullWidth(context),
          // height: fullWidth(context),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: customAdvanceNetworkImage(
                  authstate.profileUserModel!.profilePic),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
