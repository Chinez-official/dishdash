// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $StorageEntriesTable extends StorageEntries
    with TableInfo<$StorageEntriesTable, StorageEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StorageEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    key,
    value,
    type,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'storage_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<StorageEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  StorageEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StorageEntry(
      key:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}key'],
          )!,
      value:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}value'],
          )!,
      type:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}type'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $StorageEntriesTable createAlias(String alias) {
    return $StorageEntriesTable(attachedDatabase, alias);
  }
}

class StorageEntry extends DataClass implements Insertable<StorageEntry> {
  final String key;
  final String value;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  const StorageEntry({
    required this.key,
    required this.value,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['type'] = Variable<String>(type);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StorageEntriesCompanion toCompanion(bool nullToAbsent) {
    return StorageEntriesCompanion(
      key: Value(key),
      value: Value(value),
      type: Value(type),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory StorageEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StorageEntry(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      type: serializer.fromJson<String>(json['type']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'type': serializer.toJson<String>(type),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StorageEntry copyWith({
    String? key,
    String? value,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => StorageEntry(
    key: key ?? this.key,
    value: value ?? this.value,
    type: type ?? this.type,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StorageEntry copyWithCompanion(StorageEntriesCompanion data) {
    return StorageEntry(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      type: data.type.present ? data.type.value : this.type,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StorageEntry(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, type, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StorageEntry &&
          other.key == this.key &&
          other.value == this.value &&
          other.type == this.type &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StorageEntriesCompanion extends UpdateCompanion<StorageEntry> {
  final Value<String> key;
  final Value<String> value;
  final Value<String> type;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const StorageEntriesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StorageEntriesCompanion.insert({
    required String key,
    required String value,
    required String type,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       type = Value(type);
  static Insertable<StorageEntry> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<String>? type,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StorageEntriesCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<String>? type,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return StorageEntriesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StorageEntriesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookmarkedMealsTable extends BookmarkedMeals
    with TableInfo<$BookmarkedMealsTable, BookmarkedMeal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarkedMealsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMealMeta = const VerificationMeta('idMeal');
  @override
  late final GeneratedColumn<String> idMeal = GeneratedColumn<String>(
    'id_meal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _strMealMeta = const VerificationMeta(
    'strMeal',
  );
  @override
  late final GeneratedColumn<String> strMeal = GeneratedColumn<String>(
    'str_meal',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _strCategoryMeta = const VerificationMeta(
    'strCategory',
  );
  @override
  late final GeneratedColumn<String> strCategory = GeneratedColumn<String>(
    'str_category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _strAreaMeta = const VerificationMeta(
    'strArea',
  );
  @override
  late final GeneratedColumn<String> strArea = GeneratedColumn<String>(
    'str_area',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _strInstructionsMeta = const VerificationMeta(
    'strInstructions',
  );
  @override
  late final GeneratedColumn<String> strInstructions = GeneratedColumn<String>(
    'str_instructions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _strMealThumbMeta = const VerificationMeta(
    'strMealThumb',
  );
  @override
  late final GeneratedColumn<String> strMealThumb = GeneratedColumn<String>(
    'str_meal_thumb',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _strTagsMeta = const VerificationMeta(
    'strTags',
  );
  @override
  late final GeneratedColumn<String> strTags = GeneratedColumn<String>(
    'str_tags',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ingredientsJsonMeta = const VerificationMeta(
    'ingredientsJson',
  );
  @override
  late final GeneratedColumn<String> ingredientsJson = GeneratedColumn<String>(
    'ingredients_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bookmarkedAtMeta = const VerificationMeta(
    'bookmarkedAt',
  );
  @override
  late final GeneratedColumn<DateTime> bookmarkedAt = GeneratedColumn<DateTime>(
    'bookmarked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    idMeal,
    strMeal,
    strCategory,
    strArea,
    strInstructions,
    strMealThumb,
    strTags,
    ingredientsJson,
    bookmarkedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarked_meals';
  @override
  VerificationContext validateIntegrity(
    Insertable<BookmarkedMeal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_meal')) {
      context.handle(
        _idMealMeta,
        idMeal.isAcceptableOrUnknown(data['id_meal']!, _idMealMeta),
      );
    } else if (isInserting) {
      context.missing(_idMealMeta);
    }
    if (data.containsKey('str_meal')) {
      context.handle(
        _strMealMeta,
        strMeal.isAcceptableOrUnknown(data['str_meal']!, _strMealMeta),
      );
    }
    if (data.containsKey('str_category')) {
      context.handle(
        _strCategoryMeta,
        strCategory.isAcceptableOrUnknown(
          data['str_category']!,
          _strCategoryMeta,
        ),
      );
    }
    if (data.containsKey('str_area')) {
      context.handle(
        _strAreaMeta,
        strArea.isAcceptableOrUnknown(data['str_area']!, _strAreaMeta),
      );
    }
    if (data.containsKey('str_instructions')) {
      context.handle(
        _strInstructionsMeta,
        strInstructions.isAcceptableOrUnknown(
          data['str_instructions']!,
          _strInstructionsMeta,
        ),
      );
    }
    if (data.containsKey('str_meal_thumb')) {
      context.handle(
        _strMealThumbMeta,
        strMealThumb.isAcceptableOrUnknown(
          data['str_meal_thumb']!,
          _strMealThumbMeta,
        ),
      );
    }
    if (data.containsKey('str_tags')) {
      context.handle(
        _strTagsMeta,
        strTags.isAcceptableOrUnknown(data['str_tags']!, _strTagsMeta),
      );
    }
    if (data.containsKey('ingredients_json')) {
      context.handle(
        _ingredientsJsonMeta,
        ingredientsJson.isAcceptableOrUnknown(
          data['ingredients_json']!,
          _ingredientsJsonMeta,
        ),
      );
    }
    if (data.containsKey('bookmarked_at')) {
      context.handle(
        _bookmarkedAtMeta,
        bookmarkedAt.isAcceptableOrUnknown(
          data['bookmarked_at']!,
          _bookmarkedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idMeal};
  @override
  BookmarkedMeal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookmarkedMeal(
      idMeal:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id_meal'],
          )!,
      strMeal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}str_meal'],
      ),
      strCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}str_category'],
      ),
      strArea: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}str_area'],
      ),
      strInstructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}str_instructions'],
      ),
      strMealThumb: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}str_meal_thumb'],
      ),
      strTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}str_tags'],
      ),
      ingredientsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredients_json'],
      ),
      bookmarkedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}bookmarked_at'],
          )!,
    );
  }

  @override
  $BookmarkedMealsTable createAlias(String alias) {
    return $BookmarkedMealsTable(attachedDatabase, alias);
  }
}

class BookmarkedMeal extends DataClass implements Insertable<BookmarkedMeal> {
  final String idMeal;
  final String? strMeal;
  final String? strCategory;
  final String? strArea;
  final String? strInstructions;
  final String? strMealThumb;
  final String? strTags;
  final String? ingredientsJson;
  final DateTime bookmarkedAt;
  const BookmarkedMeal({
    required this.idMeal,
    this.strMeal,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.ingredientsJson,
    required this.bookmarkedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_meal'] = Variable<String>(idMeal);
    if (!nullToAbsent || strMeal != null) {
      map['str_meal'] = Variable<String>(strMeal);
    }
    if (!nullToAbsent || strCategory != null) {
      map['str_category'] = Variable<String>(strCategory);
    }
    if (!nullToAbsent || strArea != null) {
      map['str_area'] = Variable<String>(strArea);
    }
    if (!nullToAbsent || strInstructions != null) {
      map['str_instructions'] = Variable<String>(strInstructions);
    }
    if (!nullToAbsent || strMealThumb != null) {
      map['str_meal_thumb'] = Variable<String>(strMealThumb);
    }
    if (!nullToAbsent || strTags != null) {
      map['str_tags'] = Variable<String>(strTags);
    }
    if (!nullToAbsent || ingredientsJson != null) {
      map['ingredients_json'] = Variable<String>(ingredientsJson);
    }
    map['bookmarked_at'] = Variable<DateTime>(bookmarkedAt);
    return map;
  }

  BookmarkedMealsCompanion toCompanion(bool nullToAbsent) {
    return BookmarkedMealsCompanion(
      idMeal: Value(idMeal),
      strMeal:
          strMeal == null && nullToAbsent
              ? const Value.absent()
              : Value(strMeal),
      strCategory:
          strCategory == null && nullToAbsent
              ? const Value.absent()
              : Value(strCategory),
      strArea:
          strArea == null && nullToAbsent
              ? const Value.absent()
              : Value(strArea),
      strInstructions:
          strInstructions == null && nullToAbsent
              ? const Value.absent()
              : Value(strInstructions),
      strMealThumb:
          strMealThumb == null && nullToAbsent
              ? const Value.absent()
              : Value(strMealThumb),
      strTags:
          strTags == null && nullToAbsent
              ? const Value.absent()
              : Value(strTags),
      ingredientsJson:
          ingredientsJson == null && nullToAbsent
              ? const Value.absent()
              : Value(ingredientsJson),
      bookmarkedAt: Value(bookmarkedAt),
    );
  }

  factory BookmarkedMeal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookmarkedMeal(
      idMeal: serializer.fromJson<String>(json['idMeal']),
      strMeal: serializer.fromJson<String?>(json['strMeal']),
      strCategory: serializer.fromJson<String?>(json['strCategory']),
      strArea: serializer.fromJson<String?>(json['strArea']),
      strInstructions: serializer.fromJson<String?>(json['strInstructions']),
      strMealThumb: serializer.fromJson<String?>(json['strMealThumb']),
      strTags: serializer.fromJson<String?>(json['strTags']),
      ingredientsJson: serializer.fromJson<String?>(json['ingredientsJson']),
      bookmarkedAt: serializer.fromJson<DateTime>(json['bookmarkedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idMeal': serializer.toJson<String>(idMeal),
      'strMeal': serializer.toJson<String?>(strMeal),
      'strCategory': serializer.toJson<String?>(strCategory),
      'strArea': serializer.toJson<String?>(strArea),
      'strInstructions': serializer.toJson<String?>(strInstructions),
      'strMealThumb': serializer.toJson<String?>(strMealThumb),
      'strTags': serializer.toJson<String?>(strTags),
      'ingredientsJson': serializer.toJson<String?>(ingredientsJson),
      'bookmarkedAt': serializer.toJson<DateTime>(bookmarkedAt),
    };
  }

  BookmarkedMeal copyWith({
    String? idMeal,
    Value<String?> strMeal = const Value.absent(),
    Value<String?> strCategory = const Value.absent(),
    Value<String?> strArea = const Value.absent(),
    Value<String?> strInstructions = const Value.absent(),
    Value<String?> strMealThumb = const Value.absent(),
    Value<String?> strTags = const Value.absent(),
    Value<String?> ingredientsJson = const Value.absent(),
    DateTime? bookmarkedAt,
  }) => BookmarkedMeal(
    idMeal: idMeal ?? this.idMeal,
    strMeal: strMeal.present ? strMeal.value : this.strMeal,
    strCategory: strCategory.present ? strCategory.value : this.strCategory,
    strArea: strArea.present ? strArea.value : this.strArea,
    strInstructions:
        strInstructions.present ? strInstructions.value : this.strInstructions,
    strMealThumb: strMealThumb.present ? strMealThumb.value : this.strMealThumb,
    strTags: strTags.present ? strTags.value : this.strTags,
    ingredientsJson:
        ingredientsJson.present ? ingredientsJson.value : this.ingredientsJson,
    bookmarkedAt: bookmarkedAt ?? this.bookmarkedAt,
  );
  BookmarkedMeal copyWithCompanion(BookmarkedMealsCompanion data) {
    return BookmarkedMeal(
      idMeal: data.idMeal.present ? data.idMeal.value : this.idMeal,
      strMeal: data.strMeal.present ? data.strMeal.value : this.strMeal,
      strCategory:
          data.strCategory.present ? data.strCategory.value : this.strCategory,
      strArea: data.strArea.present ? data.strArea.value : this.strArea,
      strInstructions:
          data.strInstructions.present
              ? data.strInstructions.value
              : this.strInstructions,
      strMealThumb:
          data.strMealThumb.present
              ? data.strMealThumb.value
              : this.strMealThumb,
      strTags: data.strTags.present ? data.strTags.value : this.strTags,
      ingredientsJson:
          data.ingredientsJson.present
              ? data.ingredientsJson.value
              : this.ingredientsJson,
      bookmarkedAt:
          data.bookmarkedAt.present
              ? data.bookmarkedAt.value
              : this.bookmarkedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BookmarkedMeal(')
          ..write('idMeal: $idMeal, ')
          ..write('strMeal: $strMeal, ')
          ..write('strCategory: $strCategory, ')
          ..write('strArea: $strArea, ')
          ..write('strInstructions: $strInstructions, ')
          ..write('strMealThumb: $strMealThumb, ')
          ..write('strTags: $strTags, ')
          ..write('ingredientsJson: $ingredientsJson, ')
          ..write('bookmarkedAt: $bookmarkedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    idMeal,
    strMeal,
    strCategory,
    strArea,
    strInstructions,
    strMealThumb,
    strTags,
    ingredientsJson,
    bookmarkedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookmarkedMeal &&
          other.idMeal == this.idMeal &&
          other.strMeal == this.strMeal &&
          other.strCategory == this.strCategory &&
          other.strArea == this.strArea &&
          other.strInstructions == this.strInstructions &&
          other.strMealThumb == this.strMealThumb &&
          other.strTags == this.strTags &&
          other.ingredientsJson == this.ingredientsJson &&
          other.bookmarkedAt == this.bookmarkedAt);
}

class BookmarkedMealsCompanion extends UpdateCompanion<BookmarkedMeal> {
  final Value<String> idMeal;
  final Value<String?> strMeal;
  final Value<String?> strCategory;
  final Value<String?> strArea;
  final Value<String?> strInstructions;
  final Value<String?> strMealThumb;
  final Value<String?> strTags;
  final Value<String?> ingredientsJson;
  final Value<DateTime> bookmarkedAt;
  final Value<int> rowid;
  const BookmarkedMealsCompanion({
    this.idMeal = const Value.absent(),
    this.strMeal = const Value.absent(),
    this.strCategory = const Value.absent(),
    this.strArea = const Value.absent(),
    this.strInstructions = const Value.absent(),
    this.strMealThumb = const Value.absent(),
    this.strTags = const Value.absent(),
    this.ingredientsJson = const Value.absent(),
    this.bookmarkedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookmarkedMealsCompanion.insert({
    required String idMeal,
    this.strMeal = const Value.absent(),
    this.strCategory = const Value.absent(),
    this.strArea = const Value.absent(),
    this.strInstructions = const Value.absent(),
    this.strMealThumb = const Value.absent(),
    this.strTags = const Value.absent(),
    this.ingredientsJson = const Value.absent(),
    this.bookmarkedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : idMeal = Value(idMeal);
  static Insertable<BookmarkedMeal> custom({
    Expression<String>? idMeal,
    Expression<String>? strMeal,
    Expression<String>? strCategory,
    Expression<String>? strArea,
    Expression<String>? strInstructions,
    Expression<String>? strMealThumb,
    Expression<String>? strTags,
    Expression<String>? ingredientsJson,
    Expression<DateTime>? bookmarkedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (idMeal != null) 'id_meal': idMeal,
      if (strMeal != null) 'str_meal': strMeal,
      if (strCategory != null) 'str_category': strCategory,
      if (strArea != null) 'str_area': strArea,
      if (strInstructions != null) 'str_instructions': strInstructions,
      if (strMealThumb != null) 'str_meal_thumb': strMealThumb,
      if (strTags != null) 'str_tags': strTags,
      if (ingredientsJson != null) 'ingredients_json': ingredientsJson,
      if (bookmarkedAt != null) 'bookmarked_at': bookmarkedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookmarkedMealsCompanion copyWith({
    Value<String>? idMeal,
    Value<String?>? strMeal,
    Value<String?>? strCategory,
    Value<String?>? strArea,
    Value<String?>? strInstructions,
    Value<String?>? strMealThumb,
    Value<String?>? strTags,
    Value<String?>? ingredientsJson,
    Value<DateTime>? bookmarkedAt,
    Value<int>? rowid,
  }) {
    return BookmarkedMealsCompanion(
      idMeal: idMeal ?? this.idMeal,
      strMeal: strMeal ?? this.strMeal,
      strCategory: strCategory ?? this.strCategory,
      strArea: strArea ?? this.strArea,
      strInstructions: strInstructions ?? this.strInstructions,
      strMealThumb: strMealThumb ?? this.strMealThumb,
      strTags: strTags ?? this.strTags,
      ingredientsJson: ingredientsJson ?? this.ingredientsJson,
      bookmarkedAt: bookmarkedAt ?? this.bookmarkedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idMeal.present) {
      map['id_meal'] = Variable<String>(idMeal.value);
    }
    if (strMeal.present) {
      map['str_meal'] = Variable<String>(strMeal.value);
    }
    if (strCategory.present) {
      map['str_category'] = Variable<String>(strCategory.value);
    }
    if (strArea.present) {
      map['str_area'] = Variable<String>(strArea.value);
    }
    if (strInstructions.present) {
      map['str_instructions'] = Variable<String>(strInstructions.value);
    }
    if (strMealThumb.present) {
      map['str_meal_thumb'] = Variable<String>(strMealThumb.value);
    }
    if (strTags.present) {
      map['str_tags'] = Variable<String>(strTags.value);
    }
    if (ingredientsJson.present) {
      map['ingredients_json'] = Variable<String>(ingredientsJson.value);
    }
    if (bookmarkedAt.present) {
      map['bookmarked_at'] = Variable<DateTime>(bookmarkedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarkedMealsCompanion(')
          ..write('idMeal: $idMeal, ')
          ..write('strMeal: $strMeal, ')
          ..write('strCategory: $strCategory, ')
          ..write('strArea: $strArea, ')
          ..write('strInstructions: $strInstructions, ')
          ..write('strMealThumb: $strMealThumb, ')
          ..write('strTags: $strTags, ')
          ..write('ingredientsJson: $ingredientsJson, ')
          ..write('bookmarkedAt: $bookmarkedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecipeNotesTable extends RecipeNotes
    with TableInfo<$RecipeNotesTable, RecipeNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealIdMeta = const VerificationMeta('mealId');
  @override
  late final GeneratedColumn<String> mealId = GeneratedColumn<String>(
    'meal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mealNameMeta = const VerificationMeta(
    'mealName',
  );
  @override
  late final GeneratedColumn<String> mealName = GeneratedColumn<String>(
    'meal_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mealThumbMeta = const VerificationMeta(
    'mealThumb',
  );
  @override
  late final GeneratedColumn<String> mealThumb = GeneratedColumn<String>(
    'meal_thumb',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    content,
    mealId,
    mealName,
    mealThumb,
    rating,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeNote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('meal_id')) {
      context.handle(
        _mealIdMeta,
        mealId.isAcceptableOrUnknown(data['meal_id']!, _mealIdMeta),
      );
    }
    if (data.containsKey('meal_name')) {
      context.handle(
        _mealNameMeta,
        mealName.isAcceptableOrUnknown(data['meal_name']!, _mealNameMeta),
      );
    }
    if (data.containsKey('meal_thumb')) {
      context.handle(
        _mealThumbMeta,
        mealThumb.isAcceptableOrUnknown(data['meal_thumb']!, _mealThumbMeta),
      );
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeNote(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      content:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}content'],
          )!,
      mealId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_id'],
      ),
      mealName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_name'],
      ),
      mealThumb: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_thumb'],
      ),
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $RecipeNotesTable createAlias(String alias) {
    return $RecipeNotesTable(attachedDatabase, alias);
  }
}

class RecipeNote extends DataClass implements Insertable<RecipeNote> {
  final int id;
  final String title;
  final String content;
  final String? mealId;
  final String? mealName;
  final String? mealThumb;
  final int? rating;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RecipeNote({
    required this.id,
    required this.title,
    required this.content,
    this.mealId,
    this.mealName,
    this.mealThumb,
    this.rating,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || mealId != null) {
      map['meal_id'] = Variable<String>(mealId);
    }
    if (!nullToAbsent || mealName != null) {
      map['meal_name'] = Variable<String>(mealName);
    }
    if (!nullToAbsent || mealThumb != null) {
      map['meal_thumb'] = Variable<String>(mealThumb);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<int>(rating);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RecipeNotesCompanion toCompanion(bool nullToAbsent) {
    return RecipeNotesCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      mealId:
          mealId == null && nullToAbsent ? const Value.absent() : Value(mealId),
      mealName:
          mealName == null && nullToAbsent
              ? const Value.absent()
              : Value(mealName),
      mealThumb:
          mealThumb == null && nullToAbsent
              ? const Value.absent()
              : Value(mealThumb),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RecipeNote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeNote(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      mealId: serializer.fromJson<String?>(json['mealId']),
      mealName: serializer.fromJson<String?>(json['mealName']),
      mealThumb: serializer.fromJson<String?>(json['mealThumb']),
      rating: serializer.fromJson<int?>(json['rating']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'mealId': serializer.toJson<String?>(mealId),
      'mealName': serializer.toJson<String?>(mealName),
      'mealThumb': serializer.toJson<String?>(mealThumb),
      'rating': serializer.toJson<int?>(rating),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RecipeNote copyWith({
    int? id,
    String? title,
    String? content,
    Value<String?> mealId = const Value.absent(),
    Value<String?> mealName = const Value.absent(),
    Value<String?> mealThumb = const Value.absent(),
    Value<int?> rating = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RecipeNote(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    mealId: mealId.present ? mealId.value : this.mealId,
    mealName: mealName.present ? mealName.value : this.mealName,
    mealThumb: mealThumb.present ? mealThumb.value : this.mealThumb,
    rating: rating.present ? rating.value : this.rating,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RecipeNote copyWithCompanion(RecipeNotesCompanion data) {
    return RecipeNote(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      mealId: data.mealId.present ? data.mealId.value : this.mealId,
      mealName: data.mealName.present ? data.mealName.value : this.mealName,
      mealThumb: data.mealThumb.present ? data.mealThumb.value : this.mealThumb,
      rating: data.rating.present ? data.rating.value : this.rating,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeNote(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('mealId: $mealId, ')
          ..write('mealName: $mealName, ')
          ..write('mealThumb: $mealThumb, ')
          ..write('rating: $rating, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    content,
    mealId,
    mealName,
    mealThumb,
    rating,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeNote &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.mealId == this.mealId &&
          other.mealName == this.mealName &&
          other.mealThumb == this.mealThumb &&
          other.rating == this.rating &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RecipeNotesCompanion extends UpdateCompanion<RecipeNote> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> content;
  final Value<String?> mealId;
  final Value<String?> mealName;
  final Value<String?> mealThumb;
  final Value<int?> rating;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RecipeNotesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.mealId = const Value.absent(),
    this.mealName = const Value.absent(),
    this.mealThumb = const Value.absent(),
    this.rating = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RecipeNotesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String content,
    this.mealId = const Value.absent(),
    this.mealName = const Value.absent(),
    this.mealThumb = const Value.absent(),
    this.rating = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : title = Value(title),
       content = Value(content);
  static Insertable<RecipeNote> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? mealId,
    Expression<String>? mealName,
    Expression<String>? mealThumb,
    Expression<int>? rating,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (mealId != null) 'meal_id': mealId,
      if (mealName != null) 'meal_name': mealName,
      if (mealThumb != null) 'meal_thumb': mealThumb,
      if (rating != null) 'rating': rating,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RecipeNotesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? content,
    Value<String?>? mealId,
    Value<String?>? mealName,
    Value<String?>? mealThumb,
    Value<int?>? rating,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return RecipeNotesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      mealId: mealId ?? this.mealId,
      mealName: mealName ?? this.mealName,
      mealThumb: mealThumb ?? this.mealThumb,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (mealId.present) {
      map['meal_id'] = Variable<String>(mealId.value);
    }
    if (mealName.present) {
      map['meal_name'] = Variable<String>(mealName.value);
    }
    if (mealThumb.present) {
      map['meal_thumb'] = Variable<String>(mealThumb.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeNotesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('mealId: $mealId, ')
          ..write('mealName: $mealName, ')
          ..write('mealThumb: $mealThumb, ')
          ..write('rating: $rating, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StorageEntriesTable storageEntries = $StorageEntriesTable(this);
  late final $BookmarkedMealsTable bookmarkedMeals = $BookmarkedMealsTable(
    this,
  );
  late final $RecipeNotesTable recipeNotes = $RecipeNotesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    storageEntries,
    bookmarkedMeals,
    recipeNotes,
  ];
}

typedef $$StorageEntriesTableCreateCompanionBuilder =
    StorageEntriesCompanion Function({
      required String key,
      required String value,
      required String type,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$StorageEntriesTableUpdateCompanionBuilder =
    StorageEntriesCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<String> type,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$StorageEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $StorageEntriesTable> {
  $$StorageEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StorageEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $StorageEntriesTable> {
  $$StorageEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StorageEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StorageEntriesTable> {
  $$StorageEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StorageEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StorageEntriesTable,
          StorageEntry,
          $$StorageEntriesTableFilterComposer,
          $$StorageEntriesTableOrderingComposer,
          $$StorageEntriesTableAnnotationComposer,
          $$StorageEntriesTableCreateCompanionBuilder,
          $$StorageEntriesTableUpdateCompanionBuilder,
          (
            StorageEntry,
            BaseReferences<_$AppDatabase, $StorageEntriesTable, StorageEntry>,
          ),
          StorageEntry,
          PrefetchHooks Function()
        > {
  $$StorageEntriesTableTableManager(
    _$AppDatabase db,
    $StorageEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$StorageEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$StorageEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$StorageEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StorageEntriesCompanion(
                key: key,
                value: value,
                type: type,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required String type,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StorageEntriesCompanion.insert(
                key: key,
                value: value,
                type: type,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StorageEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StorageEntriesTable,
      StorageEntry,
      $$StorageEntriesTableFilterComposer,
      $$StorageEntriesTableOrderingComposer,
      $$StorageEntriesTableAnnotationComposer,
      $$StorageEntriesTableCreateCompanionBuilder,
      $$StorageEntriesTableUpdateCompanionBuilder,
      (
        StorageEntry,
        BaseReferences<_$AppDatabase, $StorageEntriesTable, StorageEntry>,
      ),
      StorageEntry,
      PrefetchHooks Function()
    >;
typedef $$BookmarkedMealsTableCreateCompanionBuilder =
    BookmarkedMealsCompanion Function({
      required String idMeal,
      Value<String?> strMeal,
      Value<String?> strCategory,
      Value<String?> strArea,
      Value<String?> strInstructions,
      Value<String?> strMealThumb,
      Value<String?> strTags,
      Value<String?> ingredientsJson,
      Value<DateTime> bookmarkedAt,
      Value<int> rowid,
    });
typedef $$BookmarkedMealsTableUpdateCompanionBuilder =
    BookmarkedMealsCompanion Function({
      Value<String> idMeal,
      Value<String?> strMeal,
      Value<String?> strCategory,
      Value<String?> strArea,
      Value<String?> strInstructions,
      Value<String?> strMealThumb,
      Value<String?> strTags,
      Value<String?> ingredientsJson,
      Value<DateTime> bookmarkedAt,
      Value<int> rowid,
    });

class $$BookmarkedMealsTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarkedMealsTable> {
  $$BookmarkedMealsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get idMeal => $composableBuilder(
    column: $table.idMeal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get strMeal => $composableBuilder(
    column: $table.strMeal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get strCategory => $composableBuilder(
    column: $table.strCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get strArea => $composableBuilder(
    column: $table.strArea,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get strInstructions => $composableBuilder(
    column: $table.strInstructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get strMealThumb => $composableBuilder(
    column: $table.strMealThumb,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get strTags => $composableBuilder(
    column: $table.strTags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ingredientsJson => $composableBuilder(
    column: $table.ingredientsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get bookmarkedAt => $composableBuilder(
    column: $table.bookmarkedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookmarkedMealsTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarkedMealsTable> {
  $$BookmarkedMealsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get idMeal => $composableBuilder(
    column: $table.idMeal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get strMeal => $composableBuilder(
    column: $table.strMeal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get strCategory => $composableBuilder(
    column: $table.strCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get strArea => $composableBuilder(
    column: $table.strArea,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get strInstructions => $composableBuilder(
    column: $table.strInstructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get strMealThumb => $composableBuilder(
    column: $table.strMealThumb,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get strTags => $composableBuilder(
    column: $table.strTags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ingredientsJson => $composableBuilder(
    column: $table.ingredientsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get bookmarkedAt => $composableBuilder(
    column: $table.bookmarkedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookmarkedMealsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarkedMealsTable> {
  $$BookmarkedMealsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get idMeal =>
      $composableBuilder(column: $table.idMeal, builder: (column) => column);

  GeneratedColumn<String> get strMeal =>
      $composableBuilder(column: $table.strMeal, builder: (column) => column);

  GeneratedColumn<String> get strCategory => $composableBuilder(
    column: $table.strCategory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get strArea =>
      $composableBuilder(column: $table.strArea, builder: (column) => column);

  GeneratedColumn<String> get strInstructions => $composableBuilder(
    column: $table.strInstructions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get strMealThumb => $composableBuilder(
    column: $table.strMealThumb,
    builder: (column) => column,
  );

  GeneratedColumn<String> get strTags =>
      $composableBuilder(column: $table.strTags, builder: (column) => column);

  GeneratedColumn<String> get ingredientsJson => $composableBuilder(
    column: $table.ingredientsJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get bookmarkedAt => $composableBuilder(
    column: $table.bookmarkedAt,
    builder: (column) => column,
  );
}

class $$BookmarkedMealsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarkedMealsTable,
          BookmarkedMeal,
          $$BookmarkedMealsTableFilterComposer,
          $$BookmarkedMealsTableOrderingComposer,
          $$BookmarkedMealsTableAnnotationComposer,
          $$BookmarkedMealsTableCreateCompanionBuilder,
          $$BookmarkedMealsTableUpdateCompanionBuilder,
          (
            BookmarkedMeal,
            BaseReferences<
              _$AppDatabase,
              $BookmarkedMealsTable,
              BookmarkedMeal
            >,
          ),
          BookmarkedMeal,
          PrefetchHooks Function()
        > {
  $$BookmarkedMealsTableTableManager(
    _$AppDatabase db,
    $BookmarkedMealsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$BookmarkedMealsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$BookmarkedMealsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$BookmarkedMealsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> idMeal = const Value.absent(),
                Value<String?> strMeal = const Value.absent(),
                Value<String?> strCategory = const Value.absent(),
                Value<String?> strArea = const Value.absent(),
                Value<String?> strInstructions = const Value.absent(),
                Value<String?> strMealThumb = const Value.absent(),
                Value<String?> strTags = const Value.absent(),
                Value<String?> ingredientsJson = const Value.absent(),
                Value<DateTime> bookmarkedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookmarkedMealsCompanion(
                idMeal: idMeal,
                strMeal: strMeal,
                strCategory: strCategory,
                strArea: strArea,
                strInstructions: strInstructions,
                strMealThumb: strMealThumb,
                strTags: strTags,
                ingredientsJson: ingredientsJson,
                bookmarkedAt: bookmarkedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String idMeal,
                Value<String?> strMeal = const Value.absent(),
                Value<String?> strCategory = const Value.absent(),
                Value<String?> strArea = const Value.absent(),
                Value<String?> strInstructions = const Value.absent(),
                Value<String?> strMealThumb = const Value.absent(),
                Value<String?> strTags = const Value.absent(),
                Value<String?> ingredientsJson = const Value.absent(),
                Value<DateTime> bookmarkedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookmarkedMealsCompanion.insert(
                idMeal: idMeal,
                strMeal: strMeal,
                strCategory: strCategory,
                strArea: strArea,
                strInstructions: strInstructions,
                strMealThumb: strMealThumb,
                strTags: strTags,
                ingredientsJson: ingredientsJson,
                bookmarkedAt: bookmarkedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookmarkedMealsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarkedMealsTable,
      BookmarkedMeal,
      $$BookmarkedMealsTableFilterComposer,
      $$BookmarkedMealsTableOrderingComposer,
      $$BookmarkedMealsTableAnnotationComposer,
      $$BookmarkedMealsTableCreateCompanionBuilder,
      $$BookmarkedMealsTableUpdateCompanionBuilder,
      (
        BookmarkedMeal,
        BaseReferences<_$AppDatabase, $BookmarkedMealsTable, BookmarkedMeal>,
      ),
      BookmarkedMeal,
      PrefetchHooks Function()
    >;
typedef $$RecipeNotesTableCreateCompanionBuilder =
    RecipeNotesCompanion Function({
      Value<int> id,
      required String title,
      required String content,
      Value<String?> mealId,
      Value<String?> mealName,
      Value<String?> mealThumb,
      Value<int?> rating,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$RecipeNotesTableUpdateCompanionBuilder =
    RecipeNotesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> content,
      Value<String?> mealId,
      Value<String?> mealName,
      Value<String?> mealThumb,
      Value<int?> rating,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$RecipeNotesTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeNotesTable> {
  $$RecipeNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealId => $composableBuilder(
    column: $table.mealId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealName => $composableBuilder(
    column: $table.mealName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealThumb => $composableBuilder(
    column: $table.mealThumb,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecipeNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeNotesTable> {
  $$RecipeNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealId => $composableBuilder(
    column: $table.mealId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealName => $composableBuilder(
    column: $table.mealName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealThumb => $composableBuilder(
    column: $table.mealThumb,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipeNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeNotesTable> {
  $$RecipeNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get mealId =>
      $composableBuilder(column: $table.mealId, builder: (column) => column);

  GeneratedColumn<String> get mealName =>
      $composableBuilder(column: $table.mealName, builder: (column) => column);

  GeneratedColumn<String> get mealThumb =>
      $composableBuilder(column: $table.mealThumb, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RecipeNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeNotesTable,
          RecipeNote,
          $$RecipeNotesTableFilterComposer,
          $$RecipeNotesTableOrderingComposer,
          $$RecipeNotesTableAnnotationComposer,
          $$RecipeNotesTableCreateCompanionBuilder,
          $$RecipeNotesTableUpdateCompanionBuilder,
          (
            RecipeNote,
            BaseReferences<_$AppDatabase, $RecipeNotesTable, RecipeNote>,
          ),
          RecipeNote,
          PrefetchHooks Function()
        > {
  $$RecipeNotesTableTableManager(_$AppDatabase db, $RecipeNotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RecipeNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$RecipeNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$RecipeNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> mealId = const Value.absent(),
                Value<String?> mealName = const Value.absent(),
                Value<String?> mealThumb = const Value.absent(),
                Value<int?> rating = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RecipeNotesCompanion(
                id: id,
                title: title,
                content: content,
                mealId: mealId,
                mealName: mealName,
                mealThumb: mealThumb,
                rating: rating,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String content,
                Value<String?> mealId = const Value.absent(),
                Value<String?> mealName = const Value.absent(),
                Value<String?> mealThumb = const Value.absent(),
                Value<int?> rating = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RecipeNotesCompanion.insert(
                id: id,
                title: title,
                content: content,
                mealId: mealId,
                mealName: mealName,
                mealThumb: mealThumb,
                rating: rating,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecipeNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeNotesTable,
      RecipeNote,
      $$RecipeNotesTableFilterComposer,
      $$RecipeNotesTableOrderingComposer,
      $$RecipeNotesTableAnnotationComposer,
      $$RecipeNotesTableCreateCompanionBuilder,
      $$RecipeNotesTableUpdateCompanionBuilder,
      (
        RecipeNote,
        BaseReferences<_$AppDatabase, $RecipeNotesTable, RecipeNote>,
      ),
      RecipeNote,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StorageEntriesTableTableManager get storageEntries =>
      $$StorageEntriesTableTableManager(_db, _db.storageEntries);
  $$BookmarkedMealsTableTableManager get bookmarkedMeals =>
      $$BookmarkedMealsTableTableManager(_db, _db.bookmarkedMeals);
  $$RecipeNotesTableTableManager get recipeNotes =>
      $$RecipeNotesTableTableManager(_db, _db.recipeNotes);
}
