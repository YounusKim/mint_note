import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mint_note/data/models/memo.dart';
import 'package:mint_note/data/repositories/repo/memo.dart';

class MemoListState extends Equatable {
  final List<Memo> memos;
  const MemoListState({required this.memos});

  factory MemoListState.initial() {
    return MemoListState(memos: []);
  }

  MemoListState copyWith({List<Memo>? memos}) {
    return MemoListState(memos: memos ?? this.memos);
  }

  @override
  String toString() => 'MemoListState(memos: $memos)';

  @override
  List<Object> get props => [memos];
}

class MemoList with ChangeNotifier {
  MemoListState _state = MemoListState.initial();
  MemoListState get state => _state;
  final MemoRepo memoRepo = MemoRepo();

  Future<void> getMemoByFolder(String folderId) async {
    try {
      final currentMemos = await memoRepo.getMemosByFolder(folderId);
      _state = state.copyWith(memos: currentMemos);
      notifyListeners();
    } catch (e) {
      debugPrint("Error getting memos: $e");
      rethrow;
    }
  }

  Future<void> _refreshMemos(String folderId) async {
    final updatedMemos = await memoRepo.getMemosByFolder(folderId);
    _state = state.copyWith(memos: updatedMemos);
    notifyListeners();
  }

  void clear() {
    _state = MemoListState.initial();
    notifyListeners();
  }

  Future<void> addMemo(
    Memo memo,
    String folderId,
    String projectId,
    DateTime createdAt,
    DateTime updatedAt,
  ) async {
    try {
      await memoRepo.addMemo(memo, createdAt, updatedAt, folderId, projectId);
      await _refreshMemos(folderId);
    } catch (e) {
      debugPrint("Error adding memos: $e");
      rethrow;
    }
  }

  Future<void> updateMemo(Memo memo, String memoId) async {
    final oldMemo = await memoRepo.getMemoById(memoId);
    try {
      await memoRepo.updateMemo(memo);
      await _refreshMemos(oldMemo.folderId);
    } catch (e) {
      debugPrint("Error updating memos: $e");
      rethrow;
    }
  }

  Future<void> deleteMemo(String memoId) async {
    final deletedMemo = await memoRepo.getMemoById(memoId);
    final folderId = deletedMemo.folderId;

    try {
      await memoRepo.deleteMemo(memoId);
      await _refreshMemos(folderId);
    } catch (e) {
      debugPrint("Error deleting memos: $e");
      rethrow;
    }
  }
}
