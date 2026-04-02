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
import 'package:akasha_server/src/generated/protocol.dart' as _i3;

abstract class EntityTmplLink
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  EntityTmplLink._({
    this.id,
    required this.name,
    this.description,
    required this.orderIdx,
    required this.sourceId,
    this.source,
    required this.targetId,
    this.target,
  });

  factory EntityTmplLink({
    _i1.UuidValue? id,
    required String name,
    String? description,
    required int orderIdx,
    required _i1.UuidValue sourceId,
    _i2.EntityTmpl? source,
    required _i1.UuidValue targetId,
    _i2.EntityTmpl? target,
  }) = _EntityTmplLinkImpl;

  factory EntityTmplLink.fromJson(Map<String, dynamic> jsonSerialization) {
    return EntityTmplLink(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      orderIdx: jsonSerialization['orderIdx'] as int,
      sourceId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['sourceId'],
      ),
      source: jsonSerialization['source'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.EntityTmpl>(
              jsonSerialization['source'],
            ),
      targetId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['targetId'],
      ),
      target: jsonSerialization['target'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.EntityTmpl>(
              jsonSerialization['target'],
            ),
    );
  }

  static final t = EntityTmplLinkTable();

  static const db = EntityTmplLinkRepository._();

  @override
  _i1.UuidValue? id;

  String name;

  String? description;

  int orderIdx;

  _i1.UuidValue sourceId;

  /// The source of this entity link template.
  _i2.EntityTmpl? source;

  _i1.UuidValue targetId;

  /// The target of this entity link template.
  _i2.EntityTmpl? target;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [EntityTmplLink]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EntityTmplLink copyWith({
    _i1.UuidValue? id,
    String? name,
    String? description,
    int? orderIdx,
    _i1.UuidValue? sourceId,
    _i2.EntityTmpl? source,
    _i1.UuidValue? targetId,
    _i2.EntityTmpl? target,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EntityTmplLink',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'orderIdx': orderIdx,
      'sourceId': sourceId.toJson(),
      if (source != null) 'source': source?.toJson(),
      'targetId': targetId.toJson(),
      if (target != null) 'target': target?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EntityTmplLink',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'orderIdx': orderIdx,
      'sourceId': sourceId.toJson(),
      if (source != null) 'source': source?.toJsonForProtocol(),
      'targetId': targetId.toJson(),
      if (target != null) 'target': target?.toJsonForProtocol(),
    };
  }

  static EntityTmplLinkInclude include({
    _i2.EntityTmplInclude? source,
    _i2.EntityTmplInclude? target,
  }) {
    return EntityTmplLinkInclude._(
      source: source,
      target: target,
    );
  }

  static EntityTmplLinkIncludeList includeList({
    _i1.WhereExpressionBuilder<EntityTmplLinkTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EntityTmplLinkTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EntityTmplLinkTable>? orderByList,
    EntityTmplLinkInclude? include,
  }) {
    return EntityTmplLinkIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EntityTmplLink.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(EntityTmplLink.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EntityTmplLinkImpl extends EntityTmplLink {
  _EntityTmplLinkImpl({
    _i1.UuidValue? id,
    required String name,
    String? description,
    required int orderIdx,
    required _i1.UuidValue sourceId,
    _i2.EntityTmpl? source,
    required _i1.UuidValue targetId,
    _i2.EntityTmpl? target,
  }) : super._(
         id: id,
         name: name,
         description: description,
         orderIdx: orderIdx,
         sourceId: sourceId,
         source: source,
         targetId: targetId,
         target: target,
       );

  /// Returns a shallow copy of this [EntityTmplLink]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EntityTmplLink copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    int? orderIdx,
    _i1.UuidValue? sourceId,
    Object? source = _Undefined,
    _i1.UuidValue? targetId,
    Object? target = _Undefined,
  }) {
    return EntityTmplLink(
      id: id is _i1.UuidValue? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      orderIdx: orderIdx ?? this.orderIdx,
      sourceId: sourceId ?? this.sourceId,
      source: source is _i2.EntityTmpl? ? source : this.source?.copyWith(),
      targetId: targetId ?? this.targetId,
      target: target is _i2.EntityTmpl? ? target : this.target?.copyWith(),
    );
  }
}

class EntityTmplLinkUpdateTable extends _i1.UpdateTable<EntityTmplLinkTable> {
  EntityTmplLinkUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<int, int> orderIdx(int value) => _i1.ColumnValue(
    table.orderIdx,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> sourceId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.sourceId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> targetId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.targetId,
        value,
      );
}

class EntityTmplLinkTable extends _i1.Table<_i1.UuidValue?> {
  EntityTmplLinkTable({super.tableRelation})
    : super(tableName: 'entity_tmpl_links') {
    updateTable = EntityTmplLinkUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    orderIdx = _i1.ColumnInt(
      'orderIdx',
      this,
    );
    sourceId = _i1.ColumnUuid(
      'sourceId',
      this,
    );
    targetId = _i1.ColumnUuid(
      'targetId',
      this,
    );
  }

  late final EntityTmplLinkUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt orderIdx;

  late final _i1.ColumnUuid sourceId;

  /// The source of this entity link template.
  _i2.EntityTmplTable? _source;

  late final _i1.ColumnUuid targetId;

  /// The target of this entity link template.
  _i2.EntityTmplTable? _target;

  _i2.EntityTmplTable get source {
    if (_source != null) return _source!;
    _source = _i1.createRelationTable(
      relationFieldName: 'source',
      field: EntityTmplLink.t.sourceId,
      foreignField: _i2.EntityTmpl.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.EntityTmplTable(tableRelation: foreignTableRelation),
    );
    return _source!;
  }

  _i2.EntityTmplTable get target {
    if (_target != null) return _target!;
    _target = _i1.createRelationTable(
      relationFieldName: 'target',
      field: EntityTmplLink.t.targetId,
      foreignField: _i2.EntityTmpl.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.EntityTmplTable(tableRelation: foreignTableRelation),
    );
    return _target!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    description,
    orderIdx,
    sourceId,
    targetId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'source') {
      return source;
    }
    if (relationField == 'target') {
      return target;
    }
    return null;
  }
}

class EntityTmplLinkInclude extends _i1.IncludeObject {
  EntityTmplLinkInclude._({
    _i2.EntityTmplInclude? source,
    _i2.EntityTmplInclude? target,
  }) {
    _source = source;
    _target = target;
  }

  _i2.EntityTmplInclude? _source;

  _i2.EntityTmplInclude? _target;

  @override
  Map<String, _i1.Include?> get includes => {
    'source': _source,
    'target': _target,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => EntityTmplLink.t;
}

class EntityTmplLinkIncludeList extends _i1.IncludeList {
  EntityTmplLinkIncludeList._({
    _i1.WhereExpressionBuilder<EntityTmplLinkTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EntityTmplLink.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => EntityTmplLink.t;
}

class EntityTmplLinkRepository {
  const EntityTmplLinkRepository._();

  final attachRow = const EntityTmplLinkAttachRowRepository._();

  /// Returns a list of [EntityTmplLink]s matching the given query parameters.
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
  Future<List<EntityTmplLink>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EntityTmplLinkTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EntityTmplLinkTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EntityTmplLinkTable>? orderByList,
    _i1.Transaction? transaction,
    EntityTmplLinkInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EntityTmplLink>(
      where: where?.call(EntityTmplLink.t),
      orderBy: orderBy?.call(EntityTmplLink.t),
      orderByList: orderByList?.call(EntityTmplLink.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EntityTmplLink] matching the given query parameters.
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
  Future<EntityTmplLink?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EntityTmplLinkTable>? where,
    int? offset,
    _i1.OrderByBuilder<EntityTmplLinkTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EntityTmplLinkTable>? orderByList,
    _i1.Transaction? transaction,
    EntityTmplLinkInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EntityTmplLink>(
      where: where?.call(EntityTmplLink.t),
      orderBy: orderBy?.call(EntityTmplLink.t),
      orderByList: orderByList?.call(EntityTmplLink.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EntityTmplLink] by its [id] or null if no such row exists.
  Future<EntityTmplLink?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    EntityTmplLinkInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EntityTmplLink>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EntityTmplLink]s in the list and returns the inserted rows.
  ///
  /// The returned [EntityTmplLink]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<EntityTmplLink>> insert(
    _i1.DatabaseSession session,
    List<EntityTmplLink> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<EntityTmplLink>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [EntityTmplLink] and returns the inserted row.
  ///
  /// The returned [EntityTmplLink] will have its `id` field set.
  Future<EntityTmplLink> insertRow(
    _i1.DatabaseSession session,
    EntityTmplLink row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<EntityTmplLink>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [EntityTmplLink]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<EntityTmplLink>> update(
    _i1.DatabaseSession session,
    List<EntityTmplLink> rows, {
    _i1.ColumnSelections<EntityTmplLinkTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<EntityTmplLink>(
      rows,
      columns: columns?.call(EntityTmplLink.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EntityTmplLink]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EntityTmplLink> updateRow(
    _i1.DatabaseSession session,
    EntityTmplLink row, {
    _i1.ColumnSelections<EntityTmplLinkTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<EntityTmplLink>(
      row,
      columns: columns?.call(EntityTmplLink.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EntityTmplLink] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EntityTmplLink?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<EntityTmplLinkUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<EntityTmplLink>(
      id,
      columnValues: columnValues(EntityTmplLink.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EntityTmplLink]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<EntityTmplLink>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<EntityTmplLinkUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<EntityTmplLinkTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EntityTmplLinkTable>? orderBy,
    _i1.OrderByListBuilder<EntityTmplLinkTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<EntityTmplLink>(
      columnValues: columnValues(EntityTmplLink.t.updateTable),
      where: where(EntityTmplLink.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EntityTmplLink.t),
      orderByList: orderByList?.call(EntityTmplLink.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [EntityTmplLink]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<EntityTmplLink>> delete(
    _i1.DatabaseSession session,
    List<EntityTmplLink> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<EntityTmplLink>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [EntityTmplLink].
  Future<EntityTmplLink> deleteRow(
    _i1.DatabaseSession session,
    EntityTmplLink row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EntityTmplLink>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<EntityTmplLink>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<EntityTmplLinkTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<EntityTmplLink>(
      where: where(EntityTmplLink.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EntityTmplLinkTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<EntityTmplLink>(
      where: where?.call(EntityTmplLink.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EntityTmplLink] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<EntityTmplLinkTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EntityTmplLink>(
      where: where(EntityTmplLink.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class EntityTmplLinkAttachRowRepository {
  const EntityTmplLinkAttachRowRepository._();

  /// Creates a relation between the given [EntityTmplLink] and [EntityTmpl]
  /// by setting the [EntityTmplLink]'s foreign key `sourceId` to refer to the [EntityTmpl].
  Future<void> source(
    _i1.DatabaseSession session,
    EntityTmplLink entityTmplLink,
    _i2.EntityTmpl source, {
    _i1.Transaction? transaction,
  }) async {
    if (entityTmplLink.id == null) {
      throw ArgumentError.notNull('entityTmplLink.id');
    }
    if (source.id == null) {
      throw ArgumentError.notNull('source.id');
    }

    var $entityTmplLink = entityTmplLink.copyWith(sourceId: source.id);
    await session.db.updateRow<EntityTmplLink>(
      $entityTmplLink,
      columns: [EntityTmplLink.t.sourceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [EntityTmplLink] and [EntityTmpl]
  /// by setting the [EntityTmplLink]'s foreign key `targetId` to refer to the [EntityTmpl].
  Future<void> target(
    _i1.DatabaseSession session,
    EntityTmplLink entityTmplLink,
    _i2.EntityTmpl target, {
    _i1.Transaction? transaction,
  }) async {
    if (entityTmplLink.id == null) {
      throw ArgumentError.notNull('entityTmplLink.id');
    }
    if (target.id == null) {
      throw ArgumentError.notNull('target.id');
    }

    var $entityTmplLink = entityTmplLink.copyWith(targetId: target.id);
    await session.db.updateRow<EntityTmplLink>(
      $entityTmplLink,
      columns: [EntityTmplLink.t.targetId],
      transaction: transaction,
    );
  }
}
