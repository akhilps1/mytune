import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/general/local_db/local_db.dart';

@injectable
class LocalDbDataProvider with ChangeNotifier {
  List likedVideos = [];
  List followedArtist = [];

  final LocalDb _localDb = LocalDb<String>();

  void getLikedVideos() async {
    likedVideos = await _localDb.get(localDbName: 'likedvideos-db');
    notifyListeners();
  }

  void addeLikedVideos({required String id}) async {
    await _localDb.insert(id, localDbName: 'likedvideos-db');
    likedVideos.add(id);
    notifyListeners();
  }

  void deleteLikedVideos({required String id}) async {
    await _localDb.onDelete(id, localDbName: 'likedvideos-db');
    dynamic video = likedVideos.firstWhere((element) => element == id);
    likedVideos.remove(video);
    notifyListeners();
  }

  void getFollowedArtist() async {
    followedArtist = await _localDb.get(localDbName: 'followedArtist-db');
  }

  void addFollowedArtist({required String id}) async {
    await _localDb.insert(id, localDbName: 'followedArtist-db');
    followedArtist.add(id);
    notifyListeners();
  }

  void deleteFollowedArtist({required String id}) async {
    await _localDb.onDelete(id, localDbName: 'followedArtist-db');
    dynamic video = followedArtist.firstWhere((element) => element == id);
    followedArtist.remove(video);
    notifyListeners();
  }

  void deleteAllData() async {
    await _localDb.clearAll(localDbName: 'followedArtist-db');
    await _localDb.clearAll(localDbName: 'likedvideos-db');
    likedVideos.clear();
    followedArtist.clear();

    notifyListeners();
  }
}
