import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/constant.dart';
import '../../helper/theme.dart';
import '../../helper/utility.dart';
import '../../model/feedModel.dart';
import '../../model/user.dart';
import '../../state/searchState.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/customWidgets.dart';
import '../../widgets/newWidget/rippleButton.dart';
import '../../widgets/newWidget/title_text.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final state = Provider.of<SearchState>(context, listen: false);
      state.resetFilterList();
    });
    super.initState();
  }

  void onSettingIconPressed() {
    Navigator.pushNamed(context, '/TrendsPage');
  }

  @override
  Widget build(BuildContext context) {
    // final state = Provider.of<SearchState>(context);
    // final tweetList = state.tweetList;
    // final list = state.userlist;

    // debugPrint(
    //     "tweetlist length is ${tweetList?.length} ,list length is ${list?.length}");
    return Consumer<SearchState>(builder: (context, state, child) {
      return Scaffold(
        appBar: CustomAppBar(
          scaffoldKey: widget.scaffoldKey,
          icon: AppIcon.settings,
          onActionPressed: onSettingIconPressed,
          onSearchChanged: (text) {
            state.filterByUsername(text);
            state.filterByPost(text);
          },
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              state.getDataFromDatabase();
              state.getTweetsFromDatabase();
              return Future.value(true);
            },
            child: ListView(
              children: [
                ListView.separated(
                  addAutomaticKeepAlives: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => _UserTile(
                    user: state.userlist![index],
                  ),
                  separatorBuilder: (_, index) => const Divider(
                    height: 0,
                  ),
                  itemCount: state.userlist?.length ?? 0,
                ),
                ListView.separated(
                  addAutomaticKeepAlives: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => _UserTile(
                    feed: state.tweetList![index],
                  ),
                  separatorBuilder: (_, index) => const Divider(
                    height: 0,
                  ),
                  itemCount: state.tweetList?.length ?? 0,
                ),
              ],
            )),
      );
    });
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({Key? key, this.user, this.feed}) : super(key: key);
  final UserModel? user;
  final FeedModel? feed;

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      onPressed: () {
        kAnalytics.logViewSearchResults(searchTerm: user!.userName!);
        Navigator.of(context).pushNamed('/ProfilePage/' + user!.userId!);
      },
      child: feed != null
          ? Container(
              color: TwitterColor.white,
              child: ListTile(
                leading:
                    customImage(context, feed!.user!.profilePic, height: 40),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: TitleText(feed!.user!.displayName,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(width: 3),
                    feed!.user!.isVerified!
                        ? customIcon(
                            context,
                            icon: AppIcon.blueTick,
                            istwitterIcon: true,
                            iconColor: AppColor.primary,
                            size: 13,
                            paddingIcon: 3,
                          )
                        : const SizedBox(width: 0),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(feed!.user!.userName!)
                  ],
                ),
                subtitle: Text(feed!.description!),
              ),
            )
          : Container(
              color: TwitterColor.white,
              child: ListTile(
                leading: customImage(context, user!.profilePic, height: 40),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
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
              ),
            ),
    );
  }
}
