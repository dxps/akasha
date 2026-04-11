import 'package:akasha_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class EntityEndpoint extends Endpoint {
  //
  Future<List<Entity>> readAll(Session session) async {
    return Entity.db.find(session);
  }

  Future<EntityApiResponse> create(Session session, Entity item) async {
    // Persist the item first.
    final created = await Entity.db.insertRow(session, item);
    if (item.outgoingLinks != null) {
      created.outgoingLinks = [];
      for (final link in item.outgoingLinks!) {
        final createdLink = await EntityLink.db.insertRow(
          session,
          EntityLink(
            name: link.name,
            description: link.description,
            sourceId: created.id!,
            targetId: link.targetId,
            orderIdx: link.orderIdx,
          ),
        );
        created.outgoingLinks!.add(createdLink);
      }
    }
    return EntityApiResponse(success: true, data: created);
  }

  Future<EntityApiResponse> read(Session session, UuidValue id) async {
    final item = await Entity.db.findById(session, id);
    if (item == null) {
      return EntityApiResponse(success: true);
    }

    item.outgoingLinks = await EntityLink.db.find(
      session,
      where: (t) => t.sourceId.equals(id),
      orderBy: (t) => t.orderIdx,
    );
    item.incomingLinks = await EntityLink.db.find(
      session,
      where: (t) => t.targetId.equals(id),
      orderBy: (t) => t.orderIdx,
    );

    return EntityApiResponse(success: true, data: item);
  }

  Future<EntityApiResponse> update(Session session, Entity item) async {
    final updated = await Entity.db.updateRow(session, item);
    await EntityLink.db.deleteWhere(
      session,
      where: (t) => t.sourceId.equals(item.id!),
    );
    if (item.outgoingLinks != null) {
      updated.outgoingLinks = [];
      for (final link in item.outgoingLinks!) {
        final createdLink = await EntityLink.db.insertRow(
          session,
          EntityLink(
            name: link.name,
            description: link.description,
            sourceId: item.id!,
            targetId: link.targetId,
            orderIdx: link.orderIdx,
          ),
        );
        updated.outgoingLinks!.add(createdLink);
      }
    }
    return EntityApiResponse(success: true, data: updated);
  }

  Future<EntityApiResponse> delete(Session session, UuidValue id) async {
    await EntityLink.db.deleteWhere(
      session,
      where: (t) => t.sourceId.equals(id) | t.targetId.equals(id),
    );
    final deleted = await Entity.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
    return EntityApiResponse(success: true, data: deleted.firstOrNull);
  }
}
