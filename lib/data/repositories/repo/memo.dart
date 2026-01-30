import 'package:mint_note/data/models/memo.dart';
import 'package:mint_note/data/repositories/sql/sql_helper.dart';
import 'package:mint_note/data/repositories/sql/sql_table.dart';

class MemoRepo {
  final SqlHelper dbRepo = SqlHelper.instance;

  Future<List<Memo>> getMemosByFolder(String folderId) async {
    final db = await dbRepo.database;
    final result = await db.query(
      SqlTable.noteTableName,
      where: 'folderId = ?',
      whereArgs: [folderId],
    );
    return result.map((e) => Memo.fromMap(e)).toList();
  }

  Future<Memo> getMemoById(String memoId) async {
    final db = await dbRepo.database;
    final memo = await db.query(
      SqlTable.memoTableName,
      where: 'memoId = ?',
      whereArgs: [memoId],
    );
    if (memo.isNotEmpty) {
      return Memo.fromMap(memo.first);
    } else {
      throw Exception("$memo not found");
    }
  }

  Future<int> addMemo(
    Memo memo,
    DateTime createdAt,
    DateTime updatedAt,
    String folderId,
    String projectId,
  ) async {
    final newId = DateTime.now().toIso8601String();
    final newMemo = Memo(
      memoId: newId,
      memoName: '메모',
      memoContent: '여기에 본문을 입력하세요...',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      folderId: folderId,
      projectId: projectId,
    );
    final db = await dbRepo.database;
    return await db.insert(SqlTable.memoTableName, newMemo.toMap());
  }

  Future<int> updateMemo(Memo memo) async {
    final db = await dbRepo.database;
    final result = await db.update(
      SqlTable.memoTableName, // note 테이블 이름
      memo.toMap(), // 수정할 내용
      where: 'memoId = ?', // 어떤 note를 수정할지 지정
      whereArgs: [memo.memoId], // noteId를 기준으로 업데이트
    );
    return result;
  }

  Future<int> deleteMemo(String memoId) async {
    final db = await dbRepo.database;
    int result = await db.delete(
      SqlTable.memoTableName,
      where: 'memoId = ?',
      whereArgs: [memoId],
    );
    return result;
  }
}
