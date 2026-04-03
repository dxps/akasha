import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/utils/upsert.dart';
import 'package:flutter/rendering.dart';

class EntityRepo {
  final Client client;
  final List<Entity> _cache = [];

  EntityRepo(this.client);

  Future<List<Entity>> getAll({bool forceRefresh = false}) async {
    if (_cache.isNotEmpty && !forceRefresh) {
      return _cache;
    }
    final entities = await client.entity.readAll();
    _cache.addAll(entities);
    return entities;
  }

  Future<Entity?> getById(UuidValue id) async {
    final cachedItem = _cache.firstWhere((ent) => ent.id == id);
    if (!isEntityEmpty(cachedItem)) {
      debugPrint('>>> Returning cached entity w/ id: $id');
      return cachedItem;
    }
    debugPrint(">>> Cached entity w/ id=$id is 'empty'. Fetching it completely from server...");
    final resp = await client.entity.read(id);
    if (!resp.success) {
      return null;
    }
    upsertList(_cache, resp.data!);
    return resp.data;
  }
}

bool isEntityEmpty(Entity ent) {
  return ent.attributesOrder.isEmpty;
}
