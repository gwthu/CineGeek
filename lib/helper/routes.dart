import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/customRoute.dart';
import '../page/Auth/forgetPasswordPage.dart';
import '../page/Auth/selectAuthMethod.dart';
import '../page/Auth/signin.dart';
import '../page/Auth/signup.dart';
import '../page/Auth/verifyEmail.dart';
import '../page/common/splash.dart';
import '../page/feed/composeTweet/composeTweet.dart';
import '../page/feed/composeTweet/state/composeTweetState.dart';
import '../page/feed/feedPostDetail.dart';
import '../page/feed/imageViewPage.dart';
import '../page/message/chatScreenPage.dart';
import '../page/message/conversationInformation/conversationInformation.dart';
import '../page/message/newMessagePage.dart';
import '../page/profile/EditProfilePage.dart';
import '../page/profile/follow/followerListPage.dart';
import '../page/profile/follow/followingListPage.dart';
import '../page/profile/profileImageView.dart';
import '../page/profile/profilePage.dart';
import '../page/search/SearchPage.dart';
import '../page/settings/accountSettings/about/aboutTwitter.dart';
import '../page/settings/accountSettings/accessibility/accessibility.dart';
import '../page/settings/accountSettings/accountSettingsPage.dart';
import '../page/settings/accountSettings/contentPrefrences/contentPreference.dart';
import '../page/settings/accountSettings/contentPrefrences/trends/trendsPage.dart';
import '../page/settings/accountSettings/dataUsage/dataUsagePage.dart';
import '../page/settings/accountSettings/displaySettings/displayAndSoundPage.dart';
import '../page/settings/accountSettings/notifications/notificationPage.dart';
import '../page/settings/accountSettings/privacyAndSafety/directMessage/directMessage.dart';
import '../page/settings/accountSettings/privacyAndSafety/privacyAndSafetyPage.dart';
import '../page/settings/accountSettings/proxy/proxyPage.dart';
import '../page/settings/settingsAndPrivacyPage.dart';
import '../state/chats/chatState.dart';
import '../widgets/customWidgets.dart';

class Routes {
  static dynamic route() {
    return {
      '/': (BuildContext context) => SplashPage(),
    };
  }

  static void sendNavigationEventToFirebase(String? path) {
    if (path != null && path.isNotEmpty) {
      // analytics.setCurrentScreen(screenName: path);
    }
  }

  static Route? onGenerateRoute(RouteSettings settings) {
    final List<String> pathElements = settings.name!.split('/');
    if (pathElements[0] != '' || pathElements.length == 1) {
      return null;
    }
    switch (pathElements[1]) {
      case "ComposeTweetPage":
        bool isRetweet = false;
        bool isTweet = false;
        if (pathElements.length == 3 && pathElements[2].contains('retweet')) {
          isRetweet = true;
        } else if (pathElements.length == 3 &&
            pathElements[2].contains('tweet')) {
          isTweet = true;
        }
        return CustomRoute<bool>(
            builder: (BuildContext context) =>
                ChangeNotifierProvider<ComposeTweetState>(
                  create: (_) => ComposeTweetState(),
                  child:
                      ComposeTweetPage(isRetweet: isRetweet, isTweet: isTweet),
                ));
      case "FeedPostDetail":
        var postId = pathElements[2];
        return SlideLeftRoute<bool>(
            builder: (BuildContext context) => FeedPostDetail(
                  postId: postId,
                ),
            settings: const RouteSettings(name: 'FeedPostDetail'));
      case "ProfilePage":
        String? profileId;
        if (pathElements.length > 2) {
          profileId = pathElements[2];
        }
        return CustomRoute<bool>(
            builder: (BuildContext context) => ProfilePage(
                  profileId: profileId,
                ));
      case "CreateFeedPage":
        return CustomRoute<bool>(
            builder: (BuildContext context) =>
                ChangeNotifierProvider<ComposeTweetState>(
                  create: (_) => ComposeTweetState(),
                  child: ComposeTweetPage(isRetweet: false, isTweet: true),
                ));
      case "ChatScreenPage":
        return CustomRoute<bool>(
            builder: (BuildContext context) =>
                ChangeNotifierProvider<ChatState>(
                  create: (_) => ChatState(),
                  child: ChatScreenPage(),
                ));
      case "WelcomePage":
        return CustomRoute<bool>(
            builder: (BuildContext context) => WelcomePage());
      case "SignIn":
        return CustomRoute<bool>(
            builder: (BuildContext context) => const SignIn());
      case "SignUp":
        return CustomRoute<bool>(
            builder: (BuildContext context) => const Signup());
      case "ForgetPasswordPage":
        return CustomRoute<bool>(
            builder: (BuildContext context) => const ForgetPasswordPage());
      case "SearchPage":
        return CustomRoute<bool>(
            builder: (BuildContext context) => const SearchPage());
      case "ImageViewPge":
        return CustomRoute<bool>(
            builder: (BuildContext context) => ImageViewPge());
      case "EditProfile":
        return CustomRoute<bool>(
            builder: (BuildContext context) => EditProfilePage());
      case "ProfileImageView":
        return SlideLeftRoute<bool>(
            builder: (BuildContext context) => const ProfileImageView());
      case "NewMessagePage":
        return CustomRoute<bool>(
          builder: (BuildContext context) => const NewMessagePage(),
        );
      case "SettingsAndPrivacyPage":
        return CustomRoute<bool>(
          builder: (BuildContext context) => const SettingsAndPrivacyPage(),
        );
      case "AccountSettingsPage":
        return CustomRoute<bool>(
          builder: (BuildContext context) => const AccountSettingsPage(),
        );
      case "PrivacyAndSaftyPage":
        return CustomRoute<bool>(
          builder: (BuildContext context) => const PrivacyAndSaftyPage(),
        );
      case "NotificationPage":
        return CustomRoute<bool>(
          builder: (BuildContext context) => const NotificationPage(),
        );
      case "ContentPrefrencePage":
        return CustomRoute<bool>(
          builder: (BuildContext context) => const ContentPrefrencePage(),
        );
      case "DisplayAndSoundPage":
        return CustomRoute<bool>(
          builder: (BuildContext context) => const DisplayAndSoundPage(),
        );
      case "DirectMessagesPage":
        return CustomRoute<bool>(
          builder: (BuildContext context) => const DirectMessagesPage(),
        );
      case "TrendsPage":
        return CustomRoute<bool>(
          builder: (BuildContext context) => TrendsPage(),
        );
      case "DataUsagePage":
        return CustomRoute<bool>(
          builder: (BuildContext context) => const DataUsagePage(),
        );
      case "AccessibilityPage":
        return CustomRoute<bool>(
          builder: (BuildContext context) => const AccessibilityPage(),
        );
      case "ProxyPage":
        return CustomRoute<bool>(
          builder: (BuildContext context) => const ProxyPage(),
        );
      case "AboutPage":
        return CustomRoute<bool>(
          builder: (BuildContext context) => const AboutPage(),
        );
      case "ConversationInformation":
        return CustomRoute<bool>(
          builder: (BuildContext context) => const ConversationInformation(),
        );
      case "FollowingListPage":
        return CustomRoute<bool>(
          builder: (BuildContext context) => FollowingListPage(),
        );
      case "FollowerListPage":
        return CustomRoute<bool>(
          builder: (BuildContext context) => FollowerListPage(),
        );
      case "VerifyEmailPage":
        return CustomRoute<bool>(
          builder: (BuildContext context) => const VerifyEmailPage(),
        );
      default:
        return onUnknownRoute(const RouteSettings(name: '/Feature'));
    }
  }

  static Route onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: customTitleText(settings.name!.split('/')[1]),
          centerTitle: true,
        ),
        body: Center(
          child: Text('${settings.name!.split('/')[1]} Comming soon..'),
        ),
      ),
    );
  }
}
