import 'package:akasha_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class AttrTmplsEndpoint extends Endpoint {
  Future<AttributeTmpl> create(Session session, AttributeTmpl data) async {
    return AttributeTmpl.db.insertRow(session, data);
  }

  Future<AttributeTmpl?> read(Session session, UuidValue id) async {
    return AttributeTmpl.db.findById(session, id);
  }

  Future<List<AttributeTmpl>> readAll(Session session) async {
    return AttributeTmpl.db.find(
      session,
      orderBy: (t) => t.name,
    );
  }

  Future<AttributeTmpl> update(Session session, AttributeTmpl data) async {
    return AttributeTmpl.db.updateRow(session, data);
  }

  Future<bool> delete(Session session, UuidValue id) async {
    final deleted = await AttributeTmpl.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
    return deleted.isNotEmpty;
  }
}
