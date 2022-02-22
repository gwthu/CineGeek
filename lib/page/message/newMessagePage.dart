import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/constant.dart';
import '../../helper/theme.dart';
import '../../model/user.dart';
import '../../state/chats/chatUserState.dart';
import '../../state/searchState.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/customWidgets.dart';
import '../../widgets/newWidget/title_text.dart';

class NewMessagePage extends StatefulWidget {
  const NewMessagePage({Key? key, this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  State<StatefulWidget> createState() => _NewMessagePageState();
}

class _NewMessagePageState extends State<NewMessagePage> {
  TextEditingController? textController;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  Widget _userTile(UserModel user) {
    return ListTile(
      onTap: () {
        final chatState = Provider.of<ChatUserState>(context, listen: false);
        chatState.setChatUser = user;
        Navigator.pushNamed(context, '/ChatScreenPage');
      },
      leading: customImage(context, user.profilePic, height: 40),
      title: Row(
        children: <Widget>[
          ConstrainedBox(
            constraints:
                BoxConstraints(minWidth: 0, maxWidth: fullWidth(context) - 104),
            child: TitleText(user.displayName,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(width: 3),
          user.isVerified!
              ? customIcon(context,
                  icon: AppIcon.blueTick,
                  istwitterIcon: true,
                  iconColor: AppColor.primary,
                  size: 13,
                  paddingIcon: 3)
              : const SizedBox(width: 0),
        ],
      ),
      subtitle: Text(user.userName!),
    );
  }

  Future<bool> _onWillPop() async {
    final state = Provider.of<SearchState>(context, listen: false);
    state.filterByUsername("");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: CustomAppBar(
          scaffoldKey: widget.scaffoldKey,
          isBackButton: true,
          isbootomLine: true,
          title: customTitleText(
            'New Message',
          ),
        ),
        body: Consumer<SearchState>(
          builder: (context, state, child) {
            return Column(
              children: <Widget>[
                TextField(
                  onChanged: (text) {
                    state.filterByUsername(text);
                  },
                  decoration: InputDecoration(
                    hintText: "Search for people and groups",
                    hintStyle: const TextStyle(fontSize: 20),
                    prefixIcon: customIcon(
                      context,
                      icon: AppIcon.search,
                      istwitterIcon: true,
                      iconColor: TwitterColor.woodsmoke_50,
                      size: 25,
                      paddingIcon: 5,
                    ),
                    border: InputBorder.none,
                    fillColor: TwitterColor.mystic,
                    filled: true,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => _userTile(
                      state.userlist![index],
                    ),
                    separatorBuilder: (_, index) => const Divider(
                      height: 0,
                    ),
                    itemCount: state.userlist!.length,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
