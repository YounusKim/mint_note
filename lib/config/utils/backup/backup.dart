import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mint_note/config/routes/nav_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mint_note/data/repositories/sql/sql_helper.dart';
import 'package:mint_note/presentation/provider/folder_list.dart';
import 'package:mint_note/presentation/provider/note_list.dart';
import 'package:mint_note/presentation/provider/synopsis_list.dart';
import 'package:mint_note/presentation/provider/memo_list.dart';
import 'package:mint_note/presentation/provider/project_list.dart';

class BackupManager {
  final SqlHelper dbRepository;
  BackupManager(this.dbRepository);

  /// ✅ 데이터베이스 백업
  Future<String> backupDatabaseFile(BuildContext context) async {
    try {
      String dbPath = await dbRepository.getDatabasePath();
      File dbFile = File(dbPath);

      if (!await dbFile.exists()) {
        throw Exception('Database file does not exist.');
      }

      String? selectedFilePath = await FilePicker.platform.saveFile(
        dialogTitle: '백업파일을 저장할 경로를 선택하세요',
        fileName: '무림객잔.db',
        type: FileType.custom,
        allowedExtensions: ['db'],
      );

      if (selectedFilePath == null) {
        throw Exception('백업이 취소됐습니다');
      }

      File backupFile = File(selectedFilePath);
      await dbFile.copy(backupFile.path);

      int originalSize = await dbFile.length();
      int backupSize = await backupFile.length();

      if (originalSize == backupSize) {
        print('✅ 데이터베이스 백업 완료! (Size: $backupSize bytes)');
      } else {
        print(
          '⚠️ Backup file size mismatch! Original: $originalSize, Backup: $backupSize',
        );
      }

      return backupFile.path;
    } catch (e) {
      print('백업 오류: $e');
      throw Exception('데이터베이스 백업 실패: $e');
    }
  }

  // # backup code 수정

  // ...
  /// ✅ 데이터베이스 복원
  Future<void> restoreDatabase(String backupPath, BuildContext context) async {
    try {
      String dbPath = await dbRepository.getDatabasePath();

      // 1. 기존 데이터베이스 닫기
      await SqlHelper.instance.closeDatabase();

      // 2. 기존 DB 삭제 및 백업 파일 복사
      File dbFile = File(dbPath);
      if (await dbFile.exists()) {
        await dbFile.delete();
      }
      await File(backupPath).copy(dbPath);

      // 3. DB 다시 열기
      await SqlHelper.instance.database;

      // 4. 🚨 [핵심 수정]: Provider 상태를 강제로 새로고침
      if (context.mounted) {
        // NavigationProvider에서 현재 선택된 장르/프로젝트 ID를 가져옵니다.
        final navigationProvider = Provider.of<NavProvider>(
          context,
          listen: false,
        );

        // ProjectList 상태 새로고침
        // (NavigationProvider가 현재 선택된 genreId를 갖고 있다고 가정)
        await Provider.of<ProjectList>(
          context,
          listen: false,
        ).getProjectByGenre(navigationProvider.genreId);

        // 기타 필요한 상태 관리 Provider도 모두 새로고침 로직을 호출해야 합니다.
        // 예: await Provider.of<FolderList>(context, listen: false).getFolders(navigationProvider.projectId);

        if (context.mounted) {
          await Provider.of<FolderList>(
            context,
            listen: false,
          ).getFolderByProject(navigationProvider.projectId);
        }

        if (context.mounted) {
          await Provider.of<NoteList>(
            context,
            listen: false,
          ).getNoteByFolder(navigationProvider.folderId);
        }

        if (context.mounted) {
          await Provider.of<SynopsisList>(
            context,
            listen: false,
          ).getSynopsisByFolder(navigationProvider.synopsisId);
        }

        if (context.mounted) {
          await Provider.of<MemoList>(
            context,
            listen: false,
          ).getMemoByFolder(navigationProvider.memoId);
        }
      }

      print('✅ 데이터베이스 복원 완료!');
    } catch (e) {
      print('❌ 복원 오류: $e');
      // 복원 실패 시, 안전을 위해 DB를 다시 열고(필요하다면) 상태를 초기화하는 것이 좋습니다.
      await SqlHelper.instance.database;
      // ...
    }
  }

  /// ✅ 데이터 개수 확인
  Future<int> getRecordCount() async {
    String dbPath = await dbRepository.getDatabasePath();
    Database db = await openDatabase(dbPath);

    List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM your_table_name',
    );

    await db.close();
    return result.first['count'] as int;
  }

  /// ✅ 테이블 목록 출력
  Future<void> checkExistingTables() async {
    String dbPath = await dbRepository.getDatabasePath();
    Database db = await openDatabase(dbPath);

    List<Map<String, dynamic>> result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table';",
    );

    await db.close();
    print('📌 현재 존재하는 테이블 목록: ${result.map((e) => e['name']).toList()}');
  }
}
