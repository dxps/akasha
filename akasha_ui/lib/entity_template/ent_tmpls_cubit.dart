import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/entity_template/ent_tmpl_repo.dart';
import 'package:akasha_ui/entity_template/ent_tmpls_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntityTemplatesCubit extends Cubit<EntityTemplatesState> {
  //
  final EntityTemplateRepo repo;

  EntityTemplatesCubit({required this.repo}) : super(EntityTemplatesState.initial());

  List<EntityTmpl> get cachedItems => state.items;

  void loadAll({bool forceRefresh = false}) async {
    if (state.isLoading == true) {
      debugPrint('>>> [EntityTemplatesCubit] Already loading, aborting current loadAll().');
      return;
    }
    if (!forceRefresh && state.items.isNotEmpty) {
      debugPrint('>>> [EntityTemplatesCubit.loadAll] Emitting state w/ cached items.');
      emit(EntityTemplatesStateLoaded(state.items));
      return;
    }
    emit(EntityTemplatesStateLoading());
    debugPrint('>>> [EntityTemplatesCubit.loadAll] Loading state emitted, fetching entity templates from repo ...');
    try {
      final items = await repo.getAll();
      emit(EntityTemplatesStateLoaded(items));
      debugPrint('>>> [EntityTemplatesCubit.loadAll] Loaded state emitted, got ${items.length} items from repo.');
    } catch (e) {
      emit(EntityTemplatesStateError(errorMessage: e.toString()));
    }
  }

  void openModal(UuidValue id) async {
    debugPrint('>>> [EntityTemplatesCubit.openModal] Opening modal for entity template w/ id: $id ...');
    final item = await repo.getById(id);
    if (item != null) {
      emit(EntityTemplatesStateOpenModalFor(forItem: item));
    } else {
      debugPrint('>>> [error] [EntityTemplatesCubit.openModal] No entity template found w/ id: $id');
    }
  }
}
