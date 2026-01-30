import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mint_note/drawer.dart';
import 'package:mint_note/memo.dart';
import 'package:mint_note/note.dart';
import 'package:mint_note/presentation/provider/folder_list.dart';
import 'package:mint_note/presentation/provider/memo_list.dart';
import 'package:mint_note/presentation/provider/note_list.dart';
import 'package:mint_note/presentation/provider/project_list.dart';
import 'package:mint_note/presentation/provider/synopsis_list.dart';
import 'package:mint_note/synopsis.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:mint_note/config/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1280, 720),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProjectList()),
        ChangeNotifierProvider(create: (_) => FolderList()),
        ChangeNotifierProvider(create: (_) => SynopsisList()),
        ChangeNotifierProvider(create: (_) => NoteList()),
        ChangeNotifierProvider(create: (_) => MemoList()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MintNote',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const StartPage(),
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
      drawer: DrawerPage(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        title: Text(
          'Mint Note',
          style: TextStyle(
            fontFamily: 'KumarOne',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(flex: 1, child: SynopsisPage()),
            Container(
              width: 10,
              color: AppTheme.lightTheme.colorScheme.secondary,
            ),
            Expanded(flex: 1, child: NotePage()),
            Container(
              width: 10,
              color: AppTheme.lightTheme.colorScheme.secondary,
            ),
            Expanded(flex: 1, child: MemoPage()),
          ],
        ),
      ),
    );
  }
}
