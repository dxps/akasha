import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/entity_template/ent_tmpl_repo.dart';
import 'package:akasha_ui/entity_template/ent_tmpls_state.dart';
import 'package:akasha_ui/utils/upsert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntityTemplatesLogic extends Cubit<EntityTemplatesState> {
  //
  final EntityTemplateRepo repo;

  EntityTemplatesLogic({required this.repo}) : super(EntityTemplatesState.initial());

  List<EntityTmpl> get cachedItems => state.items;

  void loadAll({bool forceRefresh = false}) async {
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
    debugPrint('>>> [EntityTemplatesLogic.loadAll] Loading state emitted, fetching entity templates from repo ...');
    try {
      final items = await repo.getAll();
      emit(EntityTemplatesStateLoaded(items));
      debugPrint('>>> [EntityTemplatesLogic.loadAll] Loaded state emitted, got ${items.length} items from repo.');
    } catch (e) {
      emit(EntityTemplatesStateError(errorMessage: e.toString()));
    }
  }

  void openModal(UuidValue id) async {
    debugPrint('>>> [EntityTemplatesLogic.openModal] Opening modal for entity template w/ id: $id ...');
    final item = await repo.getById(id);
    if (item != null) {
      upsertList(cachedItems, item);
      emit(EntityTemplatesStateOpenModalFor(forItem: item));
    } else {
      debugPrint('>>> [error] [EntityTemplatesLogic.openModal] No entity template found w/ id: $id');
    }
  }
}
