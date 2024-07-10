// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ToDoDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $ToDoDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $ToDoDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $ToDoDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<ToDoDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorToDoDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ToDoDatabaseBuilderContract databaseBuilder(String name) =>
      _$ToDoDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ToDoDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$ToDoDatabaseBuilder(null);
}

class _$ToDoDatabaseBuilder implements $ToDoDatabaseBuilderContract {
  _$ToDoDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $ToDoDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $ToDoDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<ToDoDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ToDoDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ToDoDatabase extends ToDoDatabase {
  _$ToDoDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ToDoDAO? _getDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ToDoItem` (`itemName` TEXT NOT NULL, `id` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ToDoDAO get getDAO {
    return _getDAOInstance ??= _$ToDoDAO(database, changeListener);
  }
}

class _$ToDoDAO extends ToDoDAO {
  _$ToDoDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _toDoItemInsertionAdapter = InsertionAdapter(
            database,
            'ToDoItem',
            (ToDoItem item) =>
                <String, Object?>{'itemName': item.itemName, 'id': item.id}),
        _toDoItemUpdateAdapter = UpdateAdapter(
            database,
            'ToDoItem',
            ['id'],
            (ToDoItem item) =>
                <String, Object?>{'itemName': item.itemName, 'id': item.id}),
        _toDoItemDeletionAdapter = DeletionAdapter(
            database,
            'ToDoItem',
            ['id'],
            (ToDoItem item) =>
                <String, Object?>{'itemName': item.itemName, 'id': item.id});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ToDoItem> _toDoItemInsertionAdapter;

  final UpdateAdapter<ToDoItem> _toDoItemUpdateAdapter;

  final DeletionAdapter<ToDoItem> _toDoItemDeletionAdapter;

  @override
  Future<List<ToDoItem>> getAllToDoItems() async {
    return _queryAdapter.queryList('SELECT * FROM ToDoItem',
        mapper: (Map<String, Object?> row) =>
            ToDoItem(row['id'] as int, row['itemName'] as String));
  }

  @override
  Future<void> insertToDo(ToDoItem itm) async {
    await _toDoItemInsertionAdapter.insert(itm, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateToDoItem(ToDoItem itm) {
    return _toDoItemUpdateAdapter.updateAndReturnChangedRows(
        itm, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteToDo(ToDoItem itm) {
    return _toDoItemDeletionAdapter.deleteAndReturnChangedRows(itm);
  }
}
