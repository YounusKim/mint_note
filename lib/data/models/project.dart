import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';

Uuid uuid = const Uuid();

class Project extends Equatable {
  final String projectId;
  final String projectName;
  final String genreId;

  Project({String? projectId, required this.projectName, required this.genreId})
    : projectId = projectId ?? uuid.v4();

  Project copyWith({String? projectId, String? projectName, String? genreId}) {
    return Project(
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      genreId: genreId ?? this.genreId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'projectId': projectId,
      'projectName': projectName,
      'genreId': genreId,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      projectId: map['projectId'] ?? '',
      projectName: map['projectName'] ?? '',
      genreId: map['genreId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source));

  @override
  String toString() =>
      'Project(projectId: $projectId, projectName: $projectName, genreId: $genreId)';

  @override
  List<Object> get props => [projectId, projectName, genreId];
}
