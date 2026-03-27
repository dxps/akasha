import 'package:akasha_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class EntityTmplEndpoint extends Endpoint {
  //
  Future<EntityTmpl?> read(Session session, UuidValue id) async {
    return EntityTmpl.db.findById(session, id);
  }

  Future<List<EntityTmpl>> readAll(Session session) async {
    return EntityTmpl.db.find(
      session,
      orderBy: (t) => t.name,
    );
  }

  Future<EntityTmplApiResponse> create(Session session, EntityTmpl data) async {
    try {
      final created = await EntityTmpl.db.insertRow(session, data);

      return EntityTmplApiResponse(success: true, data: created);
    } on DatabaseQueryException catch (e) {
      if (e.code == PgErrorCode.uniqueViolation && e.constraintName == 'entity_tmpl_name_desc_uniq_idx') {
        return alreadyExistsResponse();
      }

      session.log(
        'DB error while creating entity template: '
        'code=${e.code}, constraint=${e.constraintName}, '
        'detail=${e.detail}, message=${e.message}',
        level: LogLevel.error,
      );

      return failureResponse(null, false);
    } on DatabaseException catch (e) {
      session.log('Failed (DatabaseException) to create entity template: ${e.message}', level: LogLevel.error);
      return failureResponse(null, false);
    } catch (e) {
      session.log('Failed to create entity template: $e', level: LogLevel.error);
      return failureResponse(null, false);
    }
  }

  Future<EntityTmplApiResponse> update(Session session, EntityTmpl data) async {
    try {
      session.log('Updating entity template with id ${data.id}', level: LogLevel.info);
      final updated = await EntityTmpl.db.updateRow(session, data);

      return EntityTmplApiResponse(
        success: true,
        data: updated,
      );
    } on DatabaseQueryException catch (e) {
      if (e.code == PgErrorCode.uniqueViolation && e.constraintName == 'entity_tmpl_name_desc_uniq_idx') {
        return alreadyExistsResponse();
      }

      session.log(
        'DB error while updating entity template: '
        'code=${e.code}, constraint=${e.constraintName}, '
        'detail=${e.detail}, message=${e.message}',
        level: LogLevel.error,
      );

      return failureResponse(null, true);
    } on DatabaseException catch (e) {
      session.log('Failed (DatabaseException) to update entity template: ${e.message}', level: LogLevel.error);
      return failureResponse(null, true);
    } catch (e) {
      session.log('Failed to update entity template: $e', level: LogLevel.error);
      return failureResponse(null, true);
    }
  }

  Future<bool> delete(Session session, UuidValue id) async {
    final deleted = await EntityTmpl.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
    return deleted.isNotEmpty;
  }
}

/// Utility methods for creating API responses.
extension _ApiResponseHelpers on EntityTmplEndpoint {
  EntityTmplApiResponse alreadyExistsResponse() {
    return EntityTmplApiResponse(
      success: false,
      errorCode: 'ETE-003',
      errorMessage: 'An entity template with the same name already exists.',
    );
  }

  EntityTmplApiResponse failureResponse(String? message, bool isUpdate) {
    return EntityTmplApiResponse(
      success: false,
      errorCode: message != null ? 'ETE-002' : 'ETE-001',
      errorMessage: message ?? 'Could not ${isUpdate ? 'update' : 'create'} entity template.',
    );
  }
}
