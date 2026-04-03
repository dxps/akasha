import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/entity/ent_repo.dart';
import 'package:akasha_ui/entity/ents_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntitiesCubit extends Cubit<EntitiesState> {
  final EntityRepo _repo;

  EntitiesCubit(this._repo) : super(const EntitiesState());

  Future<void> fetchAll() async {
    emit(state.copyWith(status: EntitiesStatus.loading));
    try {
      final entities = await _repo.getAll();
      emit(state.copyWith(status: EntitiesStatus.success, entities: entities));
    } catch (e) {
      emit(state.copyWith(status: EntitiesStatus.failure));
    }
  }

  Future<void> fetchById(UuidValue id) async {
    try {
      await _repo.getById(id);
      // TODO: Do we need to update the state here? Maybe not, since the repo has its own cache and the UI can listen to that.
    } catch (e) {
      debugPrint('>>> Failed to fetch entity with id $id: $e');
    }
  }
}
