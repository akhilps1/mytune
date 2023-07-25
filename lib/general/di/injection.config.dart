// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_messaging/firebase_messaging.dart' as _i5;
import 'package:firebase_storage/firebase_storage.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/authentication/provider/login_provider.dart' as _i9;
import '../../features/authentication/repository/firebase_login_serveices.dart'
    as _i8;
import 'firebase_injectable_module.dart' as _i6;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<_i3.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i4.FirebaseFirestore>(
      () => firebaseInjectableModule.firestore);
  gh.lazySingleton<_i5.FirebaseMessaging>(
      () => firebaseInjectableModule.firebaseMessaging);
  await gh.factoryAsync<_i6.FirebaseServeice>(
    () => firebaseInjectableModule.firebaseServeice,
    preResolve: true,
  );
  gh.lazySingleton<_i7.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseDtorage);
  gh.lazySingleton<_i8.FirebaseLoginServeices>(() => _i8.FirebaseLoginServeices(
        firebaseFirestore: gh<_i4.FirebaseFirestore>(),
        firebaseMessaging: gh<_i5.FirebaseMessaging>(),
        firebaseAuth: gh<_i3.FirebaseAuth>(),
      ));
  gh.factory<_i9.LoginProvider>(() => _i9.LoginProvider(
        firebaseLoginServeices: gh<_i8.FirebaseLoginServeices>(),
        firebaseAuth: gh<_i3.FirebaseAuth>(),
      ));
  return getIt;
}

class _$FirebaseInjectableModule extends _i6.FirebaseInjectableModule {}
