import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart';
import 'database.dart';

abstract class OfflineClient {
  Future<bool> setString(String key, String value);
  Future<String> getString(String key);
  Future<bool> setBool(String key, bool value);
  Future<bool> getBool(String key);
  Future<bool> clearStorage();
  Future<bool> remove(String key);
}

@LazySingleton(as: OfflineClient)
class OfflineClientImpl implements OfflineClient {
  final AppDatabase _database;

  OfflineClientImpl(this._database);

  @override
  Future<bool> setString(String key, String value) async {
    try {
      await _database
          .into(_database.storageEntries)
          .insertOnConflictUpdate(
            StorageEntriesCompanion.insert(
              key: key,
              value: value,
              type: 'string',
              updatedAt: Value(DateTime.now()),
            ),
          );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> getString(String key) async {
    try {
      final query = _database.select(_database.storageEntries)
        ..where((tbl) => tbl.key.equals(key) & tbl.type.equals('string'));

      final result = await query.getSingleOrNull();
      return result?.value ?? '';
    } catch (e) {
      return '';
    }
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    try {
      await _database
          .into(_database.storageEntries)
          .insertOnConflictUpdate(
            StorageEntriesCompanion.insert(
              key: key,
              value: value.toString(),
              type: 'bool',
              updatedAt: Value(DateTime.now()),
            ),
          );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> getBool(String key) async {
    try {
      final query = _database.select(_database.storageEntries)
        ..where((tbl) => tbl.key.equals(key) & tbl.type.equals('bool'));

      final result = await query.getSingleOrNull();
      return result?.value.toLowerCase() == 'true';
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> clearStorage() async {
    try {
      await _database.delete(_database.storageEntries).go();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> remove(String key) async {
    try {
      final rowsAffected =
          await (_database.delete(_database.storageEntries)
            ..where((tbl) => tbl.key.equals(key))).go();
      return rowsAffected > 0;
    } catch (e) {
      return false;
    }
  } 
}
