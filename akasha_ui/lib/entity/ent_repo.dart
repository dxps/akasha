import 'package:akasha_client/akasha_client.dart';

class EntityRepo {
  final Client client;
  final List<Entity> _cache = [];

  EntityRepo(this.client);

  // Future<List<Entity>> getAll({bool forceRefresh = false}) async {
  // if (_cache.isNotEmpty && !forceRefresh) {
  // return _cache;
  // }
  // final entities = await client.entity.readAll();
  // _cache.addAll(entities);
  // return entities;
  // }
}
