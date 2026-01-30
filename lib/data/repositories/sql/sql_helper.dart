import 'dart:io';
import 'package:mint_note/data/repositories/sql/sql_table.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqlHelper {
  SqlHelper._privateConstructor();
  static final SqlHelper instance = SqlHelper._privateConstructor();

  final _databaseName = 'MintNote.db';
  final _databaseVersion = 1;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    try {
      _database = await _initDB();
    } catch (e) {
      print('⚠️ Failed to open database: $e');
      print('🛠  Deleting DB file and retrying.');

      String dbPath = await getDatabasePath();
      File(dbPath).deleteSync();

      _database = await _initDB();
    }

    return _database!;
  }

  /// ✅ DB 경로를 항상 같은 방식으로 가져오기 위한 메서드
  Future<String> getDatabasePath() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return join(documentsDirectory.path, _databaseName);
  }

  Future<Database> _initDB() async {
    String path = await getDatabasePath();
    return await openDatabase(
      path,
      version: _databaseVersion,
      // [가장 중요] 데이터베이스 연결 설정 시 PRAGMA 쿼리 실행
      onConfigure: (db) async {
        // 외래 키 제약 조건을 활성화합니다.
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute(SqlTable.genreTable);
        await db.execute(SqlTable.projectTable);
        await db.execute(SqlTable.folderTable);
        await db.execute(SqlTable.synopsisTable);
        await db.execute(SqlTable.noteTable);
        await db.execute(SqlTable.memoTable);
      },
    );
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
