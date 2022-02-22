import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helper/constant.dart';
import '../../../state/authState.dart';
import '../../common/usersListPage.dart';

class FollowingListPage extends StatelessWidget {
  const FollowingListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    return UsersListPage(
        pageTitle: 'Following',
        userIdsList: state.profileUserModel!.followingList,
        appBarIcon: AppIcon.follow,
        emptyScreenText:
            '${state.profileUserModel?.userName ?? state.userModel!.userName} isn\'t follow anyone',
        emptyScreenSubTileText: 'When they do they\'ll be listed here.');
  }
}
