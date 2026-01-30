import 'package:mint_note/data/models/folder.dart';
import 'package:mint_note/data/repositories/sql/sql_helper.dart';
import 'package:mint_note/data/repositories/sql/sql_table.dart';

class FolderRepo {
  final SqlHelper dbRepo = SqlHelper.instance;

  Future<List<Folder>> getFoldersByProject(String projectId) async {
    final db = await dbRepo.database;
    final result = await db.query(
      SqlTable.folderTableName,
      where: 'projectId = ?',
      whereArgs: [projectId],
    );
    return result.map((e) => Folder.fromMap(e)).toList();
  }

  Future<Folder> getFolderById(String folderId) async {
    final db = await dbRepo.database;
    final folder = await db.query(
      SqlTable.folderTableName,
      where: 'folderId = ?',
      whereArgs: [folderId],
    );
    if (folder.isNotEmpty) {
      return Folder.fromMap(folder.first);
    } else {
      throw Exception("$folderId not found");
    }
  }

  Future<int> addFolder(Folder folders, String projectId) async {
    final db = await dbRepo.database;
    final result = await db.insert(SqlTable.folderTableName, folders.toMap());
    return result;
  }

  Future<int> updatefolder(Folder folder) async {
    final db = await dbRepo.database;
    final result = await db.update(
      SqlTable.folderTableName,
      folder.toMap(),
      where: 'folderId = ?',
      whereArgs: [folder.folderId],
    );
    return result;
  }

  Future<int> deleteFolder(String folderId) async {
    final db = await dbRepo.database;
    int result = await db.delete(
      SqlTable.folderTableName,
      where: 'folderId = ?',
      whereArgs: [folderId],
    );
    return result;
  }
}
