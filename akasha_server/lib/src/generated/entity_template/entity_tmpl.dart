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
import '../entity_template/entity_tmpl_attribute.dart' as _i2;
import '../entity_template/entity_link_tmpl.dart' as _i3;
import 'package:akasha_server/src/generated/protocol.dart' as _i4;

abstract class EntityTmpl
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  EntityTmpl._({
    this.id,
    required this.name,
    this.description,
    this.attributeLinks,
    this.outgoingLinks,
    this.incomingLinkTargets,
  });

  factory EntityTmpl({
    _i1.UuidValue? id,
    required String name,
    String? description,
    List<_i2.EntityTmplAttribute>? attributeLinks,
    List<_i3.EntityTmplLink>? outgoingLinks,
    List<_i3.EntityTmplLink>? incomingLinkTargets,
  }) = _EntityTmplImpl;

  factory EntityTmpl.fromJson(Map<String, dynamic> jsonSerialization) {
    return EntityTmpl(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      attributeLinks: jsonSerialization['attributeLinks'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i2.EntityTmplAttribute>>(
              jsonSerialization['attributeLinks'],
            ),
      outgoingLinks: jsonSerialization['outgoingLinks'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.EntityTmplLink>>(
              jsonSerialization['outgoingLinks'],
            ),
      incomingLinkTargets: jsonSerialization['incomingLinkTargets'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.EntityTmplLink>>(
              jsonSerialization['incomingLinkTargets'],
            ),
    );
  }

  static final t = EntityTmplTable();

  static const db = EntityTmplRepository._();

  @override
  _i1.UuidValue? id;

  String name;

  String? description;

  List<_i2.EntityTmplAttribute>? attributeLinks;

  /// The links where this entity template is the source.
  List<_i3.EntityTmplLink>? outgoingLinks;

  /// Optional reverse traversal: links where this entity template is a target.
  List<_i3.EntityTmplLink>? incomingLinkTargets;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [EntityTmpl]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EntityTmpl copyWith({
    _i1.UuidValue? id,
    String? name,
    String? description,
    List<_i2.EntityTmplAttribute>? attributeLinks,
    List<_i3.EntityTmplLink>? outgoingLinks,
    List<_i3.EntityTmplLink>? incomingLinkTargets,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EntityTmpl',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      if (description != null) 'description': description,
      if (attributeLinks != null)
        'attributeLinks': attributeLinks?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (outgoingLinks != null)
        'outgoingLinks': outgoingLinks?.toJson(valueToJson: (v) => v.toJson()),
      if (incomingLinkTargets != null)
        'incomingLinkTargets': incomingLinkTargets?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EntityTmpl',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      if (description != null) 'description': description,
      if (attributeLinks != null)
        'attributeLinks': attributeLinks?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (outgoingLinks != null)
        'outgoingLinks': outgoingLinks?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (incomingLinkTargets != null)
        'incomingLinkTargets': incomingLinkTargets?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  static EntityTmplInclude include({
    _i2.EntityTmplAttributeIncludeList? attributeLinks,
    _i3.EntityTmplLinkIncludeList? outgoingLinks,
    _i3.EntityTmplLinkIncludeList? incomingLinkTargets,
  }) {
    return EntityTmplInclude._(
      attributeLinks: attributeLinks,
      outgoingLinks: outgoingLinks,
      incomingLinkTargets: incomingLinkTargets,
    );
  }

  static EntityTmplIncludeList includeList({
    _i1.WhereExpressionBuilder<EntityTmplTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EntityTmplTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EntityTmplTable>? orderByList,
    EntityTmplInclude? include,
  }) {
    return EntityTmplIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EntityTmpl.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(EntityTmpl.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EntityTmplImpl extends EntityTmpl {
  _EntityTmplImpl({
    _i1.UuidValue? id,
    required String name,
    String? description,
    List<_i2.EntityTmplAttribute>? attributeLinks,
    List<_i3.EntityTmplLink>? outgoingLinks,
    List<_i3.EntityTmplLink>? incomingLinkTargets,
  }) : super._(
         id: id,
         name: name,
         description: description,
         attributeLinks: attributeLinks,
         outgoingLinks: outgoingLinks,
         incomingLinkTargets: incomingLinkTargets,
       );

  /// Returns a shallow copy of this [EntityTmpl]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EntityTmpl copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    Object? attributeLinks = _Undefined,
    Object? outgoingLinks = _Undefined,
    Object? incomingLinkTargets = _Undefined,
  }) {
    return EntityTmpl(
      id: id is _i1.UuidValue? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      attributeLinks: attributeLinks is List<_i2.EntityTmplAttribute>?
          ? attributeLinks
          : this.attributeLinks?.map((e0) => e0.copyWith()).toList(),
      outgoingLinks: outgoingLinks is List<_i3.EntityTmplLink>?
          ? outgoingLinks
          : this.outgoingLinks?.map((e0) => e0.copyWith()).toList(),
      incomingLinkTargets: incomingLinkTargets is List<_i3.EntityTmplLink>?
          ? incomingLinkTargets
          : this.incomingLinkTargets?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class EntityTmplUpdateTable extends _i1.UpdateTable<EntityTmplTable> {
  EntityTmplUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );
}

class EntityTmplTable extends _i1.Table<_i1.UuidValue?> {
  EntityTmplTable({super.tableRelation}) : super(tableName: 'entity_tmpls') {
    updateTable = EntityTmplUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
  }

  late final EntityTmplUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  _i2.EntityTmplAttributeTable? ___attributeLinks;

  _i1.ManyRelation<_i2.EntityTmplAttributeTable>? _attributeLinks;

  /// The links where this entity template is the source.
  _i3.EntityTmplLinkTable? ___outgoingLinks;

  /// The links where this entity template is the source.
  _i1.ManyRelation<_i3.EntityTmplLinkTable>? _outgoingLinks;

  /// Optional reverse traversal: links where this entity template is a target.
  _i3.EntityTmplLinkTable? ___incomingLinkTargets;

  /// Optional reverse traversal: links where this entity template is a target.
  _i1.ManyRelation<_i3.EntityTmplLinkTable>? _incomingLinkTargets;

  _i2.EntityTmplAttributeTable get __attributeLinks {
    if (___attributeLinks != null) return ___attributeLinks!;
    ___attributeLinks = _i1.createRelationTable(
      relationFieldName: '__attributeLinks',
      field: EntityTmpl.t.id,
      foreignField: _i2.EntityTmplAttribute.t.entityTmplId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.EntityTmplAttributeTable(tableRelation: foreignTableRelation),
    );
    return ___attributeLinks!;
  }

  _i3.EntityTmplLinkTable get __outgoingLinks {
    if (___outgoingLinks != null) return ___outgoingLinks!;
    ___outgoingLinks = _i1.createRelationTable(
      relationFieldName: '__outgoingLinks',
      field: EntityTmpl.t.id,
      foreignField: _i3.EntityTmplLink.t.sourceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.EntityTmplLinkTable(tableRelation: foreignTableRelation),
    );
    return ___outgoingLinks!;
  }

  _i3.EntityTmplLinkTable get __incomingLinkTargets {
    if (___incomingLinkTargets != null) return ___incomingLinkTargets!;
    ___incomingLinkTargets = _i1.createRelationTable(
      relationFieldName: '__incomingLinkTargets',
      field: EntityTmpl.t.id,
      foreignField: _i3.EntityTmplLink.t.targetId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.EntityTmplLinkTable(tableRelation: foreignTableRelation),
    );
    return ___incomingLinkTargets!;
  }

  _i1.ManyRelation<_i2.EntityTmplAttributeTable> get attributeLinks {
    if (_attributeLinks != null) return _attributeLinks!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'attributeLinks',
      field: EntityTmpl.t.id,
      foreignField: _i2.EntityTmplAttribute.t.entityTmplId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.EntityTmplAttributeTable(tableRelation: foreignTableRelation),
    );
    _attributeLinks = _i1.ManyRelation<_i2.EntityTmplAttributeTable>(
      tableWithRelations: relationTable,
      table: _i2.EntityTmplAttributeTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _attributeLinks!;
  }

  _i1.ManyRelation<_i3.EntityTmplLinkTable> get outgoingLinks {
    if (_outgoingLinks != null) return _outgoingLinks!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'outgoingLinks',
      field: EntityTmpl.t.id,
      foreignField: _i3.EntityTmplLink.t.sourceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.EntityTmplLinkTable(tableRelation: foreignTableRelation),
    );
    _outgoingLinks = _i1.ManyRelation<_i3.EntityTmplLinkTable>(
      tableWithRelations: relationTable,
      table: _i3.EntityTmplLinkTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _outgoingLinks!;
  }

  _i1.ManyRelation<_i3.EntityTmplLinkTable> get incomingLinkTargets {
    if (_incomingLinkTargets != null) return _incomingLinkTargets!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'incomingLinkTargets',
      field: EntityTmpl.t.id,
      foreignField: _i3.EntityTmplLink.t.targetId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.EntityTmplLinkTable(tableRelation: foreignTableRelation),
    );
    _incomingLinkTargets = _i1.ManyRelation<_i3.EntityTmplLinkTable>(
      tableWithRelations: relationTable,
      table: _i3.EntityTmplLinkTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _incomingLinkTargets!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    description,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'attributeLinks') {
      return __attributeLinks;
    }
    if (relationField == 'outgoingLinks') {
      return __outgoingLinks;
    }
    if (relationField == 'incomingLinkTargets') {
      return __incomingLinkTargets;
    }
    return null;
  }
}

class EntityTmplInclude extends _i1.IncludeObject {
  EntityTmplInclude._({
    _i2.EntityTmplAttributeIncludeList? attributeLinks,
    _i3.EntityTmplLinkIncludeList? outgoingLinks,
    _i3.EntityTmplLinkIncludeList? incomingLinkTargets,
  }) {
    _attributeLinks = attributeLinks;
    _outgoingLinks = outgoingLinks;
    _incomingLinkTargets = incomingLinkTargets;
  }

  _i2.EntityTmplAttributeIncludeList? _attributeLinks;

  _i3.EntityTmplLinkIncludeList? _outgoingLinks;

  _i3.EntityTmplLinkIncludeList? _incomingLinkTargets;

  @override
  Map<String, _i1.Include?> get includes => {
    'attributeLinks': _attributeLinks,
    'outgoingLinks': _outgoingLinks,
    'incomingLinkTargets': _incomingLinkTargets,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => EntityTmpl.t;
}

class EntityTmplIncludeList extends _i1.IncludeList {
  EntityTmplIncludeList._({
    _i1.WhereExpressionBuilder<EntityTmplTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EntityTmpl.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => EntityTmpl.t;
}

class EntityTmplRepository {
  const EntityTmplRepository._();

  final attach = const EntityTmplAttachRepository._();

  final attachRow = const EntityTmplAttachRowRepository._();

  final detach = const EntityTmplDetachRepository._();

  final detachRow = const EntityTmplDetachRowRepository._();

  /// Returns a list of [EntityTmpl]s matching the given query parameters.
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
  Future<List<EntityTmpl>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EntityTmplTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EntityTmplTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EntityTmplTable>? orderByList,
    _i1.Transaction? transaction,
    EntityTmplInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EntityTmpl>(
      where: where?.call(EntityTmpl.t),
      orderBy: orderBy?.call(EntityTmpl.t),
      orderByList: orderByList?.call(EntityTmpl.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EntityTmpl] matching the given query parameters.
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
  Future<EntityTmpl?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EntityTmplTable>? where,
    int? offset,
    _i1.OrderByBuilder<EntityTmplTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EntityTmplTable>? orderByList,
    _i1.Transaction? transaction,
    EntityTmplInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EntityTmpl>(
      where: where?.call(EntityTmpl.t),
      orderBy: orderBy?.call(EntityTmpl.t),
      orderByList: orderByList?.call(EntityTmpl.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EntityTmpl] by its [id] or null if no such row exists.
  Future<EntityTmpl?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    EntityTmplInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EntityTmpl>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EntityTmpl]s in the list and returns the inserted rows.
  ///
  /// The returned [EntityTmpl]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<EntityTmpl>> insert(
    _i1.DatabaseSession session,
    List<EntityTmpl> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<EntityTmpl>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [EntityTmpl] and returns the inserted row.
  ///
  /// The returned [EntityTmpl] will have its `id` field set.
  Future<EntityTmpl> insertRow(
    _i1.DatabaseSession session,
    EntityTmpl row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<EntityTmpl>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [EntityTmpl]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<EntityTmpl>> update(
    _i1.DatabaseSession session,
    List<EntityTmpl> rows, {
    _i1.ColumnSelections<EntityTmplTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<EntityTmpl>(
      rows,
      columns: columns?.call(EntityTmpl.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EntityTmpl]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EntityTmpl> updateRow(
    _i1.DatabaseSession session,
    EntityTmpl row, {
    _i1.ColumnSelections<EntityTmplTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<EntityTmpl>(
      row,
      columns: columns?.call(EntityTmpl.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EntityTmpl] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EntityTmpl?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<EntityTmplUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<EntityTmpl>(
      id,
      columnValues: columnValues(EntityTmpl.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EntityTmpl]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<EntityTmpl>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<EntityTmplUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<EntityTmplTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EntityTmplTable>? orderBy,
    _i1.OrderByListBuilder<EntityTmplTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<EntityTmpl>(
      columnValues: columnValues(EntityTmpl.t.updateTable),
      where: where(EntityTmpl.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EntityTmpl.t),
      orderByList: orderByList?.call(EntityTmpl.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [EntityTmpl]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<EntityTmpl>> delete(
    _i1.DatabaseSession session,
    List<EntityTmpl> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<EntityTmpl>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [EntityTmpl].
  Future<EntityTmpl> deleteRow(
    _i1.DatabaseSession session,
    EntityTmpl row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EntityTmpl>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<EntityTmpl>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<EntityTmplTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<EntityTmpl>(
      where: where(EntityTmpl.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EntityTmplTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<EntityTmpl>(
      where: where?.call(EntityTmpl.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EntityTmpl] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<EntityTmplTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EntityTmpl>(
      where: where(EntityTmpl.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class EntityTmplAttachRepository {
  const EntityTmplAttachRepository._();

  /// Creates a relation between this [EntityTmpl] and the given [EntityTmplAttribute]s
  /// by setting each [EntityTmplAttribute]'s foreign key `entityTmplId` to refer to this [EntityTmpl].
  Future<void> attributeLinks(
    _i1.DatabaseSession session,
    EntityTmpl entityTmpl,
    List<_i2.EntityTmplAttribute> entityTmplAttribute, {
    _i1.Transaction? transaction,
  }) async {
    if (entityTmplAttribute.any((e) => e.id == null)) {
      throw ArgumentError.notNull('entityTmplAttribute.id');
    }
    if (entityTmpl.id == null) {
      throw ArgumentError.notNull('entityTmpl.id');
    }

    var $entityTmplAttribute = entityTmplAttribute
        .map((e) => e.copyWith(entityTmplId: entityTmpl.id))
        .toList();
    await session.db.update<_i2.EntityTmplAttribute>(
      $entityTmplAttribute,
      columns: [_i2.EntityTmplAttribute.t.entityTmplId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [EntityTmpl] and the given [EntityTmplLink]s
  /// by setting each [EntityTmplLink]'s foreign key `sourceId` to refer to this [EntityTmpl].
  Future<void> outgoingLinks(
    _i1.DatabaseSession session,
    EntityTmpl entityTmpl,
    List<_i3.EntityTmplLink> entityTmplLink, {
    _i1.Transaction? transaction,
  }) async {
    if (entityTmplLink.any((e) => e.id == null)) {
      throw ArgumentError.notNull('entityTmplLink.id');
    }
    if (entityTmpl.id == null) {
      throw ArgumentError.notNull('entityTmpl.id');
    }

    var $entityTmplLink = entityTmplLink
        .map((e) => e.copyWith(sourceId: entityTmpl.id))
        .toList();
    await session.db.update<_i3.EntityTmplLink>(
      $entityTmplLink,
      columns: [_i3.EntityTmplLink.t.sourceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [EntityTmpl] and the given [EntityTmplLink]s
  /// by setting each [EntityTmplLink]'s foreign key `targetId` to refer to this [EntityTmpl].
  Future<void> incomingLinkTargets(
    _i1.DatabaseSession session,
    EntityTmpl entityTmpl,
    List<_i3.EntityTmplLink> entityTmplLink, {
    _i1.Transaction? transaction,
  }) async {
    if (entityTmplLink.any((e) => e.id == null)) {
      throw ArgumentError.notNull('entityTmplLink.id');
    }
    if (entityTmpl.id == null) {
      throw ArgumentError.notNull('entityTmpl.id');
    }

    var $entityTmplLink = entityTmplLink
        .map((e) => e.copyWith(targetId: entityTmpl.id))
        .toList();
    await session.db.update<_i3.EntityTmplLink>(
      $entityTmplLink,
      columns: [_i3.EntityTmplLink.t.targetId],
      transaction: transaction,
    );
  }
}

class EntityTmplAttachRowRepository {
  const EntityTmplAttachRowRepository._();

  /// Creates a relation between this [EntityTmpl] and the given [EntityTmplAttribute]
  /// by setting the [EntityTmplAttribute]'s foreign key `entityTmplId` to refer to this [EntityTmpl].
  Future<void> attributeLinks(
    _i1.DatabaseSession session,
    EntityTmpl entityTmpl,
    _i2.EntityTmplAttribute entityTmplAttribute, {
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
    await session.db.updateRow<_i2.EntityTmplAttribute>(
      $entityTmplAttribute,
      columns: [_i2.EntityTmplAttribute.t.entityTmplId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [EntityTmpl] and the given [EntityTmplLink]
  /// by setting the [EntityTmplLink]'s foreign key `sourceId` to refer to this [EntityTmpl].
  Future<void> outgoingLinks(
    _i1.DatabaseSession session,
    EntityTmpl entityTmpl,
    _i3.EntityTmplLink entityTmplLink, {
    _i1.Transaction? transaction,
  }) async {
    if (entityTmplLink.id == null) {
      throw ArgumentError.notNull('entityTmplLink.id');
    }
    if (entityTmpl.id == null) {
      throw ArgumentError.notNull('entityTmpl.id');
    }

    var $entityTmplLink = entityTmplLink.copyWith(sourceId: entityTmpl.id);
    await session.db.updateRow<_i3.EntityTmplLink>(
      $entityTmplLink,
      columns: [_i3.EntityTmplLink.t.sourceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [EntityTmpl] and the given [EntityTmplLink]
  /// by setting the [EntityTmplLink]'s foreign key `targetId` to refer to this [EntityTmpl].
  Future<void> incomingLinkTargets(
    _i1.DatabaseSession session,
    EntityTmpl entityTmpl,
    _i3.EntityTmplLink entityTmplLink, {
    _i1.Transaction? transaction,
  }) async {
    if (entityTmplLink.id == null) {
      throw ArgumentError.notNull('entityTmplLink.id');
    }
    if (entityTmpl.id == null) {
      throw ArgumentError.notNull('entityTmpl.id');
    }

    var $entityTmplLink = entityTmplLink.copyWith(targetId: entityTmpl.id);
    await session.db.updateRow<_i3.EntityTmplLink>(
      $entityTmplLink,
      columns: [_i3.EntityTmplLink.t.targetId],
      transaction: transaction,
    );
  }
}

class EntityTmplDetachRepository {
  const EntityTmplDetachRepository._();

  /// Detaches the relation between this [EntityTmpl] and the given [EntityTmplAttribute]
  /// by setting the [EntityTmplAttribute]'s foreign key `entityTmplId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> attributeLinks(
    _i1.DatabaseSession session,
    List<_i2.EntityTmplAttribute> entityTmplAttribute, {
    _i1.Transaction? transaction,
  }) async {
    if (entityTmplAttribute.any((e) => e.id == null)) {
      throw ArgumentError.notNull('entityTmplAttribute.id');
    }

    var $entityTmplAttribute = entityTmplAttribute
        .map((e) => e.copyWith(entityTmplId: null))
        .toList();
    await session.db.update<_i2.EntityTmplAttribute>(
      $entityTmplAttribute,
      columns: [_i2.EntityTmplAttribute.t.entityTmplId],
      transaction: transaction,
    );
  }
}

class EntityTmplDetachRowRepository {
  const EntityTmplDetachRowRepository._();

  /// Detaches the relation between this [EntityTmpl] and the given [EntityTmplAttribute]
  /// by setting the [EntityTmplAttribute]'s foreign key `entityTmplId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> attributeLinks(
    _i1.DatabaseSession session,
    _i2.EntityTmplAttribute entityTmplAttribute, {
    _i1.Transaction? transaction,
  }) async {
    if (entityTmplAttribute.id == null) {
      throw ArgumentError.notNull('entityTmplAttribute.id');
    }

    var $entityTmplAttribute = entityTmplAttribute.copyWith(entityTmplId: null);
    await session.db.updateRow<_i2.EntityTmplAttribute>(
      $entityTmplAttribute,
      columns: [_i2.EntityTmplAttribute.t.entityTmplId],
      transaction: transaction,
    );
  }
}
