import 'package:mint_note/data/models/note.dart';
import 'package:mint_note/data/repositories/sql/sql_helper.dart';
import 'package:mint_note/data/repositories/sql/sql_table.dart';

class NoteRepo {
  final SqlHelper dbRepo = SqlHelper.instance;

  Future<List<Note>> getNotesByFolder(String folderId) async {
    final db = await dbRepo.database;
    final result = await db.query(
      SqlTable.noteTableName,
      where: 'folderId = ?',
      whereArgs: [folderId],
    );
    return result.map((e) => Note.fromMap(e)).toList();
  }

  Future<Note> getNoteById(String noteId) async {
    final db = await dbRepo.database;
    final note = await db.query(
      SqlTable.noteTableName,
      where: 'noteId = ?',
      whereArgs: [noteId],
    );
    if (note.isNotEmpty) {
      return Note.fromMap(note.first);
    } else {
      throw Exception("$noteId not found");
    }
  }

  Future<int> addNote(
    Note note,
    DateTime createdAt,
    DateTime updatedAt,
    String folderId,
    String projectId,
  ) async {
    final newId = DateTime.now().toIso8601String();
    final newNote = Note(
      noteId: newId,
      noteName: '노트',
      noteContent: '여기에 본문을 입력하세요...',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      folderId: folderId,
      projectId: projectId,
    );
    final db = await dbRepo.database;
    return await db.insert(SqlTable.noteTableName, newNote.toMap());
  }

  Future<int> updateNote(Note note) async {
    final db = await dbRepo.database;
    final result = await db.update(
      SqlTable.noteTableName,
      note.toMap(),
      where: 'noteId = ?',
      whereArgs: [note.noteId],
    );
    return result;
  }

  Future<int> deleteNote(String noteId) async {
    final db = await dbRepo.database;
    int result = await db.delete(
      SqlTable.noteTableName,
      where: 'noteId = ?',
      whereArgs: [noteId],
    );
    return result;
  }
}
