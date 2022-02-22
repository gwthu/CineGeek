import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/constant.dart';
import '../../helper/utility.dart';
import '../../model/feedModel.dart';
import '../../model/user.dart';
import '../../state/authState.dart';
import '../../state/feedState.dart';
import '../../widgets/customWidgets.dart';
import '../../widgets/tweet/widgets/tweetIconsRow.dart';

class ImageViewPge extends StatefulWidget {
  _ImageViewPgeState createState() => _ImageViewPgeState();
}

class _ImageViewPgeState extends State<ImageViewPge> {
  bool isToolAvailable = true;

  FocusNode? _focusNode;
  TextEditingController? _textEditingController;

  @override
  void initState() {
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    super.initState();
  }

  Widget _body() {
    var state = Provider.of<FeedState>(context);
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            color: Colors.brown.shade700,
            constraints: BoxConstraints(
              maxHeight: fullHeight(context),
            ),
            child: InkWell(
                onTap: () {
                  setState(() {
                    isToolAvailable = !isToolAvailable;
                  });
                },
                child: InteractiveViewer(
                  child: _imageFeed(state.tweetToReplyModel!.imagePath),
                  maxScale: 4,
                  minScale: .1,
                  panEnabled: true,
                  constrained: true,
                  scaleEnabled: true,
                )),
          ),
        ),
        !isToolAvailable
            ? Container()
            : Align(
                alignment: Alignment.topLeft,
                child: SafeArea(
                  child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.brown.shade700.withAlpha(200),
                      ),
                      child: Wrap(
                        children: <Widget>[
                          const BackButton(
                            color: Colors.white,
                          ),
                        ],
                      )),
                )),
        !isToolAvailable
            ? Container()
            : Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TweetIconsRow(
                        model: state.tweetToReplyModel,
                        iconColor: Theme.of(context).colorScheme.onPrimary,
                        iconEnableColor:
                            Theme.of(context).colorScheme.onPrimary,
                      ),
                      Container(
                        color: Colors.brown.shade700.withAlpha(200),
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 10),
                        child: TextField(
                          controller: _textEditingController,
                          maxLines: null,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Colors.blue,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _submitButton();
                              },
                              icon: const Icon(Icons.send, color: Colors.white),
                            ),
                            focusColor: Colors.black,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            hintText: 'Comment here..',
                            hintStyle: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  Widget _imageFeed(String? _image) {
    return _image == null
        ? Container()
        : Container(
            alignment: Alignment.center,
            child: Container(
              child: customNetworkImage(
                _image,
                fit: BoxFit.fitWidth,
              ),
            ),
          );
  }

  void addLikeToTweet() {
    var state = Provider.of<FeedState>(context, listen: false);
    var authState = Provider.of<AuthState>(context, listen: false);
    state.addLikeToTweet(state.tweetToReplyModel!, authState.userId);
  }

  void _submitButton() {
    if (_textEditingController!.text == null ||
        _textEditingController!.text.isEmpty) {
      return;
    }
    if (_textEditingController!.text.length > 280) {
      return;
    }
    var state = Provider.of<FeedState>(context, listen: false);
    var authState = Provider.of<AuthState>(context, listen: false);
    var user = authState.userModel!;
    var profilePic = user.profilePic;
    if (profilePic == null) {
      profilePic = dummyProfilePic;
    }
    var name = authState.userModel!.displayName ??
        authState.userModel!.email!.split('@')[0];
    var pic = authState.userModel!.profilePic ?? dummyProfilePic;
    var tags = getHashTags(_textEditingController!.text);

    UserModel commentedUser = UserModel(
        displayName: name,
        userName: authState.userModel!.userName,
        isVerified: authState.userModel!.isVerified,
        profilePic: pic,
        userId: authState.userId);

    var postId = state.tweetToReplyModel!.key;

    FeedModel reply = FeedModel(
      description: _textEditingController!.text,
      user: commentedUser,
      createdAt: DateTime.now().toUtc().toString(),
      tags: tags,
      userId: commentedUser.userId,
      parentkey: postId,
    );
    state.addcommentToPost(reply);
    FocusScope.of(context).requestFocus(_focusNode);
    setState(() {
      _textEditingController!.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body());
  }
}
