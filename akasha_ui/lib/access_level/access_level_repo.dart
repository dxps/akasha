import 'package:akasha_client/akasha_client.dart';

class AccessLevelRepo {
  final Client client;
  List<AccessLevel> cache = [];

  AccessLevelRepo({required this.client});

  /// Get the items from the cache if not empty, otherwise fetch them from the backend and update the cache.
  /// If `forceLoad` is true, it will fetch the items from the backend and update the cache, even if the cache is not empty.
  Future<List<AccessLevel>> getAll({bool forceLoad = false}) async {
    if (!forceLoad && cache.isNotEmpty) {
      return cache;
    }
    final items = await client.accessLevel.readAll();
    cache = items;
    return items;
  }

  Future<AccessLevelApiResponse> create(AccessLevel item) async {
    final response = await client.accessLevel.create(item);
    if (response.success) {
      cache.add(response.data!);
    }
    return response;
  }

  Future<AccessLevelApiResponse> update(AccessLevel item) async {
    final response = await client.accessLevel.update(item);
    if (response.success) {
      _upsertCache(cache, response.data!);
    }
    return response;
  }

  Future<AccessLevelApiResponse> delete(int id) async {
    final isOk = await client.accessLevel.delete(id);
    if (isOk) {
      cache.removeWhere((e) => e.id == id);
    }
    return AccessLevelApiResponse(success: isOk);
  }
}

void _upsertCache(List<AccessLevel> cache, AccessLevel item) {
  final index = cache.indexWhere((e) => e.id == item.id);
  if (index != -1) {
    cache[index] = item;
  } else {
    cache.add(item);
  }
}
