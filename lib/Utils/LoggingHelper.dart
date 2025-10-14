import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'Helper.dart';

Future<String> getDbPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return '${directory.path}/logs.db';
}
getDb(){

}
Future<Database> getDatabaseLogger() async {
  final path = await getDbPath();
  return await openDatabase(
    path,
    version: 2,
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE logs(id INTEGER PRIMARY KEY, person_id INTEGER DEFAULT NULL, event TEXT DEFAULT NULL, item_id TEXT DEFAULT NULL, item_name TEXT DEFAULT NULL, message TEXT DEFAULT NULL, item_type TEXT DEFAULT NULL, extras TEXT DEFAULT NULL, platform TEXT DEFAULT NULL, app_version TEXT DEFAULT NULL, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP);'
      );
      await db.execute(
        'CREATE TABLE lesson_logs(id INTEGER PRIMARY KEY, person_id INTEGER DEFAULT NULL, lesson_id TEXT DEFAULT NULL, watch_time_in_seconds INTEGER DEFAULT NULL, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP);'
      );
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion == 1) {
        // Delete all tables and recreate
        await db.execute('DROP TABLE IF EXISTS logs;');
        await db.execute('DROP TABLE IF EXISTS lesson_logs;');
        await db.execute(
          'CREATE TABLE logs(id INTEGER PRIMARY KEY, person_id INTEGER DEFAULT NULL, event TEXT DEFAULT NULL, item_id TEXT DEFAULT NULL, item_name TEXT DEFAULT NULL, message TEXT DEFAULT NULL, item_type TEXT DEFAULT NULL, extras TEXT DEFAULT NULL, platform TEXT DEFAULT NULL, app_version TEXT DEFAULT NULL, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP);'
        );
        await db.execute(
          'CREATE TABLE lesson_logs(id INTEGER PRIMARY KEY, person_id INTEGER DEFAULT NULL, lesson_id TEXT DEFAULT NULL, watch_time_in_seconds INTEGER DEFAULT NULL, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP);'
        );
      }
    },
  );
}

Future<void> storeWatchTime(int lesson_id, int watch_time_in_seconds, {person_id}) async {

  if (kIsWeb) {
    return;
  }

  if (watch_time_in_seconds == 0) {
    return;
  }

  if (person_id == null) {
    person_id = (await SharedPreferences.getInstance()).getString("person_id");
  }

  final database = await getDatabaseLogger();

  // Check if record exists
  final List<Map<String, dynamic>> existing = await database.query(
    'lesson_logs',
    where: 'person_id = ? AND lesson_id = ?',
    whereArgs: [person_id, lesson_id],
  );

  if (existing.isEmpty) {
    await database.insert('lesson_logs', {
      'person_id': person_id,
      'lesson_id': lesson_id,
      'watch_time_in_seconds': watch_time_in_seconds,
      'timestamp': DateTime.now().toIso8601String(),
    });
    Logger().w("Inserted new watch time for lesson: $lesson_id - $watch_time_in_seconds (s)");
  } else {
    await database.update(
      'lesson_logs',
      {
        'watch_time_in_seconds': watch_time_in_seconds,
        'timestamp': DateTime.now().toIso8601String(),
      },

      where: 'person_id = ? AND lesson_id = ?',
      whereArgs: [person_id, lesson_id],
    );
    Logger().w("Updated watch time for lesson: $lesson_id - $watch_time_in_seconds (s)");
  }

  storeLog("watchTime", message: "$watch_time_in_seconds seconds", itemName: "$lesson_id");
}

Future<int> getWatchTime( int lesson_id, {person_id} ) async {
  if (kIsWeb) {
    return 0;
  }
  if (person_id == null) {
    person_id = (await SharedPreferences.getInstance()).getString("person_id");
  }

  var database = await getDatabaseLogger();

  final List<Map<String, dynamic>> results = await database.query(
    'lesson_logs',
    where: 'person_id = ? AND lesson_id = ?',
    whereArgs: [person_id, lesson_id],
  );

  if (results.isNotEmpty) {
    return results[0]['watch_time_in_seconds'];
  } else {
    return 0;
  }
}

Future<void> storeLog(event, { itemId, itemName, itemType, extras, message}) async {
  if (kIsWeb) {
    return;
  }

  var person_id = (await SharedPreferences.getInstance() ).getString("person_id");

  var platform = await getPlatform();
  var app_version = await getAppVersion();

  final database = await getDatabaseLogger();

  await database.insert('logs', {
    'message': message,
    'person_id': person_id,
    'event': event,
    'item_id': itemId,
    'item_name': itemName,
    'item_type': itemType,
    'extras': extras,
    'platform': platform,
    'app_version': app_version,
    'timestamp': DateTime.now().toIso8601String(),
  });

}

Future<int?> getLogsCount() async {
  if (kIsWeb) {
    return 0;
  }
  final database = await getDatabaseLogger();

  final count = Sqflite.firstIntValue(
    await database.rawQuery('SELECT COUNT(*) FROM logs'),
  );

  return count;
}

//getLogsJsonString
Future<List<Map<String, dynamic>>> getLogsJsonString() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/logs.db';
  final database = await openDatabase(path, version: 1);
  final List<Map<String, dynamic>> logs = await database.query('logs');
  //return jsonEncode(logs);
  return (logs);
}

//clearLogs
Future<void> clearLogs() async {
  if (kIsWeb) {
    return;
  }
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/logs.db';
  final database = await openDatabase(path, version: 1);
  await database.delete('logs');
}