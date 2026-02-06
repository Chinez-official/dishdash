import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:dishdash/app/core/services/storage/database.dart';
import 'package:dishdash/app/core/services/storage/bookmark_dao.dart';
import 'package:dishdash/app/core/services/storage/notes_dao.dart';
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

@module
abstract class DatabaseModule {
  @lazySingleton
  AppDatabase get database => AppDatabase();

  @lazySingleton
  BookmarkDao bookmarkDao(AppDatabase database) => BookmarkDao(database);

  @lazySingleton
  NotesDao notesDao(AppDatabase database) => NotesDao(database);
}
