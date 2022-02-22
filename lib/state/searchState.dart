import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../helper/constant.dart';
import '../helper/enum.dart';
import '../helper/utility.dart';
import '../model/feedModel.dart';
import '../model/user.dart';
import 'appState.dart';

class SearchState extends AppState {
  bool isBusy = false;
  SortUser? sortBy = SortUser.ByMaxFollower;
  List<UserModel>? _userFilterlist;
  List<UserModel>? _userlist;
  List<FeedModel>? _tweetFilterList;
  List<FeedModel>? _tweetList;

  List<FeedModel>? get tweetList => _tweetFilterList;

  List<UserModel>? get userlist {
    if (_userFilterlist == null) {
      return null;
    } else {
      return List.from(_userFilterlist!);
    }
  }

  /// get [User list] from firebase realtime Database
  void getDataFromDatabase() async {
    try {
      isBusy = true;
      if (_userFilterlist == null) {
        _userFilterlist = <UserModel>[];
      } else {}
      if (_userlist == null) {
        _userlist = <UserModel>[];
      }
      _userFilterlist!.clear();
      _userlist!.clear();

      QuerySnapshot querySnapshot =
          await kfirestore.collection(USERS_COLLECTION).get();
      if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
        for (var i = 0; i < querySnapshot.docs.length; i++) {
          _userFilterlist!.add(UserModel.fromJson(
              querySnapshot.docs[i].data() as Map<dynamic, dynamic>?));
        }
        _userlist!.addAll(_userFilterlist!);
        _userFilterlist!.sort((x, y) => y.followers!.compareTo(x.followers!));
      } else {
        _userlist = null;
      }

      isBusy = false;

      // kDatabase.child('profile').once().then(
      //   (DataSnapshot snapshot) {
      //     _userlist = List<User>();
      //     _userFilterlist = List<User>();
      //     if (snapshot.value != null) {
      //       var map = snapshot.value;
      //       if (map != null) {
      //         map.forEach((key, value) {
      //           var model = User.fromJson(value);
      //           model.key = key;
      //           _userlist.add(model);
      //           _userFilterlist.add(model);
      //         });
      //
      //       }
      //     } else {
      //       _userlist = null;
      //     }
      //     isBusy = false;
      //   },
      // );
    } catch (error) {
      isBusy = false;
      cprint(error, errorIn: 'getDataFromDatabase');
    }
  }

  void getTweetsFromDatabase() async {
    try {
      isBusy = true;
      if (_tweetFilterList == null) {
        _tweetFilterList = <FeedModel>[];
      } else {}
      if (_tweetList == null) {
        _tweetList = <FeedModel>[];
      }
      _tweetFilterList!.clear();
      _tweetList!.clear();

      QuerySnapshot querySnapshot =
          await kfirestore.collection(TWEET_COLLECTION).get();
      if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
        for (var i = 0; i < querySnapshot.docs.length; i++) {
          _tweetFilterList!.add(FeedModel.fromJson(
              querySnapshot.docs[i].data() as Map<dynamic, dynamic>));
        }
        _tweetList!.addAll(_tweetFilterList!);
        _tweetFilterList!.sort((x, y) => y.likeCount.compareTo(x.likeCount));
      } else {
        _tweetList = null;
      }
      debugPrint("tweetlist called with $_tweetList");

      isBusy = false;

      // kDatabase.child('profile').once().then(
      //   (DataSnapshot snapshot) {
      //     _userlist = List<User>();
      //     _userFilterlist = List<User>();
      //     if (snapshot.value != null) {
      //       var map = snapshot.value;
      //       if (map != null) {
      //         map.forEach((key, value) {
      //           var model = User.fromJson(value);
      //           model.key = key;
      //           _userlist.add(model);
      //           _userFilterlist.add(model);
      //         });
      //
      //       }
      //     } else {
      //       _userlist = null;
      //     }
      //     isBusy = false;
      //   },
      // );
    } catch (error) {
      isBusy = false;
      cprint(error, errorIn: 'getTweetFromDatabase');
    }
  }

  /// It will reset filter list
  /// If user has use search filter and change screen and came back to search screen It will reset user list.
  /// This function call when search page open.
  void resetFilterList() {
    if (_userlist != null && _userlist!.length != _userFilterlist!.length) {
      _userFilterlist = List.from(_userlist!);
      _userFilterlist!.sort((x, y) => y.followers!.compareTo(x.followers!));
      notifyListeners();
    }
    if (_tweetList != null && _tweetList!.length != _tweetFilterList!.length) {
      _tweetFilterList = List.from(_tweetList!);
      _tweetFilterList!.sort((x, y) => y.likeCount.compareTo(x.likeCount));
      notifyListeners();
    }
  }

  /// This function call when search fiels text change.
  /// User list on  search field get filter by `name` string
  void filterByUsername(String name) {
    if (name.isEmpty &&
        _userlist != null &&
        _userlist!.length != _userFilterlist!.length) {
      _userFilterlist = List.from(_userlist!);
    }
    // return if userList is empty or null
    if (_userlist == null && _userlist!.isEmpty) {
      print("Empty userList");
      return;
    }
    // sortBy userlist on the basis of username
    else if (name != null) {
      _userFilterlist = _userlist!
          .where((x) =>
              x.userName != null &&
              x.userName!.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void filterByPost(String? post) {
    if (post != null) {
      if (post.isEmpty &&
          _tweetList != null &&
          _tweetList!.length != _tweetFilterList!.length) {
        _tweetFilterList = List.from(_tweetList!);
      }
      // return if userList is empty or null
      if (_tweetList == null && _tweetList!.isEmpty) {
        print("Empty userList");
        return;
      }

      _tweetFilterList = (_tweetList?.where((x) =>
                  x.description != null &&
                  x.description!.toLowerCase().contains(post.toLowerCase())) ??
              [])
          .toList();

      _tweetFilterList?.forEach((element) {
        debugPrint("filter by post called with ${element.toJson()}");
      });
    }
    notifyListeners();
  }

  /// Sort user list on search user page.
  set updateUserSortPrefrence(SortUser? val) {
    sortBy = val;
    notifyListeners();
  }

  String get selectedFilter {
    switch (sortBy) {
      case SortUser.ByAlphabetically:
        _userFilterlist!
            .sort((x, y) => x.displayName!.compareTo(y.displayName!));
        notifyListeners();
        return "alphabetically";

      case SortUser.ByMaxFollower:
        _userFilterlist!.sort((x, y) => y.followers!.compareTo(x.followers!));
        notifyListeners();
        return "User with max follower";

      case SortUser.ByNewest:
        _userFilterlist!.sort((x, y) => DateTime.parse(y.createdAt!)
            .compareTo(DateTime.parse(x.createdAt!)));
        notifyListeners();
        return "Newest user first";

      case SortUser.ByOldest:
        _userFilterlist!.sort((x, y) => DateTime.parse(x.createdAt!)
            .compareTo(DateTime.parse(y.createdAt!)));
        notifyListeners();
        return "Oldest user first";

      case SortUser.ByVerified:
        _userFilterlist!.sort((x, y) =>
            y.isVerified.toString().compareTo(x.isVerified.toString()));
        notifyListeners();
        return "Verified user first";

      default:
        return "Unknown";
    }
  }

  /// Return user list relative to provided `userIds`
  /// Method is used on
  List<UserModel> userList = [];
  List<UserModel> getuserDetail(List<String?>? userIds) {
    final list = _userlist!.where((x) {
      if (userIds!.contains(x.key)) {
        return true;
      } else {
        return false;
      }
    }).toList();
    return list;
  }
}
