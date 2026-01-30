import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mint_note/data/models/synopsis.dart';
import 'package:mint_note/data/repositories/repo/synopsis.dart';

class SynopsisListState extends Equatable {
  final List<Synopsis> synopses;
  const SynopsisListState({required this.synopses});

  factory SynopsisListState.initial() {
    return SynopsisListState(synopses: []);
  }

  SynopsisListState copyWith({List<Synopsis>? synopses}) {
    return SynopsisListState(synopses: synopses ?? this.synopses);
  }

  @override
  String toString() => 'SynopsisListState(synopses: $synopses)';

  @override
  List<Object> get props => [synopses];
}

class SynopsisList with ChangeNotifier {
  SynopsisListState _state = SynopsisListState.initial();
  SynopsisListState get state => _state;
  final SynopsisRepo synopsisRepo = SynopsisRepo();

  Future<void> getSynopsisByFolder(String folderId) async {
    try {
      final currentSynopses = await synopsisRepo.getSynopsesByFolder(folderId);
      _state = state.copyWith(synopses: currentSynopses);
      notifyListeners();
    } catch (e) {
      debugPrint("Error getting synopses: $e");
      rethrow;
    }
  }

  Future<void> _refreshSynopses(String folderId) async {
    final updatedSynopses = await synopsisRepo.getSynopsesByFolder(folderId);
    _state = state.copyWith(synopses: updatedSynopses);
    notifyListeners();
  }

  void clear() {
    _state = SynopsisListState.initial();
    notifyListeners();
  }

  Future<void> addSynopsis(Synopsis synopsis) async {
    try {
      await synopsisRepo.addSynopsis(synopsis);
      await _refreshSynopses(synopsis.folderId);
    } catch (e) {
      debugPrint("Error adding synopses: $e");
      rethrow;
    }
  }

  Future<void> updateSynopsis(
    Synopsis synopsis,
    String newSynopsisName,
    String newSynopsisNote,
    DateTime updatedAt,
    String synopsisId,
  ) async {
    final oldSynopsis = await synopsisRepo.getSynopsisById(synopsisId);
    try {
      await synopsisRepo.updateSynopsis(
        newSynopsisName,
        newSynopsisNote,
        updatedAt,
        synopsisId,
      );
      await _refreshSynopses(oldSynopsis.folderId);
    } catch (e) {
      debugPrint("Error adding synopses: $e");
      rethrow;
    }
  }

  Future<void> deleteSynopsis(String synopsisId) async {
    final deletedSynopsis = await synopsisRepo.getSynopsisById(synopsisId);
    final folderId = deletedSynopsis.folderId;

    try {
      await synopsisRepo.deleteSynopsis(synopsisId);
      await _refreshSynopses(folderId);
    } catch (e) {
      debugPrint("Error deleting synopses: $e");
      rethrow;
    }
  }
}
