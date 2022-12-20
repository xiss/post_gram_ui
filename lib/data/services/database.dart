import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart';
import 'package:post_gram_ui/domain/models/comment/comment.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:post_gram_ui/domain/exceptions.dart';
import 'package:post_gram_ui/domain/models/attachment/avatar.dart';
import 'package:post_gram_ui/domain/models/attachment/post_content.dart';
import 'package:post_gram_ui/domain/models/db_model_base.dart';
import 'package:post_gram_ui/domain/models/post/post.dart';
import 'package:post_gram_ui/domain/models/subscription/subscription.dart';
import 'package:post_gram_ui/domain/models/user/user.dart';

class Database {
  static const String _databaseName = "postgram_db_v1.3.db";
  static const int _databaseVersion = 1;
  static bool _isInitialized = false;
  static String _path = "";
  static late sqflite.Database _database;
  static final Database instance = Database._();

  Database._();

  static Future initialize() async {
    if (!_isInitialized) {
      String dbPath = await sqflite.getDatabasesPath();
      _path = join(dbPath, _databaseName);
      _database = await sqflite.openDatabase(
        _path,
        version: _databaseVersion,
        onCreate: _createDatabase,
      );
      _isInitialized = true;
    }
  }

  static Future _createDatabase(sqflite.Database database, int version) async {
    String initScript =
        await rootBundle.loadString('assets/database_initialize.sql');

    initScript.split(';').forEach((element) async {
      if (element.isNotEmpty) {
        await database.execute(element);
      }
    });
  }

  static final _factories = <Type, Function(Map<String, dynamic> map)>{
    User: (map) => User.fromMap(map),
    Avatar: (map) => Avatar.fromMap(map),
    Post: (map) => Post.fromMap(map),
    Subscription: ((map) => Subscription.fromMap(map)),
    PostContent: ((map) => PostContent.fromMap(map)),
  };

  String _dbName(Type type) {
    if (type == DbModelBase) {
      throw InnerPostGramException("Type $type must inherit DbModelBase");
    }
    return "t_${type}s";
  }

//TODO Думаю нужно то что ниже убрать в репозиторий который будет реализовывать работу с каждой из таблиц отдельно
  Future<Iterable<T>> getRange<T extends DbModelBase>(
      {Map<String, dynamic>? whereMap, int? take, int? skip}) async {
    Iterable<Map<String, dynamic>> query;

    if (whereMap != null) {
      List<String> whereBuilder = <String>[];
      List whereArgs = <dynamic>[];
      whereMap.forEach((key, value) {
        if (value is Iterable<dynamic>) {
          whereBuilder
              .add("$key IN (${List.filled(value.length, '?').join(',')})");
          whereArgs.addAll(value.map((e) => "$e"));
        } else {
          whereBuilder.add("$key = ?");
          whereArgs.add(value);
        }
      });
      query = await _database.query(_dbName(T),
          offset: skip,
          limit: take,
          where: whereBuilder.join(' and '),
          whereArgs: whereArgs);
    } else {
      query = await _database.query(_dbName(T), offset: skip, limit: take);
    }

    return query.map((e) => _factories[T]!(e)).cast<T>();
  }

  Future<T?> get<T extends DbModelBase>(dynamic id) async {
    List<Map<String, Object?>> res =
        await _database.query(_dbName(T), where: 'id = ? ', whereArgs: [id]);
    return res.isNotEmpty ? _factories[T]!(res.first) : null;
  }

  Future<int> insert<T extends DbModelBase>(T model) async {
    if (model.id == "") {
      Map<String, dynamic> modelmap = model.toMap();
      //modelmap["id"] = const Uuid().v4();
      model = _factories[T]!(modelmap);
    }
    return await _database.insert(_dbName(T), model.toMap());
  }

  Future<int> update<T extends DbModelBase>(T model) async {
    return await _database.update(_dbName(T), model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
  }

  Future<int> delete<T extends DbModelBase>(T model) async {
    return await _database
        .delete(_dbName(T), where: 'id = ?', whereArgs: [model.id]);
  }

  Future<int> createUpdate<T extends DbModelBase>(T model) async {
    var dbItem = await get<T>(model.id);
    var res = dbItem == null ? insert(model) : update(model);
    return await res;
  }

  // Future inserRange<T extends DbModelBase>(Iterable<T> values) async {
  //   var batch = _database.batch();
  //   for (var row in values) {
  //     var data = row.toMap();
  //     // if (row.id == "") {
  //     //   data["id"] = const Uuid().v4();
  //     // }
  //     batch.insert(_dbName(T), data);
  //   }
  //   await batch.commit(noResult: true);
  // }

  Future<void> createUpdateRange<T extends DbModelBase>(Iterable<T> values,
      {bool Function(T oldItem, T newItem)? updateCond}) async {
    var batch = _database.batch();

    for (var row in values) {
      var dbItem = await get<T>(row.id);
      var data = row.toMap();
      // if (row.id == "") {
      //   data["id"] = const Uuid().v4();
      // }

      if (dbItem == null) {
        batch.insert(_dbName(T), data);
      } else if (updateCond == null || updateCond(dbItem, row)) {
        batch.update(_dbName(T), data, where: "id = ?", whereArgs: [row.id]);
      }
    }

    await batch.commit(noResult: true);
  }

  Future<void> clearDatabase() async {
    var batch = _database.batch();
    batch.delete(_dbName(Avatar));
    batch.delete(_dbName(Comment));
    // batch.delete(_dbName(Like));//TODO
    batch.delete(_dbName(PostContent));
    batch.delete(_dbName(Post));
    batch.delete(_dbName(Subscription));
    batch.delete(_dbName(User));
    await batch.commit(noResult: true);
  }
}
