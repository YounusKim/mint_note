import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mint_note/config/utils/backup/backup.dart';
import 'package:mint_note/data/repositories/sql/sql_helper.dart';

class HeaderButtonWidget extends StatefulWidget {
  const HeaderButtonWidget({super.key});

  @override
  State<HeaderButtonWidget> createState() => _HeaderButtonWidgetState();
}

class _HeaderButtonWidgetState extends State<HeaderButtonWidget> {
  final SqlHelper dbRepository = SqlHelper.instance;
  late final BackupManager backupManager;

  @override
  void initState() {
    backupManager = BackupManager(dbRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextButton.icon(
                onPressed: () async {
                  try {
                    String filePath = await backupManager.backupDatabaseFile(
                      context,
                    );
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Database backup completed!: $filePath'),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Backup error: $e')));
                  }
                },
                label: Text(
                  '백업',
                  style: TextStyle(
                    fontFamily: 'NanumBarunGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextButton.icon(
                onPressed: () async {
                  try {
                    // 파일 선택기에서 백업 파일 경로를 선택
                    String? backupFilePath = await FilePicker.platform
                        .pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['db'],
                        )
                        .then((result) => result?.files.single.path);
                    // 백업 경로를 restoreDatabase에 전달
                    if (!context.mounted) return;
                    await backupManager.restoreDatabase(
                      backupFilePath!,
                      context,
                    );
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Database restore failed!')),
                    );
                  }
                },
                label: Text(
                  '복원',
                  style: TextStyle(
                    fontFamily: 'NanumBarunGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
