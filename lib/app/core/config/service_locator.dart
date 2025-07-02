import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dishdash/app/core/services/storage/offline_client.dart';
import 'package:dishdash/app/core/repositories/auth_repository.dart';
import 'package:dishdash/app/core/usecases/auth_use_case.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Initialize offline client first
  final offlineClient = await OfflineClientImpl.getInstance();
  
  // Register services
  getIt.registerLazySingleton<OfflineClient>(() => offlineClient);
  
  // Register Firebase Auth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  
  // Register repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      firebaseAuth: getIt<FirebaseAuth>(),
      offlineClient: getIt<OfflineClient>(),
    ),
  );
  
  // Register use case
  getIt.registerLazySingleton<AuthUseCase>(
    () => AuthUseCase(getIt<AuthRepository>()),
  );
}