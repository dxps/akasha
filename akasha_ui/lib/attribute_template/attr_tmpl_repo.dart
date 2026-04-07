import 'package:akasha_client/akasha_client.dart';

class AttributeTemplateRepo {
  final Client client;
  List<AttributeTmpl> cache = [];

  AttributeTemplateRepo({required this.client});

  /// Get the items from the cache if not empty, otherwise fetch them from the backend and update the cache.
  /// If `forceLoad` is true, it will fetch the items from the backend and update the cache, even if the cache is not empty.
  Future<List<AttributeTmpl>> getAll({bool forceLoad = false}) async {
    if (!forceLoad && cache.isNotEmpty) {
      return cache;
    }
    final items = await client.attrTmpls.readAll();
    cache = items;
    return items;
  }

  Future<AttributeTmplApiResponse> create(AttributeTmpl item) async {
    final response = await client.attrTmpls.create(item);
    if (response.success) {
      cache.add(response.data!);
    }
    return response;
  }

  Future<AttributeTmplApiResponse> update(AttributeTmpl item) async {
    final response = await client.attrTmpls.update(item);
    if (response.success) {
      final index = cache.indexWhere((e) => e.id == item.id);
      if (index != -1) {
        cache[index] = response.data!;
      }
    }
    return response;
  }

  Future<bool> delete(UuidValue id) async {
    final success = await client.attrTmpls.delete(id);
    if (success) {
      cache.removeWhere((e) => e.id == id);
    }
    return success;
  }
}
