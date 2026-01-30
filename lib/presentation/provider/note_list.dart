import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mint_note/data/models/note.dart';
import 'package:mint_note/data/repositories/repo/note.dart';

class NoteListState extends Equatable {
  final List<Note> notes;
  const NoteListState({required this.notes});

  factory NoteListState.initial() {
    return NoteListState(notes: []);
  }

  NoteListState copyWith({List<Note>? notes}) {
    return NoteListState(notes: notes ?? this.notes);
  }

  @override
  String toString() => 'NoteListState(notes: $notes)';

  @override
  List<Object> get props => [notes];
}

class NoteList with ChangeNotifier {
  NoteListState _state = NoteListState.initial();
  NoteListState get state => _state;
  final NoteRepo noteRepo = NoteRepo();

  Future<void> getNoteByFolder(String folderId) async {
    try {
      final currentNotes = await noteRepo.getNotesByFolder(folderId);
      _state = state.copyWith(notes: currentNotes);
      notifyListeners();
    } catch (e) {
      debugPrint("Error getting notes: $e");
      rethrow;
    }
  }

  Future<void> _refreshNotes(String folderId) async {
    final updatedNotes = await noteRepo.getNotesByFolder(folderId);
    _state = state.copyWith(notes: updatedNotes);
    notifyListeners();
  }

  void clear() {
    _state = NoteListState.initial();
    notifyListeners();
  }

  Future<void> addNote(
    Note note,
    String folderId,
    String projectId,
    DateTime createdAt,
    DateTime updatedAt,
  ) async {
    try {
      await noteRepo.addNote(note, createdAt, updatedAt, folderId, projectId);
      await _refreshNotes(folderId);
    } catch (e) {
      debugPrint("Error adding notes: $e");
      rethrow;
    }
  }

  Future<void> updateNote(Note note, String noteId) async {
    final oldNote = await noteRepo.getNoteById(noteId);
    try {
      await noteRepo.updateNote(note);
      await _refreshNotes(oldNote.folderId);
    } catch (e) {
      debugPrint("Error updating notes: $e");
      rethrow;
    }
  }

  Future<void> deleteNote(String noteId) async {
    final deletedNote = await noteRepo.getNoteById(noteId);
    final folderId = deletedNote.folderId;

    try {
      await noteRepo.deleteNote(noteId);
      await _refreshNotes(folderId);
    } catch (e) {
      debugPrint("Error deleting notes: $e");
      rethrow;
    }
  }
}
