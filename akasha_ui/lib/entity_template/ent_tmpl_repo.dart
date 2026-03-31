import 'package:akasha_client/akasha_client.dart';

class EntityTemplateRepo {
  final Client client;
  final List<EntityTmpl> _cache = [];

  EntityTemplateRepo({required this.client});

  Future<List<EntityTmpl>> getAll() async {
    if (_cache.isNotEmpty) {
      return _cache;
    }
    final entities = await client.entityTmpl.readAll();
    _cache.addAll(entities);
    return entities;
  }
}
