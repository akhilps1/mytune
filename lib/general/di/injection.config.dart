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

import '../../features/authentication/provider/login_provider.dart' as _i15;
import '../../features/authentication/repository/firebase_login_serveices.dart'
    as _i13;
import '../../features/home/provider/home_screen_provider.dart' as _i14;
import '../../features/home/repository/all_products_repository.dart' as _i10;
import '../../features/home/repository/banner_reopsitory.dart' as _i11;
import '../../features/home/repository/category_repository.dart' as _i12;
import '../../features/home/repository/today_release_repository.dart' as _i8;
import '../../features/home/repository/top_3_repository.dart' as _i9;
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
  gh.lazySingleton<_i8.TodayReleaseRepository>(() => _i8.TodayReleaseRepository(
      firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i9.TopThreeReleaseRepo>(() =>
      _i9.TopThreeReleaseRepo(firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i10.AllProductsRepo>(() =>
      _i10.AllProductsRepo(firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i11.BannerRepository>(() =>
      _i11.BannerRepository(firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i12.CategoryRepository>(() => _i12.CategoryRepository(
        firebaseFirestore: gh<_i4.FirebaseFirestore>(),
        firebaseAuth: gh<_i3.FirebaseAuth>(),
      ));
  gh.lazySingleton<_i13.FirebaseLoginServeices>(
      () => _i13.FirebaseLoginServeices(
            firebaseFirestore: gh<_i4.FirebaseFirestore>(),
            firebaseMessaging: gh<_i5.FirebaseMessaging>(),
            firebaseAuth: gh<_i3.FirebaseAuth>(),
          ));
  gh.factory<_i14.HomeScreenProvider>(() => _i14.HomeScreenProvider(
        bannerRepository: gh<_i11.BannerRepository>(),
        categoryRepository: gh<_i12.CategoryRepository>(),
        todayReleaseRepository: gh<_i8.TodayReleaseRepository>(),
      ));
  gh.factory<_i15.LoginProvider>(() => _i15.LoginProvider(
        firebaseLoginServeices: gh<_i13.FirebaseLoginServeices>(),
        firebaseAuth: gh<_i3.FirebaseAuth>(),
      ));
  return getIt;
}

class _$FirebaseInjectableModule extends _i6.FirebaseInjectableModule {}
