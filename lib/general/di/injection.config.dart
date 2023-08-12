// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i8;
import 'package:firebase_auth/firebase_auth.dart' as _i7;
import 'package:firebase_messaging/firebase_messaging.dart' as _i9;
import 'package:firebase_storage/firebase_storage.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/artist_details/provider/artist_details_provider.dart'
    as _i3;
import '../../features/artist_details/repository/artist_details_repo.dart'
    as _i26;
import '../../features/artists/provider/artists_screen_provider.dart' as _i4;
import '../../features/artists/repository/category_repository.dart' as _i29;
import '../../features/authentication/provider/login_provider.dart' as _i14;
import '../../features/authentication/repository/firebase_login_serveices.dart'
    as _i36;
import '../../features/comment/provider/comment_provider.dart' as _i5;
import '../../features/comment/repository/comment_repo.dart' as _i31;
import '../../features/favorate/provider/favorate_provider.dart' as _i6;
import '../../features/favorate/repository/favorate_repo.dart' as _i35;
import '../../features/home/provider/home_screen_provider.dart' as _i12;
import '../../features/home/provider/local_db_data_provider.dart' as _i13;
import '../../features/home/repository/all_products_repository.dart' as _i25;
import '../../features/home/repository/artists_repo.dart' as _i27;
import '../../features/home/repository/banner_reopsitory.dart' as _i28;
import '../../features/home/repository/dynamic_link_repo.dart' as _i34;
import '../../features/home/repository/today_release_repository.dart' as _i19;
import '../../features/home/repository/top_3_repository.dart' as _i20;
import '../../features/product_details/provider/product_details_provider.dart'
    as _i15;
import '../../features/product_details/repository/craft_details_repo.dart'
    as _i32;
import '../../features/product_details/repository/crew_detail_repo.dart'
    as _i33;
import '../../features/product_details/repository/product_details_repo.dart'
    as _i16;
import '../../features/search/provider/saerch_provider.dart' as _i18;
import '../../features/search/repository/category_search_repo.dart' as _i30;
import '../../features/search/repository/product_search_repo.dart' as _i17;
import '../../features/trending/provider/trending_page_provider.dart' as _i21;
import '../../features/trending/repository/trending_repo.dart' as _i22;
import '../../features/user_details/provider/user_details_provider.dart'
    as _i23;
import '../../features/user_details/repository/user_details_repo.dart' as _i24;
import 'firebase_injectable_module.dart' as _i10;

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
  gh.factory<_i5.CommentProvider>(() => _i5.CommentProvider());
  gh.factory<_i6.FavorateProvider>(() => _i6.FavorateProvider());
  gh.lazySingleton<_i7.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i8.FirebaseFirestore>(
      () => firebaseInjectableModule.firestore);
  gh.lazySingleton<_i9.FirebaseMessaging>(
      () => firebaseInjectableModule.firebaseMessaging);
  await gh.factoryAsync<_i10.FirebaseServeice>(
    () => firebaseInjectableModule.firebaseServeice,
    preResolve: true,
  );
  gh.lazySingleton<_i11.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseDtorage);
  gh.factory<_i12.HomeScreenProvider>(() => _i12.HomeScreenProvider());
  gh.factory<_i13.LocalDbDataProvider>(() => _i13.LocalDbDataProvider());
  gh.factory<_i14.LoginProvider>(() => _i14.LoginProvider());
  gh.factory<_i15.ProductDetailsProvider>(() => _i15.ProductDetailsProvider());
  gh.lazySingleton<_i16.ProductDetailsRepo>(() => _i16.ProductDetailsRepo(
        firebaseFirestore: gh<_i8.FirebaseFirestore>(),
        firebaseAuth: gh<_i7.FirebaseAuth>(),
      ));
  gh.lazySingleton<_i17.ProductSearchRepo>(() =>
      _i17.ProductSearchRepo(firebaseFirestore: gh<_i8.FirebaseFirestore>()));
  gh.factory<_i18.SearchProvider>(() => _i18.SearchProvider());
  gh.lazySingleton<_i19.TodayReleaseRepository>(() =>
      _i19.TodayReleaseRepository(
          firebaseFirestore: gh<_i8.FirebaseFirestore>()));
  gh.lazySingleton<_i20.TopThreeReleaseRepo>(() =>
      _i20.TopThreeReleaseRepo(firebaseFirestore: gh<_i8.FirebaseFirestore>()));
  gh.factory<_i21.TrendingPageProvider>(() => _i21.TrendingPageProvider());
  gh.lazySingleton<_i22.TrendingPageRepo>(() =>
      _i22.TrendingPageRepo(firebaseFirestore: gh<_i8.FirebaseFirestore>()));
  gh.factory<_i23.UserDetailsProvider>(() => _i23.UserDetailsProvider());
  gh.lazySingleton<_i24.UserDetailsRepo>(() => _i24.UserDetailsRepo(
        firebaseFirestore: gh<_i8.FirebaseFirestore>(),
        firebaseStorage: gh<_i11.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i25.AllProductsRepo>(() =>
      _i25.AllProductsRepo(firebaseFirestore: gh<_i8.FirebaseFirestore>()));
  gh.lazySingleton<_i26.ArtistDetailsRepo>(() => _i26.ArtistDetailsRepo(
        firebaseFirestore: gh<_i8.FirebaseFirestore>(),
        firebaseAuth: gh<_i7.FirebaseAuth>(),
      ));
  gh.lazySingleton<_i27.ArtistRepo>(
      () => _i27.ArtistRepo(firebaseFirestore: gh<_i8.FirebaseFirestore>()));
  gh.lazySingleton<_i28.BannerRepository>(() =>
      _i28.BannerRepository(firebaseFirestore: gh<_i8.FirebaseFirestore>()));
  gh.lazySingleton<_i29.CategoryRepository>(() => _i29.CategoryRepository(
        firebaseFirestore: gh<_i8.FirebaseFirestore>(),
        firebaseAuth: gh<_i7.FirebaseAuth>(),
      ));
  gh.lazySingleton<_i30.CategorySearchRepo>(() =>
      _i30.CategorySearchRepo(firebaseFirestore: gh<_i8.FirebaseFirestore>()));
  gh.lazySingleton<_i31.CommentRepo>(
      () => _i31.CommentRepo(firebaseFirestore: gh<_i8.FirebaseFirestore>()));
  gh.lazySingleton<_i32.CraftDetailRepo>(() =>
      _i32.CraftDetailRepo(firebaseFirestore: gh<_i8.FirebaseFirestore>()));
  gh.lazySingleton<_i33.CrewDetailRepo>(() =>
      _i33.CrewDetailRepo(firebaseFirestore: gh<_i8.FirebaseFirestore>()));
  gh.lazySingleton<_i34.DynamicLinkRepo>(() =>
      _i34.DynamicLinkRepo(firebaseFirestore: gh<_i8.FirebaseFirestore>()));
  gh.lazySingleton<_i35.FavorateRepo>(() => _i35.FavorateRepo(
        firebaseFirestore: gh<_i8.FirebaseFirestore>(),
        firebaseAuth: gh<_i7.FirebaseAuth>(),
      ));
  gh.lazySingleton<_i36.FirebaseLoginServeices>(
      () => _i36.FirebaseLoginServeices(
            firebaseFirestore: gh<_i8.FirebaseFirestore>(),
            firebaseMessaging: gh<_i9.FirebaseMessaging>(),
            firebaseAuth: gh<_i7.FirebaseAuth>(),
          ));
  return getIt;
}

class _$FirebaseInjectableModule extends _i10.FirebaseInjectableModule {}
