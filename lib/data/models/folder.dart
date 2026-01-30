import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';

Uuid uuid = const Uuid();

class Folder extends Equatable {
  final String folderId;
  final String folderName;
  final String projectId;

  Folder({String? folderId, required this.folderName, required this.projectId})
    : folderId = folderId ?? uuid.v4();

  Folder copyWith({String? folderId, String? folderName, String? projectId}) {
    return Folder(
      folderId: folderId ?? this.folderId,
      folderName: folderName ?? this.folderName,
      projectId: projectId ?? this.projectId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'folderId': folderId,
      'folderName': folderName,
      'projectId': projectId,
    };
  }

  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
      folderId: map['folderId'] ?? '',
      folderName: map['folderName'] ?? '',
      projectId: map['projectId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Folder.fromJson(String source) => Folder.fromMap(json.decode(source));

  @override
  String toString() =>
      'Folder(folderId: $folderId, folderName: $folderName, projectId: $projectId)';

  @override
  List<Object> get props => [folderId, folderName, projectId];
}
