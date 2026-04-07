import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/utils/upsert.dart';

class EntityTemplateRepo {
  final Client client;
  List<EntityTmpl> cache = [];

  EntityTemplateRepo({required this.client});

  /// Tells if the cache is empty.
  bool isCacheEmpty() {
    return cache.isEmpty;
  }

  /// Get all the items from the cache.
  List<EntityTmpl> getAllFromCache() {
    return cache;
  }

  /// Get the item by id from cache and check if it's "full" (has all its attributes and links fetched from the backend).
  /// If the cached item is not full, it returns null.
  EntityTmpl? getByIdCachedFullVersion(UuidValue id) {
    final item = cache.where((item) => item.id == id).firstOrNull;
    if (item != null && !isEmpty(item)) {
      return item;
    }
    return null;
  }

  /// Get the items from the cache if not empty, otherwise fetch them from the backend and update the cache.
  /// If `forceLoad` is true, it will fetch the items from the backend and update the cache, even if the cache is not empty.
  Future<List<EntityTmpl>> getAll({bool forceLoad = false}) async {
    if (!forceLoad && !isCacheEmpty()) {
      return cache;
    }
    final items = await client.entityTmpl.readAll();
    cache = items;
    return items;
  }

  /// It returns the 'complete' entity template for the given `id`.
  /// Complete means that the returned entity template has all its attributes and links fully fetched from the backend.
  Future<EntityTmpl?> getById(UuidValue id, {bool full = false}) async {
    var item = cache.where((item) => item.id == id).firstOrNull;
    if (item != null && (!full || !isEmpty(item))) {
      return item;
    }
    item = await client.entityTmpl.read(id);
    if (item != null) {
      upsertList(cache, item);
    }
    return item;
  }

  Future<EntityTmplApiResponse> create(EntityTmpl item) async {
    final response = await client.entityTmpl.create(item);
    if (response.success) {
      upsertList(cache, response.data!);
    }
    return response;
  }

  Future<EntityTmplApiResponse> update(EntityTmpl item) async {
    final response = await client.entityTmpl.update(item);
    if (response.success) {
      upsertList(cache, response.data!);
    }
    return response;
  }

  Future<bool> delete(UuidValue id) async {
    final success = await client.entityTmpl.delete(id);
    if (success) {
      cache.removeWhere((item) => item.id == id);
    }
    return success;
  }
}

/// Tells if the given entity template is "empty", meaning it has no attributes or links fetched from the backend.
/// Used to determine if we can return a cached version of the entity template or if we need to fetch it completely from the server.
bool isEmpty(EntityTmpl item) {
  return item.attributes?.isEmpty ?? true;
}
