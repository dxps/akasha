import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/entity/ent_repo.dart';
import 'package:akasha_ui/entity/ents_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntitiesCubit extends Cubit<EntitiesState> {
  final EntityRepo _repo;

  EntitiesCubit(this._repo) : super(const EntitiesState());

  List<Entity> get cachedItems => _repo.getAllFromCache();

  Future<void> fetchAll({bool forceRefresh = false}) async {
    emit(state.copyWith(status: EntitiesStatus.loading));
    try {
      final entities = await _repo.getAll(forceLoad: forceRefresh);
      emit(state.copyWith(status: EntitiesStatus.success, entities: entities));
    } catch (e) {
      emit(state.copyWith(status: EntitiesStatus.failure));
    }
  }

  Future<Entity?> fetchById(UuidValue id) async {
    try {
      return await _repo.getById(id);
    } catch (e) {
      debugPrint('>>> Failed to fetch entity with id $id: $e');
      return null;
    }
  }

  Future<EntityApiResponse> upsert(Entity item) async {
    final response = item.id == null ? await _repo.create(item) : await _repo.update(item);
    if (response.success) {
      emit(state.copyWith(status: EntitiesStatus.success, entities: cachedItems));
    }
    return response;
  }

  Future<EntityApiResponse> delete(UuidValue id) async {
    final response = await _repo.delete(id);
    if (response.success) {
      emit(state.copyWith(status: EntitiesStatus.success, entities: cachedItems));
    }
    return response;
  }
}
