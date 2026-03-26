/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../entity_template/entity_tmpl.dart' as _i2;
import '../attribute_template/attr_tmpl.dart' as _i3;
import 'package:akasha_server/src/generated/protocol.dart' as _i4;

abstract class EntityTmplAttribute
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  EntityTmplAttribute._({
    this.id,
    required this.entityTmplId,
    this.entityTmpl,
    required this.attributeTmplId,
    this.attributeTmpl,
    required this.orderIdx,
  });

  factory EntityTmplAttribute({
    int? id,
    required _i1.UuidValue entityTmplId,
    _i2.EntityTmpl? entityTmpl,
    required _i1.UuidValue attributeTmplId,
    _i3.AttributeTmpl? attributeTmpl,
    required int orderIdx,
  }) = _EntityTmplAttributeImpl;

  factory EntityTmplAttribute.fromJson(Map<String, dynamic> jsonSerialization) {
    return EntityTmplAttribute(
      id: jsonSerialization['id'] as int?,
      entityTmplId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['entityTmplId'],
      ),
      entityTmpl: jsonSerialization['entityTmpl'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.EntityTmpl>(
              jsonSerialization['entityTmpl'],
            ),
      attributeTmplId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['attributeTmplId'],
      ),
      attributeTmpl: jsonSerialization['attributeTmpl'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.AttributeTmpl>(
              jsonSerialization['attributeTmpl'],
            ),
      orderIdx: jsonSerialization['orderIdx'] as int,
    );
  }

  static final t = EntityTmplAttributeTable();

  static const db = EntityTmplAttributeRepository._();

  @override
  int? id;

  _i1.UuidValue entityTmplId;

  _i2.EntityTmpl? entityTmpl;

  _i1.UuidValue attributeTmplId;

  _i3.AttributeTmpl? attributeTmpl;

  int orderIdx;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [EntityTmplAttribute]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EntityTmplAttribute copyWith({
    int? id,
    _i1.UuidValue? entityTmplId,
    _i2.EntityTmpl? entityTmpl,
    _i1.UuidValue? attributeTmplId,
    _i3.AttributeTmpl? attributeTmpl,
    int? orderIdx,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EntityTmplAttribute',
      if (id != null) 'id': id,
      'entityTmplId': entityTmplId.toJson(),
      if (entityTmpl != null) 'entityTmpl': entityTmpl?.toJson(),
      'attributeTmplId': attributeTmplId.toJson(),
      if (attributeTmpl != null) 'attributeTmpl': attributeTmpl?.toJson(),
      'orderIdx': orderIdx,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EntityTmplAttribute',
      if (id != null) 'id': id,
      'entityTmplId': entityTmplId.toJson(),
      if (entityTmpl != null) 'entityTmpl': entityTmpl?.toJsonForProtocol(),
      'attributeTmplId': attributeTmplId.toJson(),
      if (attributeTmpl != null)
        'attributeTmpl': attributeTmpl?.toJsonForProtocol(),
      'orderIdx': orderIdx,
    };
  }

  static EntityTmplAttributeInclude include({
    _i2.EntityTmplInclude? entityTmpl,
    _i3.AttributeTmplInclude? attributeTmpl,
  }) {
    return EntityTmplAttributeInclude._(
      entityTmpl: entityTmpl,
      attributeTmpl: attributeTmpl,
    );
  }

  static EntityTmplAttributeIncludeList includeList({
    _i1.WhereExpressionBuilder<EntityTmplAttributeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EntityTmplAttributeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EntityTmplAttributeTable>? orderByList,
    EntityTmplAttributeInclude? include,
  }) {
    return EntityTmplAttributeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EntityTmplAttribute.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(EntityTmplAttribute.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EntityTmplAttributeImpl extends EntityTmplAttribute {
  _EntityTmplAttributeImpl({
    int? id,
    required _i1.UuidValue entityTmplId,
    _i2.EntityTmpl? entityTmpl,
    required _i1.UuidValue attributeTmplId,
    _i3.AttributeTmpl? attributeTmpl,
    required int orderIdx,
  }) : super._(
         id: id,
         entityTmplId: entityTmplId,
         entityTmpl: entityTmpl,
         attributeTmplId: attributeTmplId,
         attributeTmpl: attributeTmpl,
         orderIdx: orderIdx,
       );

  /// Returns a shallow copy of this [EntityTmplAttribute]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EntityTmplAttribute copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? entityTmplId,
    Object? entityTmpl = _Undefined,
    _i1.UuidValue? attributeTmplId,
    Object? attributeTmpl = _Undefined,
    int? orderIdx,
  }) {
    return EntityTmplAttribute(
      id: id is int? ? id : this.id,
      entityTmplId: entityTmplId ?? this.entityTmplId,
      entityTmpl: entityTmpl is _i2.EntityTmpl?
          ? entityTmpl
          : this.entityTmpl?.copyWith(),
      attributeTmplId: attributeTmplId ?? this.attributeTmplId,
      attributeTmpl: attributeTmpl is _i3.AttributeTmpl?
          ? attributeTmpl
          : this.attributeTmpl?.copyWith(),
      orderIdx: orderIdx ?? this.orderIdx,
    );
  }
}

class EntityTmplAttributeUpdateTable
    extends _i1.UpdateTable<EntityTmplAttributeTable> {
  EntityTmplAttributeUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> entityTmplId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.entityTmplId,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> attributeTmplId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.attributeTmplId,
    value,
  );

  _i1.ColumnValue<int, int> orderIdx(int value) => _i1.ColumnValue(
    table.orderIdx,
    value,
  );
}

class EntityTmplAttributeTable extends _i1.Table<int?> {
  EntityTmplAttributeTable({super.tableRelation})
    : super(tableName: 'entity_tmpl_attributes') {
    updateTable = EntityTmplAttributeUpdateTable(this);
    entityTmplId = _i1.ColumnUuid(
      'entityTmplId',
      this,
    );
    attributeTmplId = _i1.ColumnUuid(
      'attributeTmplId',
      this,
    );
    orderIdx = _i1.ColumnInt(
      'orderIdx',
      this,
    );
  }

  late final EntityTmplAttributeUpdateTable updateTable;

  late final _i1.ColumnUuid entityTmplId;

  _i2.EntityTmplTable? _entityTmpl;

  late final _i1.ColumnUuid attributeTmplId;

  _i3.AttributeTmplTable? _attributeTmpl;

  late final _i1.ColumnInt orderIdx;

  _i2.EntityTmplTable get entityTmpl {
    if (_entityTmpl != null) return _entityTmpl!;
    _entityTmpl = _i1.createRelationTable(
      relationFieldName: 'entityTmpl',
      field: EntityTmplAttribute.t.entityTmplId,
      foreignField: _i2.EntityTmpl.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.EntityTmplTable(tableRelation: foreignTableRelation),
    );
    return _entityTmpl!;
  }

  _i3.AttributeTmplTable get attributeTmpl {
    if (_attributeTmpl != null) return _attributeTmpl!;
    _attributeTmpl = _i1.createRelationTable(
      relationFieldName: 'attributeTmpl',
      field: EntityTmplAttribute.t.attributeTmplId,
      foreignField: _i3.AttributeTmpl.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.AttributeTmplTable(tableRelation: foreignTableRelation),
    );
    return _attributeTmpl!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    entityTmplId,
    attributeTmplId,
    orderIdx,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'entityTmpl') {
      return entityTmpl;
    }
    if (relationField == 'attributeTmpl') {
      return attributeTmpl;
    }
    return null;
  }
}

class EntityTmplAttributeInclude extends _i1.IncludeObject {
  EntityTmplAttributeInclude._({
    _i2.EntityTmplInclude? entityTmpl,
    _i3.AttributeTmplInclude? attributeTmpl,
  }) {
    _entityTmpl = entityTmpl;
    _attributeTmpl = attributeTmpl;
  }

  _i2.EntityTmplInclude? _entityTmpl;

  _i3.AttributeTmplInclude? _attributeTmpl;

  @override
  Map<String, _i1.Include?> get includes => {
    'entityTmpl': _entityTmpl,
    'attributeTmpl': _attributeTmpl,
  };

  @override
  _i1.Table<int?> get table => EntityTmplAttribute.t;
}

class EntityTmplAttributeIncludeList extends _i1.IncludeList {
  EntityTmplAttributeIncludeList._({
    _i1.WhereExpressionBuilder<EntityTmplAttributeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EntityTmplAttribute.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => EntityTmplAttribute.t;
}

class EntityTmplAttributeRepository {
  const EntityTmplAttributeRepository._();

  final attachRow = const EntityTmplAttributeAttachRowRepository._();

  /// Returns a list of [EntityTmplAttribute]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<EntityTmplAttribute>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EntityTmplAttributeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EntityTmplAttributeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EntityTmplAttributeTable>? orderByList,
    _i1.Transaction? transaction,
    EntityTmplAttributeInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EntityTmplAttribute>(
      where: where?.call(EntityTmplAttribute.t),
      orderBy: orderBy?.call(EntityTmplAttribute.t),
      orderByList: orderByList?.call(EntityTmplAttribute.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EntityTmplAttribute] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<EntityTmplAttribute?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EntityTmplAttributeTable>? where,
    int? offset,
    _i1.OrderByBuilder<EntityTmplAttributeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EntityTmplAttributeTable>? orderByList,
    _i1.Transaction? transaction,
    EntityTmplAttributeInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EntityTmplAttribute>(
      where: where?.call(EntityTmplAttribute.t),
      orderBy: orderBy?.call(EntityTmplAttribute.t),
      orderByList: orderByList?.call(EntityTmplAttribute.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EntityTmplAttribute] by its [id] or null if no such row exists.
  Future<EntityTmplAttribute?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    EntityTmplAttributeInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EntityTmplAttribute>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EntityTmplAttribute]s in the list and returns the inserted rows.
  ///
  /// The returned [EntityTmplAttribute]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<EntityTmplAttribute>> insert(
    _i1.DatabaseSession session,
    List<EntityTmplAttribute> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<EntityTmplAttribute>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [EntityTmplAttribute] and returns the inserted row.
  ///
  /// The returned [EntityTmplAttribute] will have its `id` field set.
  Future<EntityTmplAttribute> insertRow(
    _i1.DatabaseSession session,
    EntityTmplAttribute row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<EntityTmplAttribute>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [EntityTmplAttribute]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<EntityTmplAttribute>> update(
    _i1.DatabaseSession session,
    List<EntityTmplAttribute> rows, {
    _i1.ColumnSelections<EntityTmplAttributeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<EntityTmplAttribute>(
      rows,
      columns: columns?.call(EntityTmplAttribute.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EntityTmplAttribute]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EntityTmplAttribute> updateRow(
    _i1.DatabaseSession session,
    EntityTmplAttribute row, {
    _i1.ColumnSelections<EntityTmplAttributeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<EntityTmplAttribute>(
      row,
      columns: columns?.call(EntityTmplAttribute.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EntityTmplAttribute] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EntityTmplAttribute?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<EntityTmplAttributeUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<EntityTmplAttribute>(
      id,
      columnValues: columnValues(EntityTmplAttribute.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EntityTmplAttribute]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<EntityTmplAttribute>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<EntityTmplAttributeUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<EntityTmplAttributeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EntityTmplAttributeTable>? orderBy,
    _i1.OrderByListBuilder<EntityTmplAttributeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<EntityTmplAttribute>(
      columnValues: columnValues(EntityTmplAttribute.t.updateTable),
      where: where(EntityTmplAttribute.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EntityTmplAttribute.t),
      orderByList: orderByList?.call(EntityTmplAttribute.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [EntityTmplAttribute]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<EntityTmplAttribute>> delete(
    _i1.DatabaseSession session,
    List<EntityTmplAttribute> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<EntityTmplAttribute>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [EntityTmplAttribute].
  Future<EntityTmplAttribute> deleteRow(
    _i1.DatabaseSession session,
    EntityTmplAttribute row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EntityTmplAttribute>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<EntityTmplAttribute>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<EntityTmplAttributeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<EntityTmplAttribute>(
      where: where(EntityTmplAttribute.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EntityTmplAttributeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<EntityTmplAttribute>(
      where: where?.call(EntityTmplAttribute.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EntityTmplAttribute] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<EntityTmplAttributeTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EntityTmplAttribute>(
      where: where(EntityTmplAttribute.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class EntityTmplAttributeAttachRowRepository {
  const EntityTmplAttributeAttachRowRepository._();

  /// Creates a relation between the given [EntityTmplAttribute] and [EntityTmpl]
  /// by setting the [EntityTmplAttribute]'s foreign key `entityTmplId` to refer to the [EntityTmpl].
  Future<void> entityTmpl(
    _i1.DatabaseSession session,
    EntityTmplAttribute entityTmplAttribute,
    _i2.EntityTmpl entityTmpl, {
    _i1.Transaction? transaction,
  }) async {
    if (entityTmplAttribute.id == null) {
      throw ArgumentError.notNull('entityTmplAttribute.id');
    }
    if (entityTmpl.id == null) {
      throw ArgumentError.notNull('entityTmpl.id');
    }

    var $entityTmplAttribute = entityTmplAttribute.copyWith(
      entityTmplId: entityTmpl.id,
    );
    await session.db.updateRow<EntityTmplAttribute>(
      $entityTmplAttribute,
      columns: [EntityTmplAttribute.t.entityTmplId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [EntityTmplAttribute] and [AttributeTmpl]
  /// by setting the [EntityTmplAttribute]'s foreign key `attributeTmplId` to refer to the [AttributeTmpl].
  Future<void> attributeTmpl(
    _i1.DatabaseSession session,
    EntityTmplAttribute entityTmplAttribute,
    _i3.AttributeTmpl attributeTmpl, {
    _i1.Transaction? transaction,
  }) async {
    if (entityTmplAttribute.id == null) {
      throw ArgumentError.notNull('entityTmplAttribute.id');
    }
    if (attributeTmpl.id == null) {
      throw ArgumentError.notNull('attributeTmpl.id');
    }

    var $entityTmplAttribute = entityTmplAttribute.copyWith(
      attributeTmplId: attributeTmpl.id,
    );
    await session.db.updateRow<EntityTmplAttribute>(
      $entityTmplAttribute,
      columns: [EntityTmplAttribute.t.attributeTmplId],
      transaction: transaction,
    );
  }
}
