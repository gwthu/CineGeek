import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helper/constant.dart';
import '../../../helper/theme.dart';
import '../../../model/user.dart';
import '../../../state/authState.dart';
import '../../../widgets/customWidgets.dart';
import '../../../widgets/newWidget/rippleButton.dart';
import '../../../widgets/newWidget/title_text.dart';

class UserListWidget extends StatelessWidget {
  final List<UserModel>? userslist;
  final String? emptyScreenText;
  final String? emptyScreenSubTileText;
  UserListWidget({
    Key? key,
    this.userslist,
    this.emptyScreenText,
    this.emptyScreenSubTileText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context, listen: false);
    var myFollowingList = state.userModel!.followingList;
    String? myId = state.userModel!.key;
    return ListView.separated(
      itemBuilder: (context, index) {
        return UserTile(
            user: userslist![index],
            myId: myId,
            isFollow:
                myFollowingList!.any((id) => id == userslist![index].userId));
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 0,
        );
      },
      itemCount: userslist!.length,
    );
  }
}

/// if value of `isFollow` is true then display [Following] button
/// if value of `isFollow` is false then display [Follow] button
/// if myId is equal to [user.userId] then hide [Follow]/[Following] button
class UserTile extends StatelessWidget {
  const UserTile({Key? key, this.user, this.myId, this.isFollow})
      : super(key: key);
  final UserModel? user;
  final String? myId;
  final bool? isFollow;

  /// Return empty string for default bio
  /// Max length of bio is 100
  String? getBio(String? bio) {
    if (bio != null && bio.isNotEmpty && bio != "Edit profile to update bio") {
      if (bio.length > 100) {
        bio = bio.substring(0, 100) + '...';
        return bio;
      } else {
        return bio;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: TwitterColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/ProfilePage/' + user!.userId!);
            },
            leading: RippleButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/ProfilePage/' + user!.userId!);
              },
              borderRadius: const BorderRadius.all(const Radius.circular(60)),
              child: customImage(context, user!.profilePic, height: 55),
            ),
            title: Row(
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: 0, maxWidth: fullWidth(context) * .4),
                  child: TitleText(user!.displayName,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(width: 3),
                user!.isVerified!
                    ? customIcon(
                        context,
                        icon: AppIcon.blueTick,
                        istwitterIcon: true,
                        iconColor: AppColor.primary,
                        size: 13,
                        paddingIcon: 3,
                      )
                    : const SizedBox(width: 0),
              ],
            ),
            subtitle: Text(user!.userName!),
            trailing: myId == user!.userId
                ? const SizedBox.shrink()
                : RippleButton(
                    onPressed: () {},
                    splashColor: TwitterColor.dodgetBlue_50.withAlpha(100),
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isFollow! ? 15 : 20,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: isFollow!
                            ? TwitterColor.dodgetBlue
                            : TwitterColor.white,
                        border: Border.all(
                          color: TwitterColor.dodgetBlue,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        isFollow! ? 'Following' : 'Follow',
                        style: TextStyle(
                          color: isFollow! ? TwitterColor.white : Colors.blue,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ),
          getBio(user!.bio) == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(left: 90),
                  child: Text(
                    getBio(user!.bio)!,
                  ),
                )
        ],
      ),
    );
  }
}
