import 'user.dart';

class FeedModel {
  String? key;
  String? parentkey;
  String? childRetwetkey;
  String? description;
  String? userId;
  int likeCount = 0;
  List<String?>? likeList;
  int? commentCount;
  int retweetCount = 0;
  String? createdAt;
  String? imagePath;
  List<String?>? tags;
  List<String?>? replyTweetKeyList;
  UserModel? user;
  FeedModel(
      {this.key,
      this.description,
      this.userId,
      this.likeCount = 0,
      this.commentCount,
      this.retweetCount = 0,
      this.createdAt,
      this.imagePath,
      this.likeList,
      this.tags,
      this.user,
      this.replyTweetKeyList,
      this.parentkey,
      this.childRetwetkey});
  toJson() {
    return {
      "userId": userId,
      "description": description,
      "likeCount": likeCount,
      "commentCount": commentCount ?? 0,
      "retweetCount": retweetCount,
      "createdAt": createdAt,
      "imagePath": imagePath,
      "likeList": likeList,
      "tags": tags,
      "replyTweetKeyList": replyTweetKeyList,
      "user": user == null ? null : user!.toJson(),
      "parentkey": parentkey,
      "childRetwetkey": childRetwetkey
    };
  }

  FeedModel.fromJson(Map<dynamic, dynamic> map) {
    key = map['key'];
    description = map['description'];
    userId = map['userId'];
    //  name = map['name'];
    //  profilePic = map['profilePic'];
    likeCount = map['likeCount'];
    commentCount = map['commentCount'];
    retweetCount = map["retweetCount"] ?? 0;
    imagePath = map['imagePath'];
    createdAt = map['createdAt'];
    imagePath = map['imagePath'];
    //  username = map['username'];
    user = UserModel.fromJson(map['user']);
    parentkey = map['parentkey'];
    childRetwetkey = map['childRetwetkey'];
    if (map['tags'] != null) {
      tags = <String>[];
      map['tags'].forEach((value) {
        tags!.add(value);
      });
    }
    if (map["likeList"] != null) {
      likeList = <String?>[];
      final list = map['likeList'];
      if (list is List) {
        map['likeList'].forEach((value) {
          likeList!.add(value);
        });
        likeCount = likeList!.length;
      }
    } else {
      likeList = [];
      likeCount = 0;
    }
    if (map['replyTweetKeyList'] != null &&
        map['replyTweetKeyList'].length > 0) {
      map['replyTweetKeyList'].forEach((value) {
        replyTweetKeyList = <String?>[];
        map['replyTweetKeyList'].forEach((value) {
          replyTweetKeyList!.add(value);
        });
      });
      commentCount = replyTweetKeyList!.length;
    } else {
      replyTweetKeyList = [];
      commentCount = 0;
    }
  }

  bool get isValidTweet {
    bool isValid = false;
    if (description != null &&
        description!.isNotEmpty &&
        user != null &&
        user!.userName != null &&
        user!.userName!.isNotEmpty) {
      isValid = true;
    } else {
      print("Invalid Tweet found. Id:- $key");
    }
    return isValid;
  }
}
