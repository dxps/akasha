import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_client/shared/upsert_type.dart';
import 'package:akasha_ui/attribute_template/attr_tmpl_repo.dart';
import 'package:akasha_ui/attribute_template/attr_tmpls_state.dart';
import 'package:akasha_ui/utils/upsert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttributeTmplsLogic extends Cubit<AttributeTemplatesState> {
  //
  final AttributeTemplateRepo repo;

  AttributeTmplsLogic({required this.repo}) : super(AttributeTemplatesState.initial());

  List<AttributeTmpl> get cachedItems => state.items;

  Future<void> loadAll({bool forceRefresh = false}) async {
    if (state.isLoading == true) {
      debugPrint('>>> [AttributeTemplatesLogic.loadAll] Already loading, aborting current loadAll().');
      return;
    }
    if (!forceRefresh && state.items.isNotEmpty) {
      debugPrint('>>> [AttributeTemplatesLogic.loadAll] Emitting state w/ cached items.');
      emit(AttributeTemplatesLoadedState(state.items));
      return;
    }
    if (forceRefresh) {
      emit(AttributeTemplatesLoadingState());
      debugPrint('>>> [AttributeTmplsLogic.loadAll] Loading state emitted, fetching items from repo ...');
    }
    try {
      final items = await repo.getAll();
      emit(AttributeTemplatesLoadedState(items));
      debugPrint('>>> [AttributeTmplsLogic.loadAll] Loaded state emitted, got ${state.items.length} items from repo.');
    } catch (e) {
      emit(AttributeTemplatesLoadErrorState(errorMessage: e.toString()));
      debugPrint('>>> [AttributeTmplsLogic.loadAll] Load error state emitted: ${e.toString()}');
    }
  }

  /// Upsert does an explicit insert or update (by provided `type`).
  Future<AttributeTmplApiResponse> upsert(UpsertType type, AttributeTmpl item, {bool emitAll = false}) async {
    final response = switch (type) {
      UpsertType.insert => await repo.create(item),
      UpsertType.update => await repo.update(item),
    };
    if (response.success) {
      upsertList(cachedItems, response.data!);
      if (emitAll) {
        emit(AttributeTemplatesLoadedState(cachedItems));
      }
    }
    return response;
  }

  Future<void> delete(UuidValue id, {bool emitAll = false}) async {
    final done = await repo.delete(id);
    if (done) {
      cachedItems.removeWhere((item) => item.id == id);
      if (emitAll) {
        emit(AttributeTemplatesLoadedState(cachedItems));
      }
    }
  }
}
