import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mint_note/data/models/genre.dart';
import 'package:mint_note/data/models/project.dart';
import 'package:mint_note/data/repositories/repo/project.dart';

class ProjectListState extends Equatable {
  final List<Project> projects;
  const ProjectListState({required this.projects});

  factory ProjectListState.initial() {
    return ProjectListState(projects: []);
  }

  ProjectListState copyWith({List<Project>? projects}) {
    return ProjectListState(projects: projects ?? this.projects);
  }

  @override
  String toString() => 'ProjectListState(projects: $projects)';

  @override
  List<Object> get props => [projects];
}

class ProjectList with ChangeNotifier {
  ProjectListState _state = ProjectListState.initial();
  ProjectListState get state => _state;
  final ProjectRepo projectRepo = ProjectRepo();

  Future<void> getProjectByGenre(String genreId) async {
    try {
      final currentProjects = await projectRepo.getProjectsByGenre(genreId);
      _state = state.copyWith(projects: currentProjects);
      notifyListeners();
    } catch (e) {
      debugPrint("Error getting projects: $e");
      rethrow;
    }
  }

  Future<void> _refreshProjects(String genreId) async {
    final updatedProjects = await projectRepo.getProjectsByGenre(genreId);
    _state = state.copyWith(projects: updatedProjects);
    notifyListeners();
  }

  Future<void> addProject(Project project, Genre genre) async {
    try {
      await projectRepo.addProject(project, genre);
      await _refreshProjects(project.genreId);
    } catch (e) {
      debugPrint("Error adding project: $e");
      rethrow;
    }
  }

  Future<void> updateProject(Project project, String projectId) async {
    final oldProject = await projectRepo.getProjectById(projectId);
    try {
      await projectRepo.updateProject(project);
      await _refreshProjects(oldProject.genreId);
    } catch (e) {
      debugPrint("Error updating project: $e");
      rethrow;
    }
  }

  Future<void> deleteProject(String projectId) async {
    // 1. 삭제할 프로젝트 정보를 DB에서 조회하여 genreId를 가져옵니다.
    final deletedProject = await projectRepo.getProjectById(projectId);
    final genreId = deletedProject.genreId; // 올바른 genreId 확보

    try {
      await projectRepo.deleteProject(projectId);

      // 2. 프로젝트 삭제 후, 확보한 genreId로 목록을 새로고침합니다.
      await _refreshProjects(genreId); // 👈 genreId로 수정
    } catch (e) {
      debugPrint("Error deleting project: $e");
      rethrow;
    }
  }
}
