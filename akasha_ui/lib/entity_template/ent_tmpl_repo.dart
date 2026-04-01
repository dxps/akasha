import 'package:akasha_client/akasha_client.dart';
import 'package:flutter/widgets.dart';

class EntityTemplateRepo {
  final Client client;
  final List<EntityTmpl> _cache = [];

  EntityTemplateRepo({required this.client});

  Future<List<EntityTmpl>> getAll({bool forceRefresh = false}) async {
    if (_cache.isNotEmpty) {
      return _cache;
    }
    final entities = await client.entityTmpl.readAll();
    _cache.addAll(entities);
    return entities;
  }

  /// It returns the complete entity template for the given `id`.
  Future<EntityTmpl?> getById(UuidValue id) async {
    final cachedItem = _cache.firstWhere((ent) => ent.id == id, orElse: () => EntityTmpl(name: ''));
    if (!isEntityTmplEmpty(cachedItem)) {
      debugPrint('>>> Returning cached entity template w/ id: $id');
      return cachedItem;
    }
    debugPrint('>>> Cached entity template w/ id: $id is "empty". Fetching it completely from server...');
    final item = await client.entityTmpl.read(id);
    if (item == null) {
      return null;
    }
    upsertCache(item);
    return item;
  }

  void upsertCache(EntityTmpl entTmpl) {
    final index = _cache.indexWhere((ent) => ent.id == entTmpl.id);
    if (index != -1) {
      _cache[index] = entTmpl;
    } else {
      _cache.add(entTmpl);
    }
  }
}

bool isEntityTmplEmpty(EntityTmpl entTmpl) {
  return entTmpl.attributes?.isEmpty ?? true;
}
