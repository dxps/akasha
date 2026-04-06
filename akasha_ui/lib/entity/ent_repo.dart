import 'package:akasha_client/akasha_client.dart';

class EntityRepo {
  final Client client;
  //   final List<Entity> _cache = [];

  EntityRepo(this.client);

  Future<List<Entity>> getAll() async {
    return await client.entity.readAll();
  }

  Future<Entity?> getById(UuidValue id) async {
    final resp = await client.entity.read(id);
    return resp.success ? resp.data : null;
  }
}
