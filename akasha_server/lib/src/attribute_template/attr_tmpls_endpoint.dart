import 'package:akasha_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class AttrTmplsEndpoint extends Endpoint {
  //
  Future<AttributeTmplApiResponse> create(Session session, AttributeTmpl data) async {
    try {
      final created = await AttributeTmpl.db.insertRow(session, data);

      return AttributeTmplApiResponse(success: true, data: created);
    } on DatabaseQueryException catch (e) {
      if (e.code == PgErrorCode.uniqueViolation && e.constraintName == 'attr_tmpl_name_desc_uniq_idx') {
        return alreadyExistsResponse();
      }

      session.log(
        'DB error while creating attribute template: '
        'code=${e.code}, constraint=${e.constraintName}, '
        'detail=${e.detail}, message=${e.message}',
        level: LogLevel.error,
      );

      return failureResponse(null, false);
    } on DatabaseException catch (e) {
      session.log('Failed (DatabaseException) to create attribute template: ${e.message}', level: LogLevel.error);
      return failureResponse(null, false);
    } catch (e) {
      session.log('Failed to create attribute template: $e', level: LogLevel.error);
      return failureResponse(null, false);
    }
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

  Future<AttributeTmplApiResponse> update(Session session, AttributeTmpl data) async {
    try {
      session.log('Updating attribute template with id ${data.id}', level: LogLevel.info);
      final updated = await AttributeTmpl.db.updateRow(session, data);

      return AttributeTmplApiResponse(
        success: true,
        data: updated,
      );
    } on DatabaseQueryException catch (e) {
      if (e.code == PgErrorCode.uniqueViolation && e.constraintName == 'attr_tmpl_name_desc_uniq_idx') {
        return alreadyExistsResponse();
      }

      session.log(
        'DB error while updating attribute template: '
        'code=${e.code}, constraint=${e.constraintName}, '
        'detail=${e.detail}, message=${e.message}',
        level: LogLevel.error,
      );

      return failureResponse(null, true);
    } on DatabaseException catch (e) {
      session.log('Failed (DatabaseException) to update attribute template: ${e.message}', level: LogLevel.error);

      return failureResponse(null, true);
    } catch (e) {
      session.log('Failed to update attribute template: $e', level: LogLevel.error);
      return failureResponse(null, true);
    }
  }

  Future<bool> delete(Session session, UuidValue id) async {
    final deleted = await AttributeTmpl.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
    return deleted.isNotEmpty;
  }

  // Utility methods.

  AttributeTmplApiResponse alreadyExistsResponse() {
    return AttributeTmplApiResponse(
      success: false,
      errorCode: 'ATE-003',
      errorMessage: 'An attribute template with the same name already exists.',
    );
  }

  AttributeTmplApiResponse failureResponse(String? message, bool isUpdate) {
    return AttributeTmplApiResponse(
      success: false,
      errorCode: message != null ? 'ATE-002' : 'ATE-001',
      errorMessage: message ?? 'Could not ${isUpdate ? 'update' : 'create'} attribute template.',
    );
  }
}
