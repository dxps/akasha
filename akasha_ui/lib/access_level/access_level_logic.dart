import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_client/shared/upsert_type.dart';
import 'package:akasha_ui/access_level/access_level_repo.dart';
import 'package:akasha_ui/access_level/access_level_state.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccessLevelsLogic extends Cubit<AccessLevelsState> {
  //
  final AccessLevelRepo repo;

  AccessLevelsLogic({required this.repo}) : super(AccessLevelsState.initial());

  List<AccessLevel> get cachedItems => repo.cache;

  Future<void> loadAll({bool forceRefresh = false}) async {
    if (state.isLoading == true) {
      debugPrint('>>> [AccessLevelLogic.loadAll] Already loading, aborting current loadAll().');
      return;
    }
    if (!forceRefresh && state.items.isNotEmpty) {
      emit(AccessLevelLoadedState(state.items));
      return;
    }
    if (forceRefresh) {
      emit(AccessLevelLoadingState());
    }
    try {
      final items = await repo.getAll();
      emit(AccessLevelLoadedState(items));
    } catch (e) {
      emit(AccessLevelLoadErrorState(errorMessage: e.toString()));
    }
  }

  /// Upsert does an explicit insert or update (by provided `type`).
  Future<AccessLevelApiResponse> upsert(UpsertType type, AccessLevel item, {bool emitAll = false}) async {
    final response = switch (type) {
      UpsertType.insert => await repo.create(item),
      UpsertType.update => await repo.update(item),
    };
    if (response.success) {
      if (emitAll) {
        emit(AccessLevelLoadedState(cachedItems));
      }
    }
    return response;
  }

  Future<void> delete(int id, {bool emitAll = false}) async {
    final response = await repo.delete(id);
    if (response.success) {
      if (emitAll) {
        emit(AccessLevelLoadedState(cachedItems));
      }
    }
  }
}
