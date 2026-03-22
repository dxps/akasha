import 'package:akasha_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class AttrTmplsEndpoint extends Endpoint {
  //
  Future<AttributeTmplApiResponse> create(Session session, AttributeTmpl data) async {
    try {
      final created = await AttributeTmpl.db.insertRow(session, data);

      return AttributeTmplApiResponse(
        success: true,
        data: created,
      );
    } on DatabaseQueryException catch (e) {
      if (e.code == PgErrorCode.uniqueViolation && e.constraintName == 'attr_tmpl_name_desc_uniq_idx') {
        return AttributeTmplApiResponse(
          success: false,
          errorCode: 'ATE-002',
          message: 'An attribute template with the same name and description already exists.',
        );
      }

      session.log(
        'DB error while creating attribute template: '
        'code=${e.code}, constraint=${e.constraintName}, '
        'detail=${e.detail}, message=${e.message}',
        level: LogLevel.error,
      );

      return AttributeTmplApiResponse(
        success: false,
        errorCode: 'ATE-001',
        message: 'Could not create attribute template.',
      );
    } on DatabaseException catch (e) {
      session.log(
        'DatabaseException while creating attribute template: ${e.message}',
        level: LogLevel.error,
      );

      return AttributeTmplApiResponse(
        success: false,
        errorCode: 'ATE-001',
        message: 'Could not create attribute template.',
      );
    } catch (e) {
      session.log(
        'Unexpected error while creating attribute template: $e',
        level: LogLevel.error,
      );

      return AttributeTmplApiResponse(
        success: false,
        errorCode: 'ATE-001',
        message: 'Unexpected error while creating attribute template.',
      );
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
      final updated = await AttributeTmpl.db.updateRow(session, data);

      return AttributeTmplApiResponse(
        success: true,
        data: updated,
      );
    } on DatabaseQueryException catch (e) {
      if (e.code == PgErrorCode.uniqueViolation && e.constraintName == 'attr_tmpl_name_desc_uniq_idx') {
        return AttributeTmplApiResponse(
          success: false,
          errorCode: 'ATE-002',
          message: 'An attribute template with the same name and description already exists.',
        );
      }

      session.log(
        'DB error while updating attribute template: '
        'code=${e.code}, constraint=${e.constraintName}, '
        'detail=${e.detail}, message=${e.message}',
        level: LogLevel.error,
      );

      return AttributeTmplApiResponse(
        success: false,
        errorCode: 'ATE-001',
        message: 'Could not update attribute template.',
      );
    } on DatabaseException catch (e) {
      session.log(
        'DatabaseException while updating attribute template: ${e.message}',
        level: LogLevel.error,
      );

      return AttributeTmplApiResponse(
        success: false,
        errorCode: 'ATE-001',
        message: 'Could not update attribute template.',
      );
    } catch (e) {
      session.log(
        'Unexpected error while updating attribute template: $e',
        level: LogLevel.error,
      );

      return AttributeTmplApiResponse(
        success: false,
        errorCode: 'ATE-001',
        message: 'Unexpected error while updating attribute template.',
      );
    }
  }

  Future<bool> delete(Session session, UuidValue id) async {
    final deleted = await AttributeTmpl.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
    return deleted.isNotEmpty;
  }
}
