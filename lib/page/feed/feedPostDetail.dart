import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/enum.dart';
import '../../helper/theme.dart';
import '../../model/feedModel.dart';
import '../../state/authState.dart';
import '../../state/feedState.dart';
import '../../widgets/customWidgets.dart';
import '../../widgets/tweet/tweet.dart';
import '../../widgets/tweet/widgets/tweetBottomSheet.dart';

class FeedPostDetail extends StatefulWidget {
  FeedPostDetail({Key? key, this.postId}) : super(key: key);
  final String? postId;

  _FeedPostDetailState createState() => _FeedPostDetailState();
}

class _FeedPostDetailState extends State<FeedPostDetail> {
  String? postId;
  @override
  void initState() {
    postId = widget.postId;
    // var state = Provider.of<FeedState>(context, listen: false);
    // state.getpostDetailFromDatabase(postId);
    super.initState();
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        var state = Provider.of<FeedState>(context, listen: false);
        state.setTweetToReply = state.tweetDetailModel?.last;
        Navigator.of(context).pushNamed('/ComposeTweetPage/' + postId!);
      },
      child: Icon(Icons.add),
    );
  }

  Widget _commentRow(FeedModel model) {
    return Tweet(
      model: model,
      type: TweetType.Reply,
      trailing:
          TweetBottomSheet().tweetOptionIcon(context, model, TweetType.Reply),
    );
  }

  Widget _tweetDetail(FeedModel? model) {
    return Tweet(
      model: model,
      type: TweetType.Detail,
      trailing:
          TweetBottomSheet().tweetOptionIcon(context, model, TweetType.Detail),
    );
  }

  void addLikeToComment(String commentId) {
    var state = Provider.of<FeedState>(context, listen: false);
    var authState = Provider.of<AuthState>(context, listen: false);
    state.addLikeToTweet(state.tweetDetailModel!.last!, authState.userId);
  }

  void openImage() async {
    Navigator.pushNamed(context, '/ImageViewPge');
  }

  void deleteTweet(TweetType type, String tweetId, {String? parentkey}) {
    var state = Provider.of<FeedState>(context, listen: false);
    state.deleteTweet(tweetId, type, parentkey: parentkey);
    Navigator.of(context).pop();
    if (type == TweetType.Detail) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<FeedState>(context, listen: false)
            .removeLastTweetDetail(postId);
        return Future.value(true);
      },
      child: Scaffold(
        floatingActionButton: _floatingActionButton(),
        backgroundColor: Theme.of(context).backgroundColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              title: customTitleText('Thread'),
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              backgroundColor: Theme.of(context).appBarTheme.color,
              bottom: PreferredSize(
                child: Container(
                  color: Colors.grey.shade200,
                  height: 1.0,
                ),
                preferredSize: Size.fromHeight(0.0),
              ),
            ),
            Consumer<FeedState>(
              builder: (context, state, child) {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      state.tweetDetailModel == null ||
                              state.tweetDetailModel!.length == 0
                          ? Container()
                          : _tweetDetail(state.tweetDetailModel?.last),
                      Container(
                        height: 6,
                        width: fullWidth(context),
                        color: TwitterColor.mystic,
                      )
                    ],
                  ),
                );
              },
            ),
            Consumer<FeedState>(builder: (context, state, child) {
              return SliverList(
                delegate: SliverChildListDelegate(
                  state.tweetReplyMap == null ||
                          state.tweetReplyMap.length == 0 ||
                          state.tweetReplyMap[postId] == null
                      ? [
                          Container(
                            child: Center(
                                //  child: Text('No comments'),
                                ),
                          )
                        ]
                      : state.tweetReplyMap[postId]!
                          .map((x) => _commentRow(x))
                          .toList(),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
