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

// Define the bookmarked meals table
class BookmarkedMeals extends Table {
  TextColumn get idMeal => text()();
  TextColumn get strMeal => text().nullable()();
  TextColumn get strCategory => text().nullable()();
  TextColumn get strArea => text().nullable()();
  TextColumn get strInstructions => text().nullable()();
  TextColumn get strMealThumb => text().nullable()();
  TextColumn get strTags => text().nullable()();
  TextColumn get ingredientsJson =>
      text().nullable()(); // JSON array of ingredients
  DateTimeColumn get bookmarkedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {idMeal};
}

// Define the recipe notes table
class RecipeNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get mealId => text().nullable()(); // Optional link to a recipe
  TextColumn get mealName => text().nullable()(); // Store meal name for display
  TextColumn get mealThumb => text().nullable()(); // Store meal thumbnail
  IntColumn get rating => integer().nullable()(); // 1-5 rating
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [StorageEntries, BookmarkedMeals, RecipeNotes])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.createTable(bookmarkedMeals);
      }
      if (from < 3) {
        await m.createTable(recipeNotes);
      }
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'dishdash_database',
      native: DriftNativeOptions(
        databaseDirectory: () async => await getApplicationSupportDirectory(),
      ),
    );
  }
}
