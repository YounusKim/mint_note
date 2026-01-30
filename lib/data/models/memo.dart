import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';

Uuid uuid = const Uuid();

class Memo extends Equatable {
  final String memoId;
  final String memoName;
  final String memoContent;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String folderId;
  final String projectId;

  Memo({
    String? memoId,
    required this.memoName,
    required this.memoContent,
    DateTime? createdAt,
    DateTime? updatedAt,
    required this.folderId,
    required this.projectId,
  }) : memoId = memoId ?? uuid.v4(),
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  Memo copyWith({
    String? memoId,
    String? memoName,
    String? memoContent,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? folderId,
    String? projectId,
  }) {
    return Memo(
      memoId: memoId ?? this.memoId,
      memoName: memoName ?? this.memoName,
      memoContent: memoContent ?? this.memoContent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      folderId: folderId ?? this.folderId,
      projectId: projectId ?? this.projectId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'memoId': memoId,
      'memoName': memoName,
      'memoContent': memoContent,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'folderId': folderId,
      'projectId': projectId,
    };
  }

  factory Memo.fromMap(Map<String, dynamic> map) {
    return Memo(
      memoId: map['memoId'] ?? '',
      memoName: map['memoName'] ?? '',
      memoContent: map['memoContent'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
      folderId: map['folderId'] ?? '',
      projectId: map['projectId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Memo.fromJson(String source) => Memo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Memo(memoId: $memoId, memoName: $memoName, memoContent: $memoContent, createdAt: $createdAt, updatedAt: $updatedAt, folderId: $folderId, projectId: $projectId)';
  }

  @override
  List<Object> get props {
    return [
      memoId,
      memoName,
      memoContent,
      createdAt,
      updatedAt,
      folderId,
      projectId,
    ];
  }
}
