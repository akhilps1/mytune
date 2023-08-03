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
    as _i18;
import '../../features/authentication/provider/login_provider.dart' as _i26;
import '../../features/authentication/repository/firebase_login_serveices.dart'
    as _i24;
import '../../features/home/provider/home_screen_provider.dart' as _i25;
import '../../features/home/repository/all_products_repository.dart' as _i17;
import '../../features/home/repository/banner_reopsitory.dart' as _i19;
import '../../features/home/repository/category_repository.dart' as _i20;
import '../../features/home/repository/today_release_repository.dart' as _i13;
import '../../features/home/repository/top_3_repository.dart' as _i14;
import '../../features/product_details/provider/product_details_rovider.dart'
    as _i9;
import '../../features/product_details/repository/craft_details_repo.dart'
    as _i22;
import '../../features/product_details/repository/crew_detail_repo.dart'
    as _i23;
import '../../features/product_details/repository/product_details_repo.dart'
    as _i10;
import '../../features/search/provider/saerch_provider.dart' as _i12;
import '../../features/search/repository/category_search_repo.dart' as _i21;
import '../../features/search/repository/product_search_repo.dart' as _i11;
import '../../features/user_details/provider/user_details_provider.dart'
    as _i15;
import '../../features/user_details/repository/user_details_repo.dart' as _i16;
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
  gh.lazySingleton<_i11.ProductSearchRepo>(() =>
      _i11.ProductSearchRepo(firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.factory<_i12.SearchProvider>(() => _i12.SearchProvider());
  gh.lazySingleton<_i13.TodayReleaseRepository>(() =>
      _i13.TodayReleaseRepository(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i14.TopThreeReleaseRepo>(() =>
      _i14.TopThreeReleaseRepo(firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.factory<_i15.UserDetailsProvider>(() => _i15.UserDetailsProvider());
  gh.lazySingleton<_i16.UserDetailsRepo>(() => _i16.UserDetailsRepo(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i8.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i17.AllProductsRepo>(() =>
      _i17.AllProductsRepo(firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i18.ArtistDetailsRepo>(() =>
      _i18.ArtistDetailsRepo(firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i19.BannerRepository>(() =>
      _i19.BannerRepository(firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i20.CategoryRepository>(() => _i20.CategoryRepository(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseAuth: gh<_i4.FirebaseAuth>(),
      ));
  gh.lazySingleton<_i21.CategorySearchRepo>(() =>
      _i21.CategorySearchRepo(firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i22.CraftDetailRepo>(() =>
      _i22.CraftDetailRepo(firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i23.CrewDetailRepo>(() =>
      _i23.CrewDetailRepo(firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i24.FirebaseLoginServeices>(
      () => _i24.FirebaseLoginServeices(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseMessaging: gh<_i6.FirebaseMessaging>(),
            firebaseAuth: gh<_i4.FirebaseAuth>(),
          ));
  gh.factory<_i25.HomeScreenProvider>(() => _i25.HomeScreenProvider(
        bannerRepository: gh<_i19.BannerRepository>(),
        categoryRepository: gh<_i20.CategoryRepository>(),
        todayReleaseRepository: gh<_i13.TodayReleaseRepository>(),
      ));
  gh.factory<_i26.LoginProvider>(() => _i26.LoginProvider(
        firebaseLoginServeices: gh<_i24.FirebaseLoginServeices>(),
        firebaseAuth: gh<_i4.FirebaseAuth>(),
      ));
  return getIt;
}

class _$FirebaseInjectableModule extends _i7.FirebaseInjectableModule {}
