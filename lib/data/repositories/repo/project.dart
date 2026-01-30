import 'package:mint_note/data/models/genre.dart';
import 'package:mint_note/data/models/project.dart';
import 'package:mint_note/data/repositories/sql/sql_helper.dart';
import 'package:mint_note/data/repositories/sql/sql_table.dart';

class ProjectRepo {
  final SqlHelper dbRepo = SqlHelper.instance;

  Future<List<Project>> getProjectsByGenre(String genreId) async {
    final db = await dbRepo.database;
    final result = await db.query(
      SqlTable.projectTableName,
      where: 'genreId = ?',
      whereArgs: [genreId],
    );
    return result.map((e) => Project.fromMap(e)).toList();
  }

  Future<Project> getProjectById(String projectId) async {
    final db = await dbRepo.database;
    final project = await db.query(
      SqlTable.projectTableName,
      where: 'projectId = ?',
      whereArgs: [projectId],
    );
    if (project.isNotEmpty) {
      return Project.fromMap(project.first);
    } else {
      throw Exception("$projectId not found");
    }
  }

  // Project/Database Repository 파일 내에서 수정

  // 🚨 주의: Genre 모델과 Genre 테이블 이름(SqlTable.genreTableName)이 정의되어 있어야 합니다.
  Future<int> addProject(Project project, Genre genre) async {
    final db = await dbRepo.database;

    // 1. [핵심] Genre 테이블에 해당 ID의 장르가 이미 있는지 확인
    final existingGenre = await db.query(
      SqlTable.genreTableName,
      where: 'genreId = ?',
      whereArgs: [genre.genreId],
    );

    // 2. 장르가 없으면 먼저 삽입하여 외래 키 제약을 충족시킴
    if (existingGenre.isEmpty) {
      // INSERT INTO genre (genreId, genreName, ...) VALUES (?, ?, ...)
      await db.insert(SqlTable.genreTableName, genre.toMap());
    }

    // 3. Project 테이블에 안전하게 삽입
    final result = await db.insert(SqlTable.projectTableName, project.toMap());
    return result;
  }

  Future<int> updateProject(Project project) async {
    final db = await dbRepo.database;
    int result = await db.update(
      SqlTable.projectTableName,
      project.toMap(),
      where: 'projectId = ?',
      whereArgs: [project.projectId],
    );
    return result;
  }

  Future<int> deleteProject(String projectId) async {
    final db = await dbRepo.database;
    int result = await db.delete(
      SqlTable.projectTableName,
      where: 'projectId = ?',
      whereArgs: [projectId],
    );
    return result;
  }
}
