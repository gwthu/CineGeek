import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helper/constant.dart';
import '../../../helper/customRoute.dart';
import '../../../helper/enum.dart';
import '../../../helper/theme.dart';
import '../../../helper/utility.dart';
import '../../../model/feedModel.dart';
import '../../../page/common/usersListPage.dart';
import '../../../state/authState.dart';
import '../../../state/feedState.dart';
import '../../customWidgets.dart';
import 'tweetBottomSheet.dart';

class TweetIconsRow extends StatelessWidget {
  final FeedModel? model;
  final Color? iconColor;
  final Color? iconEnableColor;
  final double? size;
  final bool isTweetDetail;
  final TweetType? type;
  const TweetIconsRow(
      {Key? key,
      this.model,
      this.iconColor,
      this.iconEnableColor,
      this.size,
      this.isTweetDetail = false,
      this.type})
      : super(key: key);

  Widget _likeCommentsIcons(BuildContext context, FeedModel model) {
    var authState = Provider.of<AuthState>(context, listen: false);
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(bottom: 0, top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          _iconWidget(
            context,
            text: isTweetDetail ? '' : model.commentCount.toString(),
            icon: AppIcon.reply,
            iconColor: iconColor,
            size: size ?? 20,
            onPressed: () {
              var state = Provider.of<FeedState>(context, listen: false);
              state.setTweetToReply = model;
              Navigator.of(context).pushNamed('/ComposeTweetPage');
            },
          ),
          _iconWidget(context,
              text: isTweetDetail ? '' : model.retweetCount.toString(),
              icon: AppIcon.retweet,
              iconColor: iconColor,
              size: size ?? 20, onPressed: () {
            TweetBottomSheet().openRetweetbottomSheet(context, type, model);
          }),
          _iconWidget(
            context,
            text: isTweetDetail ? '' : model.likeCount.toString(),
            icon: model.likeList!.any((userId) => userId == authState.userId)
                ? AppIcon.heartFill
                : AppIcon.heartEmpty,
            onPressed: () {
              addLikeToTweet(context);
            },
            iconColor:
                model.likeList!.any((userId) => userId == authState.userId)
                    ? iconEnableColor
                    : iconColor,
            size: size ?? 20,
          ),
          _iconWidget(context, text: '', icon: null, sysIcon: Icons.share,
              onPressed: () {
            share('${model.description}',
                subject: '${model.user!.displayName}\'s post');
          }, iconColor: iconColor, size: size ?? 20),
        ],
      ),
    );
  }

  Widget _iconWidget(BuildContext context,
      {String? text,
      int? icon,
      Function? onPressed,
      IconData? sysIcon,
      Color? iconColor,
      double size = 20}) {
    return Expanded(
      child: Container(
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                if (onPressed != null) onPressed();
              },
              icon: sysIcon != null
                  ? Icon(sysIcon, color: iconColor, size: size)
                  : customIcon(
                      context,
                      size: size,
                      icon: icon!,
                      istwitterIcon: true,
                      iconColor: iconColor,
                    ),
            ),
            customText(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: iconColor,
                fontSize: size - 5,
              ),
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            const SizedBox(width: 5),
            customText(getPostTime2(model!.createdAt), style: textStyle14),
            const SizedBox(width: 10),
            customText('Fwitter for Android',
                style: TextStyle(color: Theme.of(context).primaryColor))
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _likeCommentWidget(BuildContext context) {
    bool isLikeAvailable = model!.likeCount > 0;
    bool isRetweetAvailable = model!.retweetCount > 0;
    bool isLikeRetweetAvailable = isRetweetAvailable || isLikeAvailable;
    return Column(
      children: <Widget>[
        const Divider(
          endIndent: 10,
          height: 0,
        ),
        AnimatedContainer(
          padding:
              EdgeInsets.symmetric(vertical: isLikeRetweetAvailable ? 12 : 0),
          duration: const Duration(milliseconds: 500),
          child: !isLikeRetweetAvailable
              ? const SizedBox.shrink()
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    !isRetweetAvailable
                        ? const SizedBox.shrink()
                        : customText(model!.retweetCount.toString(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                    !isRetweetAvailable
                        ? const SizedBox.shrink()
                        : const SizedBox(width: 5),
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: customText('Retweets', style: subtitleStyle),
                      crossFadeState: !isRetweetAvailable
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 800),
                    ),
                    !isRetweetAvailable
                        ? const SizedBox.shrink()
                        : const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        onLikeTextPressed(context);
                      },
                      child: AnimatedCrossFade(
                        firstChild: const SizedBox.shrink(),
                        secondChild: Row(
                          children: <Widget>[
                            customSwitcherWidget(
                              duraton: const Duration(milliseconds: 300),
                              child: customText(model!.likeCount.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  key: ValueKey(model!.likeCount)),
                            ),
                            const SizedBox(width: 5),
                            customText('Likes', style: subtitleStyle)
                          ],
                        ),
                        crossFadeState: !isLikeAvailable
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 300),
                      ),
                    )
                  ],
                ),
        ),
        !isLikeRetweetAvailable
            ? const SizedBox.shrink()
            : const Divider(
                endIndent: 10,
                height: 0,
              ),
      ],
    );
  }

  void addLikeToTweet(BuildContext context) {
    var state = Provider.of<FeedState>(context, listen: false);
    var authState = Provider.of<AuthState>(context, listen: false);
    state.addLikeToTweet(model!, authState.userId);
  }

  void onLikeTextPressed(BuildContext context) {
    Navigator.of(context).push(
      CustomRoute<bool>(
        builder: (BuildContext context) => UsersListPage(
          pageTitle: "Liked by",
          userIdsList: model!.likeList!.map((userId) => userId).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        isTweetDetail ? _timeWidget(context) : const SizedBox(),
        isTweetDetail ? _likeCommentWidget(context) : const SizedBox(),
        _likeCommentsIcons(context, model!)
      ],
    ));
  }
}
