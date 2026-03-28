import 'package:akasha_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class EntityTmplEndpoint extends Endpoint {
  //
  Future<EntityTmpl?> read(Session session, UuidValue id) async {
    final item = await EntityTmpl.db.findById(session, id);
    session.log('Got entity template: $item');
    await EntityTmplAttribute.db
        .find(
          session,
          where: (t) => t.entityTmplId.equals(id),
          orderBy: (t) => t.orderIdx,
        )
        .then((attributes) {
          item?.attributes = attributes;
        });
    if (item != null) {
      await EntityTmplAttribute.db
          .find(
            session,
            where: (t) => t.entityTmplId.equals(id),
            orderBy: (t) => t.orderIdx,
          )
          .then((attributes) {
            item.attributes = attributes;
          });
    }
    return item;
  }

  Future<List<EntityTmpl>> readAll(Session session) async {
    return EntityTmpl.db.find(
      session,
      orderBy: (t) => t.name,
    );
  }

  Future<EntityTmplApiResponse> create(Session session, EntityTmpl data) async {
    try {
      // Persist the item first.
      final created = await EntityTmpl.db.insertRow(session, data);
      // Then persist the attributes, if any.
      if (data.attributes != null) {
        for (final attr in data.attributes!) {
          await EntityTmplAttribute.db.insertRow(
            session,
            EntityTmplAttribute(
              entityTmplId: created.id!,
              attributeTmplId: attr.attributeTmplId,
              orderIdx: attr.orderIdx,
            ),
          );
        }
      }

      return EntityTmplApiResponse(success: true, data: created);
    } on DatabaseQueryException catch (e) {
      if (e.code == PgErrorCode.uniqueViolation && e.constraintName == 'entity_tmpl_name_desc_uniq_idx') {
        return alreadyExistsResponse();
      }

      session.log(
        'DB error while creating entity template: code=${e.code}, constraint=${e.constraintName}, '
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
      // Update the item first.
      final updated = await EntityTmpl.db.updateRow(session, data);
      // Then update the attributes, by removing existing ones and inserting the new ones.
      await EntityTmplAttribute.db.deleteWhere(
        session,
        where: (t) => t.entityTmplId.equals(data.id!),
      );
      if (data.attributes != null) {
        for (final attr in data.attributes!) {
          await EntityTmplAttribute.db.insertRow(
            session,
            EntityTmplAttribute(
              entityTmplId: data.id!,
              attributeTmplId: attr.attributeTmplId,
              orderIdx: attr.orderIdx,
            ),
          );
        }
      }

      return EntityTmplApiResponse(success: true, data: updated);
    } on DatabaseQueryException catch (e) {
      if (e.code == PgErrorCode.uniqueViolation && e.constraintName == 'entity_tmpl_name_desc_uniq_idx') {
        return alreadyExistsResponse();
      }

      session.log(
        'DB error while updating entity template: code=${e.code}, constraint=${e.constraintName}, '
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
