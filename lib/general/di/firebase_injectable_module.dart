import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseInjectableModule {
  @preResolve
  Future<FirebaseServeice> get firebaseServeice => FirebaseServeice.init();

  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @lazySingleton
  FirebaseStorage get firebaseDtorage => FirebaseStorage.instance;

  @lazySingleton
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;
}

class FirebaseServeice {
  static Future<FirebaseServeice> init() async {
    await Firebase.initializeApp();
    return FirebaseServeice();
  }
}
