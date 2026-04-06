import 'package:akasha_client/akasha_client.dart';

class EntityTemplateRepo {
  final Client client;

  EntityTemplateRepo({required this.client});

  Future<List<EntityTmpl>> getAll() async {
    return await client.entityTmpl.readAll();
  }

  /// It returns the complete entity template for the given `id`.
  Future<EntityTmpl?> getById(UuidValue id) async {
    return await client.entityTmpl.read(id);
  }
}
