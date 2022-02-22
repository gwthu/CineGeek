import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/theme.dart';
import '../../model/user.dart';
import '../../state/searchState.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/customWidgets.dart';
import '../../widgets/newWidget/emptyList.dart';
import 'widget/userListWidget.dart';

class UsersListPage extends StatelessWidget {
  UsersListPage({
    Key? key,
    this.pageTitle = "",
    this.appBarIcon,
    this.emptyScreenText,
    this.emptyScreenSubTileText,
    this.userIdsList,
  }) : super(key: key);

  final String pageTitle;
  final String? emptyScreenText;
  final String? emptyScreenSubTileText;
  final int? appBarIcon;
  final List<String?>? userIdsList;

  @override
  Widget build(BuildContext context) {
    List<UserModel>? userList;
    return Scaffold(
      backgroundColor: TwitterColor.mystic,
      appBar: CustomAppBar(
          isBackButton: true,
          title: customTitleText(pageTitle),
          icon: appBarIcon),
      body: Consumer<SearchState>(
        builder: (context, state, child) {
          if (userIdsList != null) {
            /// If userIdsList Is not null then
            /// Fetch user corresponding to userId from search user page
            /// Search user page contains all user's profile data
            userList = state.getuserDetail(userIdsList);
          }
          return !(userList != null && userList!.isNotEmpty)

              /// If user list is empty then display empty list message
              ? Container(
                  width: fullWidth(context),
                  padding: EdgeInsets.only(top: 0, left: 30, right: 30),
                  child: NotifyText(
                    title: emptyScreenText,
                    subTitle: emptyScreenSubTileText,
                  ),
                )

              /// If user list is not empty then display user list
              : UserListWidget(
                  userslist: userList,
                  emptyScreenText: emptyScreenText,
                  emptyScreenSubTileText: emptyScreenSubTileText,
                );
        },
      ),
    );
  }
}
