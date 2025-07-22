import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:dishdash/app/core/services/storage/database.dart';
import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> serviceLocator() async {
  $initGetIt(getIt);
}

// Add this module alongside your existing FirebaseAuthModule
@module
abstract class DatabaseModule {
  @lazySingleton
  AppDatabase get database => AppDatabase();
}
