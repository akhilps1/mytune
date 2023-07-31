import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mytune/features/app_root.dart';
import 'package:mytune/features/artist_details/provider/artist_details_provider.dart';
import 'package:mytune/features/artists/provider/artists_screen_provider.dart';
import 'package:mytune/features/authentication/provider/country_code_picker_provider.dart';
import 'package:mytune/features/authentication/provider/login_provider.dart';
import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/features/home/models/product_model.dart';
import 'package:mytune/features/home/provider/home_screen_provider.dart';
import 'package:mytune/features/home/repository/banner_reopsitory.dart';
import 'package:mytune/features/home/repository/category_repository.dart';
import 'package:mytune/features/home/repository/today_release_repository.dart';
import 'package:mytune/features/product_details/provider/product_details_rovider.dart';
import 'package:mytune/general/di/injection.dart';
import 'package:mytune/general/utils/theam/app_theam.dart';
import 'package:provider/provider.dart';

import 'features/authentication/repository/firebase_login_serveices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependency();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(ProductModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeScreenProvider>(
          create: (_) => HomeScreenProvider(
            todayReleaseRepository: locater<TodayReleaseRepository>(),
            bannerRepository: locater<BannerRepository>(),
            categoryRepository: locater<CategoryRepository>(),
          )..getDetails(),
        ),
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(
            firebaseLoginServeices: locater<FirebaseLoginServeices>(),
            firebaseAuth: locater<FirebaseAuth>(),
          ),
        ),
        ChangeNotifierProvider<CountryCodePickerProvider>(
          create: (context) => CountryCodePickerProvider(),
        ),
        ChangeNotifierProxyProvider<HomeScreenProvider, ArtistScreenProvider>(
          create: (context) => ArtistScreenProvider(
            [],
            Provider.of<HomeScreenProvider>(
              context,
              listen: false,
            ),
          ),
          update: (context, value, previous) => ArtistScreenProvider(
            value.categories,
            value,
          ),
        ),
        ChangeNotifierProvider(create: (context) => ArtistDetailsProvider()),
        ChangeNotifierProvider(create: (context) => ProductDetailsProvider())
      ],
      child: MaterialApp(
        title: 'My Tune',
        debugShowCheckedModeBanner: false,
        theme: AppTheam.lightTheam,
        home: const AppRoot(),
      ),
    );
  }
}
