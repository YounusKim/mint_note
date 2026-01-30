import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';

Uuid uuid = const Uuid();

class Note extends Equatable {
  final String noteId;
  final String noteName;
  final String noteContent;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String folderId;
  final String projectId;

  Note({
    String? noteId,
    required this.noteName,
    required this.noteContent,
    DateTime? createdAt,
    DateTime? updatedAt,
    required this.folderId,
    required this.projectId,
  }) : noteId = noteId ?? uuid.v4(),
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  Note copyWith({
    String? noteId,
    String? noteName,
    String? noteContent,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? folderId,
    String? projectId,
  }) {
    return Note(
      noteId: noteId ?? this.noteId,
      noteName: noteName ?? this.noteName,
      noteContent: noteContent ?? this.noteContent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      folderId: folderId ?? this.folderId,
      projectId: projectId ?? this.projectId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'noteName': noteName,
      'noteContent': noteContent,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'folderId': folderId,
      'projectId': projectId,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      noteId: map['noteId'] ?? '',
      noteName: map['noteName'] ?? '',
      noteContent: map['noteContent'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      folderId: map['folderId'] ?? '',
      projectId: map['projectId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Note(noteId: $noteId, noteName: $noteName, noteContent: $noteContent, createdAt: $createdAt, updatedAt: $updatedAt, folderId: $folderId, projectId: $projectId)';
  }

  @override
  List<Object> get props {
    return [
      noteId,
      noteName,
      noteContent,
      createdAt,
      updatedAt,
      folderId,
      projectId,
    ];
  }
}
