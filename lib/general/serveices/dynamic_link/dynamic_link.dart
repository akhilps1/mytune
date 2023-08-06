import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:mytune/general/app_details/app_details.dart';
import 'package:share_plus/share_plus.dart';

class DynamicLink {
  static FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  static Future<void> createLink({
    required String videoId,
    required String imageUrl,
    required String title,
  }) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link:
          Uri.parse("https://${AppDetails.domain}/product?productid=$videoId"),
      uriPrefix: "https://mytune.page.link",
      androidParameters: const AndroidParameters(
        packageName: AppDetails.packageName,
      ),
      iosParameters: const IOSParameters(
        bundleId: AppDetails.bundilId,
        appStoreId: AppDetails.appStoreId,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title,
        imageUrl: Uri.parse(imageUrl),
      ),
    );
    final dynamicLink = await dynamicLinks.buildShortLink(dynamicLinkParams);

    Share.share(dynamicLink.shortUrl.toString());
  }

  static Future<PendingDynamicLinkData?> getInitialLink() async {
    print('Dynamic link getInitialLink');
    final PendingDynamicLinkData? initialLink =
        await dynamicLinks.getInitialLink();

    return initialLink;
  }

  static Future<void> onListen(
      {required Function(PendingDynamicLinkData) onListon,
      Function? onError}) async {
    print('Dynamic link onListen');
    dynamicLinks.onLink.listen(onListon).onError(onError);
  }
}
