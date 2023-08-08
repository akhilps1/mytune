import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mytune/features/artist_details/provider/artist_details_provider.dart';
import 'package:mytune/features/artists/provider/artists_screen_provider.dart';
import 'package:mytune/features/authentication/provider/country_code_picker_provider.dart';
import 'package:mytune/features/authentication/provider/login_provider.dart';
import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/features/home/models/product_model.dart';
import 'package:mytune/features/home/provider/home_screen_provider.dart';
import 'package:mytune/features/home/provider/local_db_data_provider.dart';

import 'package:mytune/features/product_details/provider/product_details_provider.dart';
import 'package:mytune/features/search/provider/saerch_provider.dart';
import 'package:mytune/features/splash_screen/screens/screen_splash.dart';
import 'package:mytune/features/trending/provider/trending_page_provider.dart';
import 'package:mytune/features/user_details/provider/user_details_provider.dart';
import 'package:mytune/general/di/injection.dart';
import 'package:mytune/general/utils/theam/app_theam.dart';
import 'package:provider/provider.dart';

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserDetailsProvider()),
        ChangeNotifierProvider<HomeScreenProvider>(
          create: (_) => HomeScreenProvider()..getDetails(),
        ),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(
            create: (context) => CountryCodePickerProvider()),
        ChangeNotifierProvider(
            create: (_) => ArtistScreenProvider()..getAllArtistsByLimit()),
        ChangeNotifierProvider(create: (context) => ArtistDetailsProvider()),
        ChangeNotifierProvider(create: (context) => ProductDetailsProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(
          create: (context) => TrendingPageProvider()..getTrendingByLimite(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalDbDataProvider()
            ..getLikedVideos()
            ..getFollowedArtist(),
        )
      ],
      child: MaterialApp(
        title: 'WyTune',
        debugShowCheckedModeBanner: false,
        theme: AppTheam.lightTheam,
        home: const ScreenSplash(),
      ),
    );
  }
}
