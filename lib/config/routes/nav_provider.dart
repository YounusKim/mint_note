import 'package:flutter/material.dart';
import 'package:mint_note/data/models/folder.dart';
import 'package:mint_note/data/models/note.dart';
import 'package:mint_note/data/models/synopsis.dart';
import 'package:mint_note/data/models/memo.dart';

class NavProvider extends ChangeNotifier {
  String _genreId = '';
  String _genreName = '';

  String _projectId = '';
  String _projectName = '';

  String _folderId = '';
  String _folderName = '';

  String _synopsisId = '';
  String _synopsisName = '';
  String _synopsisContent = '';

  String _noteId = '';
  String _noteName = '';
  String _noteContent = '';

  String _memoId = '';
  String _memoName = '';
  String _memoContent = '';

  bool isGenreSelected = false;
  bool isFolderSelected = false;
  bool isSynopsisSelected = false;
  bool isNoteSelected = false;
  bool isMemoSelected = false;

  Folder? folder;
  Synopsis? synopsis;
  Note? note;
  Memo? memo;

  final DateTime _createdAt = DateTime.now();
  final DateTime _updatedAt = DateTime.now();

  String get genreId => _genreId;
  String get genreName => _genreName;

  String get projectId => _projectId;
  String get projectName => _projectName;

  String get folderId => _folderId;
  String get folderName => _folderName;

  String get synopsisId => _synopsisId;
  String get synopsisName => _synopsisName;
  String get synopsisContent => _synopsisContent;

  String get noteId => _noteId;
  String get noteName => _noteName;
  String get noteContent => _noteContent;

  String get memoId => _memoId;
  String get memoName => _memoName;
  String get memoContent => _memoContent;

  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;

  // genre selection method
  void selectGenre(String genreId, String genreName) {
    _genreId = genreId;
    _genreName = genreName;
    isGenreSelected = true;
    notifyListeners();
  }

  void selectFolder(String folderId, String folderName) {
    _folderId = folderId;
    _folderName = folderName;
    isFolderSelected = true;
    notifyListeners();
  }

  void selectSynopsis(
    String synopsisId,
    String synopsisName,
    String synopsisContent,
  ) {
    _synopsisId = synopsisId;
    _synopsisName = synopsisName;
    _synopsisName = synopsisContent;
    notifyListeners();
  }

  void selectNote(String noteId, String noteName, [String noteContent = '']) {
    _noteId = noteId;
    _noteName = noteName;
    _noteContent = noteContent;
    isNoteSelected = true;
    notifyListeners();
  }

  void selectMemo(String memoId, String memoName, [String memoContent = '']) {
    _noteId = memoId;
    _noteName = memoName;
    _noteContent = memoContent;
    isNoteSelected = true;
    notifyListeners();
  }

  void clearFolder() {
    _folderId = '';
    _folderName = '';
    isFolderSelected = false;
    notifyListeners();
  }

  void clearSynopsis() {
    _synopsisId = '';
    _synopsisName = '';
    _synopsisContent = '';
    notifyListeners();
  }

  // ✅ 폴더 바뀔 때 호출
  void clearNote() {
    _noteId = '';
    _noteName = '';
    _noteContent = '';
    isNoteSelected = false;
    notifyListeners();
  }

  void clearMemo() {
    _memoId = '';
    _memoName = '';
    _memoContent = '';
    notifyListeners();
  }

  void goToFolder(String projectId, String projectName) {
    _projectId = projectId;
    _projectName = projectName;
    notifyListeners(); // Notify listeners about state changes
  }

  // synopsis category
  void goToWork(String folderId, String folerName) {
    _folderId = folderId;
    _folderName = folerName;
    notifyListeners();
  }

  void goToNoteEditor(String noteId, String noteName, String noteContent) {
    _noteId = noteId;
    _noteName = noteName;
    _noteContent = noteContent;
    notifyListeners();
  }

  void goToMemoEditor(String memoId, String memoName, String memoContent) {
    _memoId = memoId;
    _memoName = memoName;
    _memoContent = memoContent;
    notifyListeners();
  }

  // leftNavi 네비게이션용 키
  final GlobalKey<NavigatorState> leftNaviKey = GlobalKey<NavigatorState>();

  // novelNavi 네비게이션용 키
  final GlobalKey<NavigatorState> noteNaviKey = GlobalKey<NavigatorState>();

  // rightNavi 네비게이션용 키
  final GlobalKey<NavigatorState> rightNaviKey = GlobalKey<NavigatorState>();
}
