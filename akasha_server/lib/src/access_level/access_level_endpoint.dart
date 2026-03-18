import 'package:akasha_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class AccessLevelEndpoint extends Endpoint {
  Future<AccessLevel> create(Session session, AccessLevel data) async {
    return AccessLevel.db.insertRow(session, data);
  }

  Future<AccessLevel?> read(Session session, int id) async {
    return AccessLevel.db.findById(session, id);
  }

  Future<List<AccessLevel>> readAll(Session session) async {
    return AccessLevel.db.find(
      session,
      orderBy: (t) => t.id,
    );
  }

  Future<AccessLevel> update(Session session, AccessLevel data) async {
    return AccessLevel.db.updateRow(session, data);
  }

  Future<bool> delete(Session session, int id) async {
    final deleted = await AccessLevel.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
    return deleted.isNotEmpty;
  }
}
