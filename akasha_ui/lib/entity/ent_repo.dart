import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/utils/upsert.dart';

class EntityRepo {
  final Client client;
  List<Entity> cache = [];

  EntityRepo(this.client);

  List<Entity> getAllFromCache() {
    return cache;
  }

  Future<List<Entity>> getAll({bool forceLoad = false}) async {
    if (!forceLoad && cache.isNotEmpty) {
      return cache;
    }
    final items = await client.entity.readAll();
    cache = items;
    return items;
  }

  Future<Entity?> getById(UuidValue id) async {
    final cached = cache.where((item) => item.id == id).firstOrNull;
    if (cached != null && (cached.outgoingLinks != null || cached.incomingLinks != null)) {
      return cached;
    }
    final resp = await client.entity.read(id);
    if (resp.success && resp.data != null) {
      upsertList(cache, resp.data!);
      return resp.data;
    }
    return null;
  }

  Future<EntityApiResponse> create(Entity item) async {
    final response = await client.entity.create(item);
    if (response.success && response.data != null) {
      upsertList(cache, response.data!);
    }
    return response;
  }

  Future<EntityApiResponse> update(Entity item) async {
    final response = await client.entity.update(item);
    if (response.success && response.data != null) {
      upsertList(cache, response.data!);
    }
    return response;
  }

  Future<EntityApiResponse> delete(UuidValue id) async {
    final response = await client.entity.delete(id);
    if (response.success) {
      cache.removeWhere((item) => item.id == id);
    }
    return response;
  }
}
