import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/app_root.dart';
import 'package:mytune/features/authentication/provider/country_code_picker_provider.dart';
import 'package:mytune/features/authentication/provider/login_provider.dart';
import 'package:mytune/general/di/injection.dart';
import 'package:mytune/general/utils/theam/app_theam.dart';
import 'package:provider/provider.dart';

import 'features/authentication/repository/firebase_login_serveices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(
            firebaseLoginServeices: locater<FirebaseLoginServeices>(),
            firebaseAuth: locater<FirebaseAuth>(),
          ),
        ),
        ChangeNotifierProvider<CountryCodePickerProvider>(
          create: (context) => CountryCodePickerProvider(),
        ),
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
