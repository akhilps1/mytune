// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:firebase_messaging/firebase_messaging.dart' as _i7;
import 'package:firebase_storage/firebase_storage.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/artist_details/provider/artist_details_provider.dart'
    as _i3;
import '../../features/artist_details/repository/artist_details_repo.dart'
    as _i24;
import '../../features/artists/provider/artists_screen_provider.dart' as _i4;
import '../../features/artists/repository/category_repository.dart' as _i27;
import '../../features/authentication/provider/login_provider.dart' as _i12;
import '../../features/authentication/repository/firebase_login_serveices.dart'
    as _i32;
import '../../features/home/provider/home_screen_provider.dart' as _i10;
import '../../features/home/provider/local_db_data_provider.dart' as _i11;
import '../../features/home/repository/all_products_repository.dart' as _i23;
import '../../features/home/repository/artists_repo.dart' as _i25;
import '../../features/home/repository/banner_reopsitory.dart' as _i26;
import '../../features/home/repository/dynamic_link_repo.dart' as _i31;
import '../../features/home/repository/today_release_repository.dart' as _i17;
import '../../features/home/repository/top_3_repository.dart' as _i18;
import '../../features/product_details/provider/product_details_provider.dart'
    as _i13;
import '../../features/product_details/repository/craft_details_repo.dart'
    as _i29;
import '../../features/product_details/repository/crew_detail_repo.dart'
    as _i30;
import '../../features/product_details/repository/product_details_repo.dart'
    as _i14;
import '../../features/search/provider/saerch_provider.dart' as _i16;
import '../../features/search/repository/category_search_repo.dart' as _i28;
import '../../features/search/repository/product_search_repo.dart' as _i15;
import '../../features/trending/provider/trending_page_provider.dart' as _i19;
import '../../features/trending/repository/trending_repo.dart' as _i20;
import '../../features/user_details/provider/user_details_provider.dart'
    as _i21;
import '../../features/user_details/repository/user_details_repo.dart' as _i22;
import 'firebase_injectable_module.dart' as _i8;

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
  gh.factory<_i4.ArtistScreenProvider>(() => _i4.ArtistScreenProvider());
  gh.lazySingleton<_i5.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i6.FirebaseFirestore>(
      () => firebaseInjectableModule.firestore);
  gh.lazySingleton<_i7.FirebaseMessaging>(
      () => firebaseInjectableModule.firebaseMessaging);
  await gh.factoryAsync<_i8.FirebaseServeice>(
    () => firebaseInjectableModule.firebaseServeice,
    preResolve: true,
  );
  gh.lazySingleton<_i9.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseDtorage);
  gh.factory<_i10.HomeScreenProvider>(() => _i10.HomeScreenProvider());
  gh.factory<_i11.LocalDbDataProvider>(() => _i11.LocalDbDataProvider());
  gh.factory<_i12.LoginProvider>(() => _i12.LoginProvider());
  gh.factory<_i13.ProductDetailsProvider>(() => _i13.ProductDetailsProvider());
  gh.lazySingleton<_i14.ProductDetailsRepo>(() => _i14.ProductDetailsRepo(
        firebaseFirestore: gh<_i6.FirebaseFirestore>(),
        firebaseAuth: gh<_i5.FirebaseAuth>(),
      ));
  gh.lazySingleton<_i15.ProductSearchRepo>(() =>
      _i15.ProductSearchRepo(firebaseFirestore: gh<_i6.FirebaseFirestore>()));
  gh.factory<_i16.SearchProvider>(() => _i16.SearchProvider());
  gh.lazySingleton<_i17.TodayReleaseRepository>(() =>
      _i17.TodayReleaseRepository(
          firebaseFirestore: gh<_i6.FirebaseFirestore>()));
  gh.lazySingleton<_i18.TopThreeReleaseRepo>(() =>
      _i18.TopThreeReleaseRepo(firebaseFirestore: gh<_i6.FirebaseFirestore>()));
  gh.factory<_i19.TrendingPageProvider>(() => _i19.TrendingPageProvider());
  gh.lazySingleton<_i20.TrendingPageRepo>(() =>
      _i20.TrendingPageRepo(firebaseFirestore: gh<_i6.FirebaseFirestore>()));
  gh.factory<_i21.UserDetailsProvider>(() => _i21.UserDetailsProvider());
  gh.lazySingleton<_i22.UserDetailsRepo>(() => _i22.UserDetailsRepo(
        firebaseFirestore: gh<_i6.FirebaseFirestore>(),
        firebaseStorage: gh<_i9.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i23.AllProductsRepo>(() =>
      _i23.AllProductsRepo(firebaseFirestore: gh<_i6.FirebaseFirestore>()));
  gh.lazySingleton<_i24.ArtistDetailsRepo>(() => _i24.ArtistDetailsRepo(
        firebaseFirestore: gh<_i6.FirebaseFirestore>(),
        firebaseAuth: gh<_i5.FirebaseAuth>(),
      ));
  gh.lazySingleton<_i25.ArtistRepo>(
      () => _i25.ArtistRepo(firebaseFirestore: gh<_i6.FirebaseFirestore>()));
  gh.lazySingleton<_i26.BannerRepository>(() =>
      _i26.BannerRepository(firebaseFirestore: gh<_i6.FirebaseFirestore>()));
  gh.lazySingleton<_i27.CategoryRepository>(() => _i27.CategoryRepository(
        firebaseFirestore: gh<_i6.FirebaseFirestore>(),
        firebaseAuth: gh<_i5.FirebaseAuth>(),
      ));
  gh.lazySingleton<_i28.CategorySearchRepo>(() =>
      _i28.CategorySearchRepo(firebaseFirestore: gh<_i6.FirebaseFirestore>()));
  gh.lazySingleton<_i29.CraftDetailRepo>(() =>
      _i29.CraftDetailRepo(firebaseFirestore: gh<_i6.FirebaseFirestore>()));
  gh.lazySingleton<_i30.CrewDetailRepo>(() =>
      _i30.CrewDetailRepo(firebaseFirestore: gh<_i6.FirebaseFirestore>()));
  gh.lazySingleton<_i31.DynamicLinkRepo>(() =>
      _i31.DynamicLinkRepo(firebaseFirestore: gh<_i6.FirebaseFirestore>()));
  gh.lazySingleton<_i32.FirebaseLoginServeices>(
      () => _i32.FirebaseLoginServeices(
            firebaseFirestore: gh<_i6.FirebaseFirestore>(),
            firebaseMessaging: gh<_i7.FirebaseMessaging>(),
            firebaseAuth: gh<_i5.FirebaseAuth>(),
          ));
  return getIt;
}

class _$FirebaseInjectableModule extends _i8.FirebaseInjectableModule {}
