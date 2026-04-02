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
import '../protocol.dart' as _i1;
import 'package:serverpod/serverpod.dart' as _i2;
import '../entity/entity.dart' as _i3;
import 'package:akasha_server/src/generated/protocol.dart' as _i4;

abstract class EntityLink extends _i1.HasId
    implements _i2.TableRow<_i2.UuidValue?>, _i2.ProtocolSerialization {
  EntityLink._({
    this.id,
    required this.name,
    this.description,
    required this.orderIdx,
    required this.sourceId,
    this.source,
    required this.targetId,
    this.target,
  });

  factory EntityLink({
    _i2.UuidValue? id,
    required String name,
    String? description,
    required int orderIdx,
    required _i2.UuidValue sourceId,
    _i3.Entity? source,
    required _i2.UuidValue targetId,
    _i3.Entity? target,
  }) = _EntityLinkImpl;

  factory EntityLink.fromJson(Map<String, dynamic> jsonSerialization) {
    return EntityLink(
      id: jsonSerialization['id'] == null
          ? null
          : _i2.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      orderIdx: jsonSerialization['orderIdx'] as int,
      sourceId: _i2.UuidValueJsonExtension.fromJson(
        jsonSerialization['sourceId'],
      ),
      source: jsonSerialization['source'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Entity>(jsonSerialization['source']),
      targetId: _i2.UuidValueJsonExtension.fromJson(
        jsonSerialization['targetId'],
      ),
      target: jsonSerialization['target'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Entity>(jsonSerialization['target']),
    );
  }

  static final t = EntityLinkTable();

  static const db = EntityLinkRepository._();

  @override
  _i2.UuidValue? id;

  String name;

  String? description;

  int orderIdx;

  _i2.UuidValue sourceId;

  /// The source of this entity link.
  _i3.Entity? source;

  _i2.UuidValue targetId;

  /// The target of this entity link.
  _i3.Entity? target;

  @override
  _i2.Table<_i2.UuidValue?> get table => t;

  /// Returns a shallow copy of this [EntityLink]
  /// with some or all fields replaced by the given arguments.
  @override
  @_i2.useResult
  EntityLink copyWith({
    Object? id,
    String? name,
    String? description,
    int? orderIdx,
    _i2.UuidValue? sourceId,
    _i3.Entity? source,
    _i2.UuidValue? targetId,
    _i3.Entity? target,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EntityLink',
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
      '__className__': 'EntityLink',
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

  static EntityLinkInclude include({
    _i3.EntityInclude? source,
    _i3.EntityInclude? target,
  }) {
    return EntityLinkInclude._(
      source: source,
      target: target,
    );
  }

  static EntityLinkIncludeList includeList({
    _i2.WhereExpressionBuilder<EntityLinkTable>? where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<EntityLinkTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<EntityLinkTable>? orderByList,
    EntityLinkInclude? include,
  }) {
    return EntityLinkIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EntityLink.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(EntityLink.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i2.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EntityLinkImpl extends EntityLink {
  _EntityLinkImpl({
    _i2.UuidValue? id,
    required String name,
    String? description,
    required int orderIdx,
    required _i2.UuidValue sourceId,
    _i3.Entity? source,
    required _i2.UuidValue targetId,
    _i3.Entity? target,
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

  /// Returns a shallow copy of this [EntityLink]
  /// with some or all fields replaced by the given arguments.
  @_i2.useResult
  @override
  EntityLink copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    int? orderIdx,
    _i2.UuidValue? sourceId,
    Object? source = _Undefined,
    _i2.UuidValue? targetId,
    Object? target = _Undefined,
  }) {
    return EntityLink(
      id: id is _i2.UuidValue? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      orderIdx: orderIdx ?? this.orderIdx,
      sourceId: sourceId ?? this.sourceId,
      source: source is _i3.Entity? ? source : this.source?.copyWith(),
      targetId: targetId ?? this.targetId,
      target: target is _i3.Entity? ? target : this.target?.copyWith(),
    );
  }
}

class EntityLinkUpdateTable extends _i2.UpdateTable<EntityLinkTable> {
  EntityLinkUpdateTable(super.table);

  _i2.ColumnValue<String, String> name(String value) => _i2.ColumnValue(
    table.name,
    value,
  );

  _i2.ColumnValue<String, String> description(String? value) => _i2.ColumnValue(
    table.description,
    value,
  );

  _i2.ColumnValue<int, int> orderIdx(int value) => _i2.ColumnValue(
    table.orderIdx,
    value,
  );

  _i2.ColumnValue<_i2.UuidValue, _i2.UuidValue> sourceId(_i2.UuidValue value) =>
      _i2.ColumnValue(
        table.sourceId,
        value,
      );

  _i2.ColumnValue<_i2.UuidValue, _i2.UuidValue> targetId(_i2.UuidValue value) =>
      _i2.ColumnValue(
        table.targetId,
        value,
      );
}

class EntityLinkTable extends _i2.Table<_i2.UuidValue?> {
  EntityLinkTable({super.tableRelation}) : super(tableName: 'entity_links') {
    updateTable = EntityLinkUpdateTable(this);
    name = _i2.ColumnString(
      'name',
      this,
    );
    description = _i2.ColumnString(
      'description',
      this,
    );
    orderIdx = _i2.ColumnInt(
      'orderIdx',
      this,
    );
    sourceId = _i2.ColumnUuid(
      'sourceId',
      this,
    );
    targetId = _i2.ColumnUuid(
      'targetId',
      this,
    );
  }

  late final EntityLinkUpdateTable updateTable;

  late final _i2.ColumnString name;

  late final _i2.ColumnString description;

  late final _i2.ColumnInt orderIdx;

  late final _i2.ColumnUuid sourceId;

  /// The source of this entity link.
  _i3.EntityTable? _source;

  late final _i2.ColumnUuid targetId;

  /// The target of this entity link.
  _i3.EntityTable? _target;

  _i3.EntityTable get source {
    if (_source != null) return _source!;
    _source = _i2.createRelationTable(
      relationFieldName: 'source',
      field: EntityLink.t.sourceId,
      foreignField: _i3.Entity.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.EntityTable(tableRelation: foreignTableRelation),
    );
    return _source!;
  }

  _i3.EntityTable get target {
    if (_target != null) return _target!;
    _target = _i2.createRelationTable(
      relationFieldName: 'target',
      field: EntityLink.t.targetId,
      foreignField: _i3.Entity.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.EntityTable(tableRelation: foreignTableRelation),
    );
    return _target!;
  }

  @override
  List<_i2.Column> get columns => [
    id,
    name,
    description,
    orderIdx,
    sourceId,
    targetId,
  ];

  @override
  _i2.Table? getRelationTable(String relationField) {
    if (relationField == 'source') {
      return source;
    }
    if (relationField == 'target') {
      return target;
    }
    return null;
  }
}

class EntityLinkInclude extends _i2.IncludeObject {
  EntityLinkInclude._({
    _i3.EntityInclude? source,
    _i3.EntityInclude? target,
  }) {
    _source = source;
    _target = target;
  }

  _i3.EntityInclude? _source;

  _i3.EntityInclude? _target;

  @override
  Map<String, _i2.Include?> get includes => {
    'source': _source,
    'target': _target,
  };

  @override
  _i2.Table<_i2.UuidValue?> get table => EntityLink.t;
}

class EntityLinkIncludeList extends _i2.IncludeList {
  EntityLinkIncludeList._({
    _i2.WhereExpressionBuilder<EntityLinkTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EntityLink.t);
  }

  @override
  Map<String, _i2.Include?> get includes => include?.includes ?? {};

  @override
  _i2.Table<_i2.UuidValue?> get table => EntityLink.t;
}

class EntityLinkRepository {
  const EntityLinkRepository._();

  final attachRow = const EntityLinkAttachRowRepository._();

  /// Returns a list of [EntityLink]s matching the given query parameters.
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
  Future<List<EntityLink>> find(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<EntityLinkTable>? where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<EntityLinkTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<EntityLinkTable>? orderByList,
    _i2.Transaction? transaction,
    EntityLinkInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EntityLink>(
      where: where?.call(EntityLink.t),
      orderBy: orderBy?.call(EntityLink.t),
      orderByList: orderByList?.call(EntityLink.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EntityLink] matching the given query parameters.
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
  Future<EntityLink?> findFirstRow(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<EntityLinkTable>? where,
    int? offset,
    _i2.OrderByBuilder<EntityLinkTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<EntityLinkTable>? orderByList,
    _i2.Transaction? transaction,
    EntityLinkInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EntityLink>(
      where: where?.call(EntityLink.t),
      orderBy: orderBy?.call(EntityLink.t),
      orderByList: orderByList?.call(EntityLink.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EntityLink] by its [id] or null if no such row exists.
  Future<EntityLink?> findById(
    _i2.DatabaseSession session,
    _i2.UuidValue id, {
    _i2.Transaction? transaction,
    EntityLinkInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EntityLink>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EntityLink]s in the list and returns the inserted rows.
  ///
  /// The returned [EntityLink]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<EntityLink>> insert(
    _i2.DatabaseSession session,
    List<EntityLink> rows, {
    _i2.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<EntityLink>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [EntityLink] and returns the inserted row.
  ///
  /// The returned [EntityLink] will have its `id` field set.
  Future<EntityLink> insertRow(
    _i2.DatabaseSession session,
    EntityLink row, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.insertRow<EntityLink>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [EntityLink]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<EntityLink>> update(
    _i2.DatabaseSession session,
    List<EntityLink> rows, {
    _i2.ColumnSelections<EntityLinkTable>? columns,
    _i2.Transaction? transaction,
  }) async {
    return session.db.update<EntityLink>(
      rows,
      columns: columns?.call(EntityLink.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EntityLink]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EntityLink> updateRow(
    _i2.DatabaseSession session,
    EntityLink row, {
    _i2.ColumnSelections<EntityLinkTable>? columns,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateRow<EntityLink>(
      row,
      columns: columns?.call(EntityLink.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EntityLink] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EntityLink?> updateById(
    _i2.DatabaseSession session,
    _i2.UuidValue id, {
    required _i2.ColumnValueListBuilder<EntityLinkUpdateTable> columnValues,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateById<EntityLink>(
      id,
      columnValues: columnValues(EntityLink.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EntityLink]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<EntityLink>> updateWhere(
    _i2.DatabaseSession session, {
    required _i2.ColumnValueListBuilder<EntityLinkUpdateTable> columnValues,
    required _i2.WhereExpressionBuilder<EntityLinkTable> where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<EntityLinkTable>? orderBy,
    _i2.OrderByListBuilder<EntityLinkTable>? orderByList,
    bool orderDescending = false,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateWhere<EntityLink>(
      columnValues: columnValues(EntityLink.t.updateTable),
      where: where(EntityLink.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EntityLink.t),
      orderByList: orderByList?.call(EntityLink.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [EntityLink]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<EntityLink>> delete(
    _i2.DatabaseSession session,
    List<EntityLink> rows, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.delete<EntityLink>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [EntityLink].
  Future<EntityLink> deleteRow(
    _i2.DatabaseSession session,
    EntityLink row, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EntityLink>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<EntityLink>> deleteWhere(
    _i2.DatabaseSession session, {
    required _i2.WhereExpressionBuilder<EntityLinkTable> where,
    _i2.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<EntityLink>(
      where: where(EntityLink.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<EntityLinkTable>? where,
    int? limit,
    _i2.Transaction? transaction,
  }) async {
    return session.db.count<EntityLink>(
      where: where?.call(EntityLink.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EntityLink] rows matching the [where] expression.
  Future<void> lockRows(
    _i2.DatabaseSession session, {
    required _i2.WhereExpressionBuilder<EntityLinkTable> where,
    required _i2.LockMode lockMode,
    required _i2.Transaction transaction,
    _i2.LockBehavior lockBehavior = _i2.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EntityLink>(
      where: where(EntityLink.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class EntityLinkAttachRowRepository {
  const EntityLinkAttachRowRepository._();

  /// Creates a relation between the given [EntityLink] and [Entity]
  /// by setting the [EntityLink]'s foreign key `sourceId` to refer to the [Entity].
  Future<void> source(
    _i2.DatabaseSession session,
    EntityLink entityLink,
    _i3.Entity source, {
    _i2.Transaction? transaction,
  }) async {
    if (entityLink.id == null) {
      throw ArgumentError.notNull('entityLink.id');
    }
    if (source.id == null) {
      throw ArgumentError.notNull('source.id');
    }

    var $entityLink = entityLink.copyWith(sourceId: source.id);
    await session.db.updateRow<EntityLink>(
      $entityLink,
      columns: [EntityLink.t.sourceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [EntityLink] and [Entity]
  /// by setting the [EntityLink]'s foreign key `targetId` to refer to the [Entity].
  Future<void> target(
    _i2.DatabaseSession session,
    EntityLink entityLink,
    _i3.Entity target, {
    _i2.Transaction? transaction,
  }) async {
    if (entityLink.id == null) {
      throw ArgumentError.notNull('entityLink.id');
    }
    if (target.id == null) {
      throw ArgumentError.notNull('target.id');
    }

    var $entityLink = entityLink.copyWith(targetId: target.id);
    await session.db.updateRow<EntityLink>(
      $entityLink,
      columns: [EntityLink.t.targetId],
      transaction: transaction,
    );
  }
}
