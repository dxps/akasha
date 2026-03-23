import 'package:akasha_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class AccessLevelEndpoint extends Endpoint {
  Future<AccessLevelApiResponse> create(Session session, AccessLevel data) async {
    try {
      final created = await AccessLevel.db.insertRow(session, data);

      return AccessLevelApiResponse(
        success: true,
        data: created,
      );
    } on DatabaseQueryException catch (e) {
      if (e.code == PgErrorCode.uniqueViolation) {
        return alreadyExistsResponse();
      }
      return failureResponse('Failed to create access level.', false);
    } on DatabaseException catch (e) {
      session.log('Failed to create access level: $e', level: LogLevel.error);
      return failureResponse(null, false);
    } catch (e) {
      session.log('Failed to create access level: $e', level: LogLevel.error);
      return failureResponse(null, false);
    }
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

  Future<AccessLevelApiResponse> update(Session session, AccessLevel data) async {
    try {
      final updated = await AccessLevel.db.updateRow(session, data);

      return AccessLevelApiResponse(
        success: true,
        data: updated,
      );
    } on DatabaseQueryException catch (e) {
      if (e.code == PgErrorCode.uniqueViolation) {
        return alreadyExistsResponse();
      }
      return failureResponse(null, true);
    } on DatabaseException catch (e) {
      session.log('DatabaseException while updating access level: ${e.message}', level: LogLevel.error);

      return failureResponse(null, true);
    } catch (e) {
      session.log('Unexpected error while updating access level: $e', level: LogLevel.error);
      return failureResponse(null, true);
    }
  }

  Future<bool> delete(Session session, int id) async {
    final deleted = await AccessLevel.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
    return deleted.isNotEmpty;
  }

  AccessLevelApiResponse alreadyExistsResponse() {
    return AccessLevelApiResponse(
      success: false,
      errorCode: 'ALE-003',
      errorMessage: 'An access level with the same name already exists.',
    );
  }

  AccessLevelApiResponse failureResponse(String? message, bool isUpdate) {
    return AccessLevelApiResponse(
      success: false,
      errorCode: message != null ? 'ALE-002' : 'ALE-001',
      errorMessage: message ?? 'Could not ${isUpdate ? 'update' : 'create'} access level.',
    );
  }
}
