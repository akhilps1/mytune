import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final GetIt locater = GetIt.I;

@InjectableInit(
  initializerName: 'init', // default init
  preferRelativeImports: true, // default true
  asExtension: false,
)
Future<void> configureDependency() async => await init(
      locater,
      environment: Environment.prod,
    );
