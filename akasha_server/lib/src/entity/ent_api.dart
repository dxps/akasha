import 'package:akasha_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class EntityApi extends Endpoint {
  //
  Future<List<Entity>> readAll(Session session) async {
    return Entity.db.find(session);
  }

  Future<EntityApiResponse> create(Session session, Entity item) async {
    // Persist the item first.
    final created = await Entity.db.insertRow(session, item);
    // TODO: We need to persist the attributes and links of the entity as well,
    // similar to how we do it for entity templates in `EntityTmplEndpoint`.
    return EntityApiResponse(success: true, data: created);
  }

  Future<EntityApiResponse> read(Session session, UuidValue id) async {
    // TODO: We need to fetch the attributes and links of the entity as well,
    // similar to how we do it for entity templates in `EntityTmplEndpoint`.
    final updated = await Entity.db.findById(session, id);
    return EntityApiResponse(success: true, data: updated);
  }

  Future<EntityApiResponse> update(Session session, Entity item) async {
    // TODO: We need to update the attributes and links of the entity as well,
    // similar to how we do it for entity templates in `EntityTmplEndpoint`.
    final updated = await Entity.db.updateRow(session, item);
    return EntityApiResponse(success: true, data: updated);
  }

  Future<EntityApiResponse> delete(Session session, UuidValue id) async {
    // TODO: We need to delete the attributes and links of the entity as well.
    final deleted = await Entity.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
    return EntityApiResponse(success: true, data: deleted.firstOrNull);
  }
}
