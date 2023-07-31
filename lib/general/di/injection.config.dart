// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:firebase_messaging/firebase_messaging.dart' as _i6;
import 'package:firebase_storage/firebase_storage.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/artist_details/provider/artist_details_provider.dart'
    as _i3;
import '../../features/artist_details/repository/artist_details_repo.dart'
    as _i14;
import '../../features/authentication/provider/login_provider.dart' as _i21;
import '../../features/authentication/repository/firebase_login_serveices.dart'
    as _i19;
import '../../features/home/provider/home_screen_provider.dart' as _i20;
import '../../features/home/repository/all_products_repository.dart' as _i13;
import '../../features/home/repository/banner_reopsitory.dart' as _i15;
import '../../features/home/repository/category_repository.dart' as _i16;
import '../../features/home/repository/today_release_repository.dart' as _i11;
import '../../features/home/repository/top_3_repository.dart' as _i12;
import '../../features/product_details/provider/product_details_rovider.dart'
    as _i9;
import '../../features/product_details/repository/craft_details_repo.dart'
    as _i17;
import '../../features/product_details/repository/crew_detail_repo.dart'
    as _i18;
import '../../features/product_details/repository/product_details_repo.dart'
    as _i10;
import 'firebase_injectable_module.dart' as _i7;

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
  gh.factory<_i3.ArtistDetailsProvider>(() => _i3.ArtistDetailsProvider());
  gh.lazySingleton<_i4.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i5.FirebaseFirestore>(
      () => firebaseInjectableModule.firestore);
  gh.lazySingleton<_i6.FirebaseMessaging>(
      () => firebaseInjectableModule.firebaseMessaging);
  await gh.factoryAsync<_i7.FirebaseServeice>(
    () => firebaseInjectableModule.firebaseServeice,
    preResolve: true,
  );
  gh.lazySingleton<_i8.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseDtorage);
  gh.factory<_i9.ProductDetailsProvider>(() => _i9.ProductDetailsProvider());
  gh.lazySingleton<_i10.ProductDetailsRepo>(() =>
      _i10.ProductDetailsRepo(firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i11.TodayReleaseRepository>(() =>
      _i11.TodayReleaseRepository(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i12.TopThreeReleaseRepo>(() =>
      _i12.TopThreeReleaseRepo(firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i13.AllProductsRepo>(() =>
      _i13.AllProductsRepo(firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i14.ArtistDetailsRepo>(() =>
      _i14.ArtistDetailsRepo(firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i15.BannerRepository>(() =>
      _i15.BannerRepository(firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i16.CategoryRepository>(() => _i16.CategoryRepository(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseAuth: gh<_i4.FirebaseAuth>(),
      ));
  gh.lazySingleton<_i17.CraftDetailRepo>(() =>
      _i17.CraftDetailRepo(firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i18.CrewDetailRepo>(() =>
      _i18.CrewDetailRepo(firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i19.FirebaseLoginServeices>(
      () => _i19.FirebaseLoginServeices(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseMessaging: gh<_i6.FirebaseMessaging>(),
            firebaseAuth: gh<_i4.FirebaseAuth>(),
          ));
  gh.factory<_i20.HomeScreenProvider>(() => _i20.HomeScreenProvider(
        bannerRepository: gh<_i15.BannerRepository>(),
        categoryRepository: gh<_i16.CategoryRepository>(),
        todayReleaseRepository: gh<_i11.TodayReleaseRepository>(),
      ));
  gh.factory<_i21.LoginProvider>(() => _i21.LoginProvider(
        firebaseLoginServeices: gh<_i19.FirebaseLoginServeices>(),
        firebaseAuth: gh<_i4.FirebaseAuth>(),
      ));
  return getIt;
}

class _$FirebaseInjectableModule extends _i7.FirebaseInjectableModule {}
