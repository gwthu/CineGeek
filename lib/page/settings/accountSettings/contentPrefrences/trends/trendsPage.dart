import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../helper/enum.dart';
import '../../../../../helper/theme.dart';
import '../../../../../state/searchState.dart';
import '../../../../../widgets/customAppBar.dart';
import '../../../../../widgets/customWidgets.dart';
import '../../../../../widgets/newWidget/title_text.dart';
import '../../../widgets/settingsRowWidget.dart';

class TrendsPage extends StatelessWidget {
  String sortBy = "";

  TrendsPage({Key? key}) : super(key: key);

  void openBottomSheet(
      BuildContext context, double height, Widget child) async {
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

  void openUserSortSettings(BuildContext context) {
    openBottomSheet(
      context,
      340,
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
            child: TitleText('Sort user list'),
          ),
          const Divider(height: 0),
          _row(context, "Verified user first", SortUser.ByVerified),
          const Divider(height: 0),
          _row(context, "alphabetically", SortUser.ByAlphabetically),
          const Divider(height: 0),
          _row(context, "Newest user first", SortUser.ByNewest),
          const Divider(height: 0),
          _row(context, "Oldest user first", SortUser.ByOldest),
          const Divider(height: 0),
          _row(context, "User with max follower", SortUser.ByMaxFollower),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String text, SortUser sortBy) {
    final state = Provider.of<SearchState>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      child: RadioListTile<SortUser>(
        value: sortBy,
        activeColor: TwitterColor.dodgetBlue,
        groupValue: state.sortBy,
        onChanged: (val) {
          state.updateUserSortPrefrence = val;
          Navigator.pop(context);
        },
        title: Text(text, style: subtitleStyle),
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final state = Provider.of<SearchState>(context, listen: false);
      sortBy = state.selectedFilter;
    });
    return Scaffold(
      backgroundColor: TwitterColor.white,
      appBar: CustomAppBar(
        isBackButton: true,
        title: customTitleText(
          'Trends',
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          SettingRowWidget(
            "Search Filter",
            subtitle: sortBy,
            onPressed: () {
              openUserSortSettings(context);
            },
            showDivider: false,
          ),
          const SettingRowWidget(
            "Trends location",
            navigateTo: null,
            subtitle: 'New York',
            showDivider: false,
          ),
          const SettingRowWidget(
            null,
            subtitle:
                'You can see what\'s trending in a specfic location by selecting which location appears in your Trending tab.',
            navigateTo: null,
            showDivider: false,
            vPadding: 12,
          ),
        ],
      ),
    );
  }
}
