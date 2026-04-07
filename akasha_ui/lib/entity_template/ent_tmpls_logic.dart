import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_client/shared/upsert_type.dart';
import 'package:akasha_ui/entity_template/ent_tmpl_repo.dart';
import 'package:akasha_ui/entity_template/ent_tmpls_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntityTmplLogic extends Cubit<EntityTemplatesState> {
  //
  final EntityTemplateRepo repo;

  List<EntityTmpl> get cachedItems => repo.getAllFromCache();

  EntityTmplLogic({required this.repo}) : super(EntityTemplatesState.initial());

  Future<void> loadAll({bool forceRefresh = false}) async {
    if (state.isLoading == true) {
      debugPrint('>>> [EntityTemplatesLogic.loadAll] Already loading, aborting current loadAll().');
      return;
    }
    if (!forceRefresh && state.items.isNotEmpty) {
      debugPrint('>>> [EntityTemplatesLogic.loadAll] Emitting state w/ cached items.');
      emit(EntityTemplatesStateLoaded(state.items));
      return;
    }
    emit(EntityTemplatesStateLoading());
    debugPrint('>>> [EntityTemplatesLogic.loadAll] Loading state emitted, fetching items from repo ...');
    try {
      final items = await repo.getAll();
      emit(EntityTemplatesStateLoaded(items));
      debugPrint('>>> [EntityTemplatesLogic.loadAll] Loaded state emitted, got ${items.length} items from repo.');
    } catch (e) {
      emit(EntityTemplatesStateError(errorMessage: e.toString()));
    }
  }

  Future<void> openModal(UuidValue id) async {
    debugPrint('>>> [EntityTemplatesLogic.openModal] Opening modal for item w/ id: $id ...');
    final item = await repo.getById(id, full: true);
    if (item != null) {
      debugPrint('>>> [EntityTemplatesLogic.openModal] Got from repo the (full) item w/ id $id: $item');
      emit(EntityTemplatesStateOpenModalFor(forItem: item));
    } else {
      debugPrint('>>> [error] [EntityTemplatesLogic.openModal] No item found w/ id: $id in repo.');
    }
  }

  Future<EntityTmplApiResponse> upsert(UpsertType type, EntityTmpl item, {bool emitAll = false}) async {
    final response = switch (type) {
      UpsertType.insert => await repo.create(item),
      UpsertType.update => await repo.update(item),
    };
    if (response.success) {
      if (emitAll) {
        emit(EntityTemplatesStateLoaded(cachedItems));
      }
    }
    return response;
  }

  Future<void> delete(UuidValue id, {bool emitAll = false}) async {
    final done = await repo.delete(id);
    if (done) {
      if (emitAll) {
        emit(EntityTemplatesStateLoaded(cachedItems));
      }
    }
  }
}
