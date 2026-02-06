// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/splash/notifiers/get_user_notifier.dart' as _i566;
import '../repositories/auth_repository.dart' as _i1002;
import '../repositories/recipes_repository.dart' as _i14;
import '../services/api/api_service.dart' as _i561;
import '../services/storage/bookmark_dao.dart' as _i831;
import '../services/storage/database.dart' as _i363;
import '../services/storage/notes_dao.dart' as _i902;
import '../services/storage/offline_client.dart' as _i548;
import '../usecases/auth_use_case.dart' as _i67;
import '../usecases/recipes_use_case.dart' as _i197;
import 'injector.dart' as _i811;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final databaseModule = _$DatabaseModule();
  final authModule = _$AuthModule();
  gh.lazySingleton<_i363.AppDatabase>(() => databaseModule.database);
  gh.lazySingleton<_i59.FirebaseAuth>(() => authModule.firebaseAuth);
  gh.lazySingleton<_i116.GoogleSignIn>(() => authModule.googleSignIn);
  gh.lazySingleton<_i548.OfflineClient>(
    () => _i548.OfflineClientImpl(gh<_i363.AppDatabase>()),
  );
  gh.lazySingleton<_i831.BookmarkDao>(
    () => databaseModule.bookmarkDao(gh<_i363.AppDatabase>()),
  );
  gh.lazySingleton<_i902.NotesDao>(
    () => databaseModule.notesDao(gh<_i363.AppDatabase>()),
  );
  gh.factory<_i561.ApiService>(() => _i561.ApiServiceImpl());
  gh.lazySingleton<_i1002.AuthRepository>(
    () => _i1002.AuthRepositoryImpl(
      gh<_i59.FirebaseAuth>(),
      gh<_i116.GoogleSignIn>(),
      gh<_i548.OfflineClient>(),
    ),
  );
  gh.lazySingleton<_i14.SearchRepository>(
    () => _i14.SearchRepositoryImpl(
      gh<_i561.ApiService>(),
      gh<_i548.OfflineClient>(),
    ),
  );
  gh.lazySingleton<_i197.RecipeUseCase>(
    () => _i197.RecipeUseCase(gh<_i14.SearchRepository>()),
  );
  gh.lazySingleton<_i67.AuthUseCase>(
    () => _i67.AuthUseCase(gh<_i1002.AuthRepository>()),
  );
  gh.lazySingleton<_i566.GetUserNotifier>(
    () => _i566.GetUserNotifier(authUseCase: gh<_i67.AuthUseCase>()),
  );
  return getIt;
}

class _$DatabaseModule extends _i811.DatabaseModule {}

class _$AuthModule extends _i1002.AuthModule {}
