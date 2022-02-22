import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helper/enum.dart';
import '../../../model/feedModel.dart';
import '../../../state/feedState.dart';
import '../../customWidgets.dart';

class TweetImage extends StatelessWidget {
  const TweetImage(
      {Key? key, this.model, this.type, this.isRetweetImage = false})
      : super(key: key);

  final FeedModel? model;
  final TweetType? type;
  final bool isRetweetImage;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      alignment: Alignment.centerRight,
      child: model!.imagePath == null
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: InkWell(
                borderRadius: BorderRadius.all(
                  Radius.circular(isRetweetImage ? 0 : 20),
                ),
                onTap: () {
                  if (type == TweetType.ParentTweet) {
                    return;
                  }
                  var state = Provider.of<FeedState>(context, listen: false);
                  // state.getpostDetailFromDatabase(model.key, model: model);
                  state.setTweetToReply = model;
                  Navigator.pushNamed(context, '/ImageViewPge');
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(isRetweetImage ? 0 : 20),
                  ),
                  child: Container(
                    width: fullWidth(context) *
                            (type == TweetType.Detail ? .95 : .8) -
                        8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: customNetworkImage(model!.imagePath,
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
