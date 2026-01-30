import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mint_note/data/models/folder.dart';
import 'package:mint_note/data/repositories/repo/folder.dart';

class FolderListState extends Equatable {
  final List<Folder> folders;
  const FolderListState({required this.folders});

  factory FolderListState.initial() {
    return FolderListState(folders: []);
  }

  FolderListState copyWith({List<Folder>? folders}) {
    return FolderListState(folders: folders ?? this.folders);
  }

  @override
  String toString() => 'FolderListState(folders: $folders)';

  @override
  List<Object> get props => [folders];
}

class FolderList with ChangeNotifier {
  FolderListState _state = FolderListState.initial();
  FolderListState get state => _state;
  final FolderRepo folderRepo = FolderRepo();

  Future<void> getFolderByProject(String projectId) async {
    try {
      final currentFolders = await folderRepo.getFoldersByProject(projectId);
      _state = state.copyWith(folders: currentFolders);
      notifyListeners();
    } catch (e) {
      debugPrint("Error getting folders: $e");
      rethrow;
    }
  }

  Future<void> _refreshFolders(String projectId) async {
    final updatedFolders = await folderRepo.getFoldersByProject(projectId);
    _state = state.copyWith(folders: updatedFolders);
    notifyListeners();
  }

  Future<void> addFolder(Folder folder, String projectId) async {
    try {
      await folderRepo.addFolder(folder, projectId);
      await _refreshFolders(folder.projectId);
    } catch (e) {
      debugPrint("Error adding folders: $e");
      rethrow;
    }
  }

  Future<void> updateFolder(Folder folder, String folderId) async {
    final oldFolder = await folderRepo.getFolderById(folderId);
    try {
      await folderRepo.updatefolder(folder);
      await _refreshFolders(oldFolder.projectId);
    } catch (e) {
      debugPrint("Error updating folders: $e");
      rethrow;
    }
  }

  Future<void> deleteFolder(String folderId) async {
    final deletedFolder = await folderRepo.getFolderById(folderId);
    final projectId = deletedFolder.projectId;

    try {
      await folderRepo.deleteFolder(folderId);
      await _refreshFolders(projectId);
    } catch (e) {
      debugPrint("Error deleting folders: $e");
      rethrow;
    }
  }
}
