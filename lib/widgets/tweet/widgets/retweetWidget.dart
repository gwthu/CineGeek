import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helper/constant.dart';
import '../../../helper/enum.dart';
import '../../../helper/theme.dart';
import '../../../helper/utility.dart';
import '../../../model/feedModel.dart';
import '../../../state/feedState.dart';
import '../../customWidgets.dart';
import '../../newWidget/customUrlText.dart';
import '../../newWidget/rippleButton.dart';
import '../../newWidget/title_text.dart';
import 'tweetImage.dart';
import 'unavailableTweet.dart';

class RetweetWidget extends StatelessWidget {
  const RetweetWidget(
      {Key? key, this.childRetwetkey, this.type, this.isImageAvailable = false})
      : super(key: key);

  final String? childRetwetkey;
  final bool isImageAvailable;
  final TweetType? type;

  Widget _tweet(BuildContext context, FeedModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          width: fullWidth(context) - 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                width: 25,
                height: 25,
                child: customImage(context, model.user!.profilePic),
              ),
              const SizedBox(width: 10),
              ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: 0, maxWidth: fullWidth(context) * .5),
                child: TitleText(
                  model.user!.displayName,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 3),
              model.user!.isVerified!
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
                width: model.user!.isVerified! ? 5 : 0,
              ),
              Flexible(
                child: customText(
                  '${model.user!.userName}',
                  style: userNameStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              customText('?? ${getChatTime(model.createdAt)}',
                  style: userNameStyle),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: UrlText(
            text: model.description,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            urlStyle: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: model.imagePath == null ? 8 : 0),
        TweetImage(model: model, type: type, isRetweetImage: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var feedstate = Provider.of<FeedState>(context, listen: false);
    return FutureBuilder(
      future: feedstate.fetchTweet(childRetwetkey),
      builder: (context, AsyncSnapshot<FeedModel?> snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: EdgeInsets.only(
                left: type == TweetType.Tweet || type == TweetType.ParentTweet
                    ? 70
                    : 12,
                right: 16,
                top: isImageAvailable ? 8 : 5),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.extraLightGrey, width: .5),
              borderRadius: const BorderRadius.all(const Radius.circular(15)),
            ),
            child: RippleButton(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              onPressed: () {
                feedstate.getpostDetailFromDatabase(null, model: snapshot.data);
                Navigator.of(context)
                    .pushNamed('/FeedPostDetail/' + snapshot.data!.key!);
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(const Radius.circular(15)),
                child: _tweet(context, snapshot.data!),
              ),
            ),
          );
        }
        if ((snapshot.connectionState == ConnectionState.done ||
                snapshot.connectionState == ConnectionState.waiting) &&
            !snapshot.hasData) {
          return UnavailableTweet(
            snapshot: snapshot,
            type: type,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
