import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class Synopsis extends Equatable {
  final String synopsisId;
  final String synopsisName;
  final String synopsisContent;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String folderId;
  final String projectId;

  Synopsis({
    String? synopsisId,
    required this.synopsisName,
    required this.synopsisContent,
    DateTime? createdAt,
    DateTime? updatedAt,
    required this.folderId,
    required this.projectId,
  }) : synopsisId = synopsisId ?? uuid.v4(),
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  Synopsis copyWith({
    String? synopsisId,
    String? synopsisName,
    String? synopsisContent,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? folderId,
    String? projectId,
  }) {
    return Synopsis(
      synopsisId: synopsisId ?? this.synopsisId,
      synopsisName: synopsisName ?? this.synopsisName,
      synopsisContent: synopsisContent ?? this.synopsisContent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      folderId: folderId ?? this.folderId,
      projectId: projectId ?? this.projectId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'synopsisId': synopsisId,
      'synopsisName': synopsisName,
      'synopsisContent': synopsisContent,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'folderId': folderId,
      'projectId': projectId,
    };
  }

  factory Synopsis.fromMap(Map<String, dynamic> map) {
    return Synopsis(
      synopsisId: map['synopsisId'] ?? '',
      synopsisName: map['synopsisName'] ?? '',
      synopsisContent: map['synopsisContent'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      folderId: map['folderId'] ?? '',
      projectId: map['projectId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Synopsis.fromJson(String source) =>
      Synopsis.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Synopsis(synopsisId: $synopsisId, synopsisName: $synopsisName, synopsisContent: $synopsisContent, createdAt: $createdAt, updatedAt: $updatedAt, folderId: $folderId, projectId: $projectId)';
  }

  @override
  List<Object> get props {
    return [
      synopsisId,
      synopsisName,
      synopsisContent,
      createdAt,
      updatedAt,
      folderId,
      projectId,
    ];
  }
}
