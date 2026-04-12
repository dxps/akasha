import 'package:akasha_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class EntityEndpoint extends Endpoint {
  //
  Future<List<Entity>> readAll(Session session) async {
    return Entity.db.find(session);
  }

  Future<List<EntityLink>> _insertOutgoingLinks(
    Session session, {
    required UuidValue sourceId,
    required List<EntityLink> links,
  }) async {
    final createdLinks = <EntityLink>[];
    for (var i = 0; i < links.length; i++) {
      final link = links[i];
      final createdLink = await EntityLink.db.insertRow(
        session,
        EntityLink(
          name: link.name,
          description: link.description,
          sourceId: sourceId,
          targetId: link.targetId,
          orderIdx: i,
        ),
      );
      createdLinks.add(createdLink);
    }
    return createdLinks;
  }

  Future<EntityApiResponse> create(Session session, Entity item) async {
    final outgoingLinks = [...?item.outgoingLinks];
    item.outgoingLinks = null;
    item.incomingLinks = null;

    final created = await Entity.db.insertRow(session, item);
    created.outgoingLinks = await _insertOutgoingLinks(
      session,
      sourceId: created.id!,
      links: outgoingLinks,
    );
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
    final outgoingLinks = [...?item.outgoingLinks];
    item.outgoingLinks = null;
    item.incomingLinks = null;

    final updated = await Entity.db.updateRow(session, item);
    await EntityLink.db.deleteWhere(
      session,
      where: (t) => t.sourceId.equals(item.id!),
    );
    updated.outgoingLinks = await _insertOutgoingLinks(
      session,
      sourceId: item.id!,
      links: outgoingLinks,
    );
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
