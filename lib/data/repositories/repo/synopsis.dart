import 'package:mint_note/data/models/synopsis.dart';
import 'package:mint_note/data/repositories/sql/sql_helper.dart';
import 'package:mint_note/data/repositories/sql/sql_table.dart';

class SynopsisRepo {
  final SqlHelper dbRepo = SqlHelper.instance;

  Future<List<Synopsis>> getSynopsesByFolder(String folderId) async {
    final db = await dbRepo.database;
    final result = await db.query(
      SqlTable.synopsisTableName,
      where: 'folderId = ?',
      whereArgs: [folderId],
    );
    return result.map((e) => Synopsis.fromMap(e)).toList();
  }

  Future<Synopsis> getSynopsisById(String synopsisId) async {
    final db = await dbRepo.database;
    final synopsis = await db.query(
      SqlTable.synopsisTableName,
      where: 'synopsisId = ?',
      whereArgs: [synopsisId],
    );
    if (synopsis.isNotEmpty) {
      return Synopsis.fromMap(synopsis.first);
    } else {
      throw Exception("$synopsisId not found");
    }
  }

  Future<int> addSynopsis(Synopsis synopses) async {
    final db = await dbRepo.database;
    final result = await db.insert(
      SqlTable.synopsisTableName,
      synopses.toMap(),
    );
    return result;
  }

  Future<int> updateSynopsis(
    String newSynopsisName,
    String newSynopsisNote,
    DateTime updatedAt,
    String synopsisId,
  ) async {
    final db = await dbRepo.database;
    int result = await db.update(
      SqlTable.synopsisTableName,
      {
        'synopsisName': newSynopsisName,
        'synopsisNote': newSynopsisNote,
        'updatedAt': DateTime.now(),
      },
      where: 'synopsisId = ?',
      whereArgs: [synopsisId],
    );
    return result;
  }

  Future<int> deleteSynopsis(String synopsisId) async {
    final db = await dbRepo.database;
    int result = await db.delete(
      SqlTable.synopsisTableName,
      where: 'synopsisId = ?',
      whereArgs: [synopsisId],
    );
    return result;
  }
}
