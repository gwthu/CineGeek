import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/constant.dart';
import '../../helper/theme.dart';
import '../../helper/utility.dart';
import '../../model/chatModel.dart';
import '../../model/user.dart';
import '../../state/authState.dart';
import '../../state/chats/chatUserState.dart';
import '../../state/searchState.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/customWidgets.dart';
import '../../widgets/newWidget/emptyList.dart';
import '../../widgets/newWidget/rippleButton.dart';
import '../../widgets/newWidget/title_text.dart';

class ChatListPage extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const ChatListPage({Key? key, this.scaffoldKey}) : super(key: key);
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  void initState() {
    final chatState = Provider.of<ChatUserState>(context, listen: false);
    final state = Provider.of<AuthState>(context, listen: false);
    chatState.setIsChatScreenOpen = true;

    // chatState.databaseInit(state.profileUserModel.userId,state.userId);
    chatState.getUserchatList(state.user!.uid);
    super.initState();
  }

  Widget _body() {
    final state = Provider.of<ChatUserState>(context);
    final searchState = Provider.of<SearchState>(context, listen: false);
    if (state.chatUserList == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: EmptyList(
          'No message available ',
          subTitle:
              'When someone sends you message,User list\'ll show up here \n  To send message tap message button.',
        ),
      );
    } else {
      return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: state.chatUserList!.length,
        itemBuilder: (context, index) => _userCard(
            searchState.userlist!.firstWhere(
              (x) => x.userId == state.chatUserList![index].key,
              orElse: () => UserModel(userName: "Unknown"),
            ),
            state.chatUserList![index]),
        separatorBuilder: (context, index) {
          return const Divider(
            height: 0,
          );
        },
      );
    }
  }

  Widget _userCard(UserModel model, ChatMessage lastMessage) {
    return Container(
      color: Colors.white,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        onTap: () {
          final chatState = Provider.of<ChatUserState>(context, listen: false);
          final searchState = Provider.of<SearchState>(context, listen: false);
          chatState.setChatUser = model;
          if (searchState.userlist!.any((x) => x.userId == model.userId)) {
            chatState.setChatUser = searchState.userlist!
                .where((x) => x.userId == model.userId)
                .first;
          }
          Navigator.pushNamed(context, '/ChatScreenPage');
        },
        leading: RippleButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/ProfilePage/${model.userId}');
          },
          borderRadius: BorderRadius.circular(28),
          child: Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(28),
              image: DecorationImage(
                  image: customAdvanceNetworkImage(
                    model.profilePic ?? dummyProfilePic,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        title: Row(
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: 0, maxWidth: fullWidth(context) * .5),
              child: TitleText(model.displayName,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(width: 3),
            model.isVerified!
                ? customIcon(
                    context,
                    icon: AppIcon.blueTick,
                    istwitterIcon: true,
                    iconColor: AppColor.primary,
                    size: 13,
                    paddingIcon: 3,
                  )
                : const SizedBox(width: 0),
            SizedBox(
              width: model.isVerified! ? 5 : 0,
            ),
            customText('${model.userName}', style: userNameStyle),
            const Spacer(),
            lastMessage == null
                ? const SizedBox.shrink()
                : TitleText(
                    getChatTime(lastMessage.createdAt).toString(),
                    fontSize: 14,
                    color: AppColor.darkGrey,
                    fontWeight: FontWeight.w500,
                  ),
          ],
        ),
        subtitle: TitleText(
          trimMessage(lastMessage.message) ?? '@${model.displayName}',
          color: AppColor.darkGrey,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          // overflow: TextOverflow.ellipsis,
        ),
        // trailing: lastMessage == null
        //     ? SizedBox.shrink()
        //     : TitleText(
        //         getChatTime(lastMessage.createdAt).toString(),
        //         fontSize: 14,
        //         color: AppColor.darkGrey,
        //         fontWeight: FontWeight.w500,
        //       ),
      ),
    );
  }

  FloatingActionButton _newMessageButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/NewMessagePage');
      },
      child: customIcon(
        context,
        icon: AppIcon.newMessage,
        istwitterIcon: true,
        iconColor: Theme.of(context).colorScheme.onPrimary,
        size: 25,
      ),
    );
  }

  void onSettingIconPressed() {
    Navigator.pushNamed(context, '/DirectMessagesPage');
  }

  String? trimMessage(String? message) {
    if (message != null && message.isNotEmpty) {
      if (message.length > 70) {
        message = message.substring(0, 70) + '...';
        return message;
      } else {
        return message;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        scaffoldKey: widget.scaffoldKey,
        title: customTitleText(
          'Messages',
        ),
        icon: AppIcon.settings,
        onActionPressed: onSettingIconPressed,
      ),
      floatingActionButton: _newMessageButton(),
      backgroundColor: TwitterColor.mystic,
      body: _body(),
    );
  }
}
