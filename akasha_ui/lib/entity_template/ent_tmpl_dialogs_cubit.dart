import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/entity_template/ent_tmpl_dialogs_state.dart';
import 'package:akasha_ui/entity_template/ent_tmpl_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntityTemplatesCubit extends Cubit<EntityTemplatesState> {
  //
  final EntityTemplateRepo repo;

  EntityTemplatesCubit({required this.repo}) : super(EntityTemplatesStateInitial());

  void getAll({bool forceRefresh = false}) async {
    if (forceRefresh) emit(EntityTemplatesStateLoading());
    debugPrint('>>> [EntityTemplatesCubit] Loading emitted, fetching entity templates from repo ...');
    try {
      final items = await repo.getAll(forceRefresh: forceRefresh);
      emit(EntityTemplatesStateLoaded(items));
      debugPrint('>>> [EntityTemplatesCubit] Loaded emitted, got ${items.length} items from repo.');
    } catch (e) {
      emit(EntityTemplatesStateError(errorMessage: e.toString()));
    }
  }

  void openModal(UuidValue id) async {
    debugPrint('>>> [EntityTemplatesCubit] Opening modal for entity template w/ id: $id ...');
    final item = await repo.getById(id);
    if (item != null) {
      emit(EntityTemplatesStateOpenModalFor(forItem: item));
    } else {
      debugPrint('>>> [error] EntityTemplatesCubit.openModal() - No entity template found w/ id: $id');
    }
  }
}
