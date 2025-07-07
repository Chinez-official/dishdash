import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:dishdash/app/core/services/storage/offline_client.dart';
import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> serviceLocator() async {
  // Initialize offline client first
  await OfflineClientImpl.getInstance();
  $initGetIt(getIt);
}
