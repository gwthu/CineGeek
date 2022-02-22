import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../helper/theme.dart';
import '../../helper/utility.dart';
import '../../model/chatModel.dart';
import '../../model/user.dart';
import '../../state/authState.dart';
import '../../state/chats/chatState.dart';
import '../../state/chats/chatUserState.dart';
import '../../widgets/customWidgets.dart';
import '../../widgets/newWidget/customUrlText.dart';

class ChatScreenPage extends StatefulWidget {
  ChatScreenPage({Key? key, this.userProfileId}) : super(key: key);

  final String? userProfileId;

  _ChatScreenPageState createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  final messageController = new TextEditingController();
  String? senderId;
  String? userImage;
  late ChatState state;
  ScrollController? _controller;
  GlobalKey<ScaffoldState>? _scaffoldKey;

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _controller = ScrollController();
    final chatUserState = Provider.of<ChatUserState>(context, listen: false);
    final chatState = Provider.of<ChatState>(context, listen: false);
    final state = Provider.of<AuthState>(context, listen: false);
    chatState.setChatUser = chatUserState.chatUser;
    senderId = state.userId;
    chatState.databaseInit(chatState.chatUser!.userId!, state.userId!);
    chatState.getchatDetailAsync();
    super.initState();
  }

  Widget _chatScreenBody() {
    final state = Provider.of<ChatState>(context);
    if (state.messageList == null || state.messageList!.length == 0) {
      return const Center(
        child: Text(
          'No message found',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      );
    }
    return ListView.builder(
      controller: _controller,
      shrinkWrap: true,
      reverse: true,
      physics: const BouncingScrollPhysics(),
      itemCount: state.messageList!.length,
      itemBuilder: (context, index) => chatMessage(state.messageList![index]),
    );
  }

  Widget chatMessage(ChatMessage message) {
    if (senderId == null) {
      return Container();
    }
    if (message.senderId == senderId)
      return _message(message, true);
    else
      return _message(message, false);
  }

  Widget _message(ChatMessage chat, bool myMessage) {
    return Column(
      crossAxisAlignment:
          myMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisAlignment:
          myMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            const SizedBox(
              width: 15,
            ),
            myMessage
                ? const SizedBox()
                : CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: customAdvanceNetworkImage(userImage),
                  ),
            Expanded(
              child: Container(
                alignment:
                    myMessage ? Alignment.centerRight : Alignment.centerLeft,
                margin: EdgeInsets.only(
                  right: myMessage ? 10 : (fullWidth(context) / 4),
                  top: 20,
                  left: myMessage ? (fullWidth(context) / 4) : 10,
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: getBorder(myMessage),
                        color: myMessage
                            ? TwitterColor.dodgetBlue
                            : TwitterColor.mystic,
                      ),
                      child: UrlText(
                        text: chat.message,
                        style: TextStyle(
                          fontSize: 16,
                          color: myMessage ? TwitterColor.white : Colors.black,
                        ),
                        urlStyle: TextStyle(
                          fontSize: 16,
                          color: myMessage
                              ? TwitterColor.white
                              : TwitterColor.dodgetBlue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: InkWell(
                        borderRadius: getBorder(myMessage),
                        onLongPress: () {
                          var text = ClipboardData(text: chat.message);
                          Clipboard.setData(text);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: TwitterColor.white,
                              content: const Text(
                                'Message copied',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        },
                        child: const SizedBox(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Text(
            getChatTime(chat.createdAt),
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12),
          ),
        )
      ],
    );
  }

  BorderRadius getBorder(bool myMessage) {
    return BorderRadius.only(
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
      bottomRight:
          myMessage ? const Radius.circular(0) : const Radius.circular(20),
      bottomLeft:
          myMessage ? const Radius.circular(20) : const Radius.circular(0),
    );
  }

  Widget _bottomEntryField() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const Divider(
            thickness: 0,
            height: 1,
          ),
          TextField(
            onSubmitted: (val) async {
              submitMessage();
            },
            controller: messageController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
              alignLabelWithHint: true,
              hintText: 'Start with a message...',
              suffixIcon: IconButton(
                  icon: const Icon(Icons.send), onPressed: submitMessage),
              // fillColor: Colors.black12, filled: true
            ),
          ),
        ],
      ),
    );
  }

  void submitMessage() {
    // var state = Provider.of<ChatUserState>(context, listen: false);
    var authstate = Provider.of<AuthState>(context, listen: false);
    ChatMessage message;
    message = ChatMessage(
        message: messageController.text,
        createdAt: DateTime.now().toUtc().toString(),
        senderId: authstate.userModel!.userId,
        receiverId: state.chatUser!.userId,
        seen: false,
        timeStamp: DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
        senderName: authstate.user!.displayName);
    if (messageController.text == null || messageController.text.isEmpty) {
      return;
    }
    UserModel myUser = UserModel(
        displayName: authstate.userModel!.displayName,
        userId: authstate.userModel!.userId,
        userName: authstate.userModel!.userName,
        profilePic: authstate.userModel!.profilePic);
    UserModel secondUser = UserModel(
      displayName: state.chatUser!.displayName,
      userId: state.chatUser!.userId,
      userName: state.chatUser!.userName,
      profilePic: state.chatUser!.profilePic,
    );
    state.onMessageSubmitted(message, myUser: myUser, secondUser: secondUser);
    Future.delayed(const Duration(milliseconds: 50)).then((_) {
      messageController.clear();
    });
    try {
      // final state = Provider.of<ChatUserState>(context,listen: false);
      if (state.messageList != null &&
          state.messageList!.length > 1 &&
          _controller!.offset > 0) {
        _controller!.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      }
    } catch (e) {
      print("[Error] $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<ChatState>(context, listen: false);
    userImage = state.chatUser!.profilePic;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UrlText(
              text: state.chatUser!.displayName,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              state.chatUser!.userName!,
              style: const TextStyle(color: AppColor.darkGrey, fontSize: 15),
            )
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.info, color: AppColor.primary),
              onPressed: () {
                Navigator.pushNamed(context, '/ConversationInformation');
              })
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: _chatScreenBody(),
              ),
            ),
            _bottomEntryField()
          ],
        ),
      ),
    );
  }
}
