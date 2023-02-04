import 'package:built_collection/built_collection.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';

const createTableSQL = '''
      CREATE TABLE day(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        rating BOOLEAN NOT NULL,
        date INTEGER UNIQUE NOT NULL,
        didLearnNew BOOLEAN NOT NULL
      )
    ''';

class DataStorage {
  static Future<void> createDayDataTable(final sql.Database database) async {
    await database.execute(createTableSQL);
  }

  static Future<sql.Database> database() async {
    final String databasePath = await sql.getDatabasesPath();
    final String path = join(databasePath, 'rateaday.db');
    return await sql.openDatabase(
      path,
      version: 1,
      onCreate: (final sql.Database database, int version) async {
        await createDayDataTable(database);
      },
    );
  }

  static Future<void> assessDay(
    final Rating rating,
    final bool didLearnNew,
    final DateTime date,
  ) async {
    final int startOfDay = DateTimeUtil.getStartOfDayEpochMilliseconds(date);
    final bool didLearn = didLearnNew;
    final data = {
      'date': startOfDay,
      'rating': rating == Rating.HAPPY
          ? 'TRUE'
          : rating == Rating.UNHAPPY
              ? 'FALSE'
              : 'NULL',
      'didLearnNew': didLearn ? 'TRUE' : 'FALSE',
    };

    final database = await DataStorage.database();
    final existingEntries =
        await database.query('day', where: "date = ?", whereArgs: [startOfDay]);

    if (existingEntries.isNotEmpty) {
      await database
          .update('day', data, where: 'date = ?', whereArgs: [startOfDay]);
    } else {
      await database.insert('day', data);
    }
  }

  static Future<BuiltMap<int, DayData>> fetchDayDataByDate(
      final DateTime dateTime) async {
    final DateTime monthBegins = DateTime(dateTime.year, dateTime.month, 1);
    final DateTime nextMonthBegins = DateTimeUtil.nextMonthStart(dateTime);
    final database = await DataStorage.database();
    final List<Map<String, Object?>> dayData = await database.query('day',
        columns: ['rating', 'didLearnNew', 'date'],
        where: 'date >= ? AND date < ?',
        whereArgs: [
          monthBegins.millisecondsSinceEpoch,
          nextMonthBegins.millisecondsSinceEpoch,
        ]);
    return DayDataOperations.extractDataFromRowData(dayData);
  }

  static Future<void> emptyDatabase(final sql.Database database) async {
    await database.execute('''DELETE FROM day''');
  }
}
