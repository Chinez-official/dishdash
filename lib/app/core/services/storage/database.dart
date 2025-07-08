import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

// Define the storage table for key-value pairs
class StorageEntries extends Table {
  TextColumn get key => text().unique()();
  TextColumn get value => text()();
  TextColumn get type => text()(); // 'string', 'bool', 'int', 'double'
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [StorageEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'dishdash_database',
      native: DriftNativeOptions(
        databaseDirectory: () async => await getApplicationSupportDirectory(),
      ),
    );
  }
}