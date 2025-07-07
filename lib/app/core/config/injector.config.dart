// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../repositories/auth_repository.dart' as _i1002;
import '../services/storage/offline_client.dart' as _i548;
import '../usecases/auth_use_case.dart' as _i67;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final firebaseAuthModule = _$FirebaseAuthModule();
  gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseAuthModule.firebaseAuth);
  gh.lazySingleton<_i548.OfflineClient>(() => _i548.OfflineClientImpl());
  gh.lazySingleton<_i1002.AuthRepository>(
    () => _i1002.AuthRepositoryImpl(
      gh<_i59.FirebaseAuth>(),
      gh<_i548.OfflineClient>(),
    ),
  );
  gh.lazySingleton<_i67.AuthUseCase>(
    () => _i67.AuthUseCase(gh<_i1002.AuthRepository>()),
  );
  return getIt;
}

class _$FirebaseAuthModule extends _i1002.FirebaseAuthModule {}
