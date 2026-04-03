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
import '../attribute/text_attr.dart' as _i3;
import '../attribute/number_attr.dart' as _i4;
import '../attribute/bool_attr.dart' as _i5;
import '../attribute/date_attr.dart' as _i6;
import '../attribute/datetime_attr.dart' as _i7;
import '../entity/ent_links.dart' as _i8;
import 'package:akasha_server/src/generated/protocol.dart' as _i9;

abstract class Entity extends _i1.HasId
    implements _i2.TableRow<_i2.UuidValue?>, _i2.ProtocolSerialization {
  Entity._({
    this.id,
    required this.listingAttribute,
    required this.attributesOrder,
    required this.textAttributes,
    required this.numberAttributes,
    required this.boolAttributes,
    required this.dateAttributes,
    required this.dateTimeAttributes,
    this.outgoingLinks,
    this.incomingLinks,
  });

  factory Entity({
    _i2.UuidValue? id,
    required (String, String) listingAttribute,
    required List<(int, String)> attributesOrder,
    required List<_i3.TextAttribute> textAttributes,
    required List<_i4.NumberAttribute> numberAttributes,
    required List<_i5.BoolAttribute> boolAttributes,
    required List<_i6.DateAttribute> dateAttributes,
    required List<_i7.DateTimeAttribute> dateTimeAttributes,
    List<_i8.EntityLink>? outgoingLinks,
    List<_i8.EntityLink>? incomingLinks,
  }) = _EntityImpl;

  factory Entity.fromJson(Map<String, dynamic> jsonSerialization) {
    return Entity(
      id: jsonSerialization['id'] == null
          ? null
          : _i2.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      listingAttribute: _i9.Protocol().deserialize<(String, String)>(
        (jsonSerialization['listingAttribute'] as Map<String, dynamic>),
      ),
      attributesOrder: _i9.Protocol().deserialize<List<(int, String)>>(
        jsonSerialization['attributesOrder'],
      ),
      textAttributes: _i9.Protocol().deserialize<List<_i3.TextAttribute>>(
        jsonSerialization['textAttributes'],
      ),
      numberAttributes: _i9.Protocol().deserialize<List<_i4.NumberAttribute>>(
        jsonSerialization['numberAttributes'],
      ),
      boolAttributes: _i9.Protocol().deserialize<List<_i5.BoolAttribute>>(
        jsonSerialization['boolAttributes'],
      ),
      dateAttributes: _i9.Protocol().deserialize<List<_i6.DateAttribute>>(
        jsonSerialization['dateAttributes'],
      ),
      dateTimeAttributes: _i9.Protocol()
          .deserialize<List<_i7.DateTimeAttribute>>(
            jsonSerialization['dateTimeAttributes'],
          ),
      outgoingLinks: jsonSerialization['outgoingLinks'] == null
          ? null
          : _i9.Protocol().deserialize<List<_i8.EntityLink>>(
              jsonSerialization['outgoingLinks'],
            ),
      incomingLinks: jsonSerialization['incomingLinks'] == null
          ? null
          : _i9.Protocol().deserialize<List<_i8.EntityLink>>(
              jsonSerialization['incomingLinks'],
            ),
    );
  }

  static final t = EntityTable();

  static const db = EntityRepository._();

  @override
  _i2.UuidValue? id;

  /// The attribute (the name and its value) that is presented in the listing of entities.
  (String, String) listingAttribute;

  /// The order of attributes. Each list item is a tuple of (order-idx, attribute-type).
  List<(int, String)> attributesOrder;

  List<_i3.TextAttribute> textAttributes;

  List<_i4.NumberAttribute> numberAttributes;

  List<_i5.BoolAttribute> boolAttributes;

  List<_i6.DateAttribute> dateAttributes;

  List<_i7.DateTimeAttribute> dateTimeAttributes;

  List<_i8.EntityLink>? outgoingLinks;

  List<_i8.EntityLink>? incomingLinks;

  @override
  _i2.Table<_i2.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Entity]
  /// with some or all fields replaced by the given arguments.
  @override
  @_i2.useResult
  Entity copyWith({
    Object? id,
    (String, String)? listingAttribute,
    List<(int, String)>? attributesOrder,
    List<_i3.TextAttribute>? textAttributes,
    List<_i4.NumberAttribute>? numberAttributes,
    List<_i5.BoolAttribute>? boolAttributes,
    List<_i6.DateAttribute>? dateAttributes,
    List<_i7.DateTimeAttribute>? dateTimeAttributes,
    List<_i8.EntityLink>? outgoingLinks,
    List<_i8.EntityLink>? incomingLinks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Entity',
      if (id != null) 'id': id?.toJson(),
      'listingAttribute': _i9.Protocol().mapRecordToJson(listingAttribute),
      'attributesOrder': _i9.Protocol().mapContainerToJson(attributesOrder),
      'textAttributes': textAttributes.toJson(valueToJson: (v) => v.toJson()),
      'numberAttributes': numberAttributes.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'boolAttributes': boolAttributes.toJson(valueToJson: (v) => v.toJson()),
      'dateAttributes': dateAttributes.toJson(valueToJson: (v) => v.toJson()),
      'dateTimeAttributes': dateTimeAttributes.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      if (outgoingLinks != null)
        'outgoingLinks': outgoingLinks?.toJson(valueToJson: (v) => v.toJson()),
      if (incomingLinks != null)
        'incomingLinks': incomingLinks?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Entity',
      if (id != null) 'id': id?.toJson(),
      'listingAttribute': _i9.Protocol().mapRecordToJson(listingAttribute),
      'attributesOrder': _i9.Protocol().mapContainerToJson(attributesOrder),
      'textAttributes': textAttributes.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'numberAttributes': numberAttributes.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'boolAttributes': boolAttributes.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'dateAttributes': dateAttributes.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'dateTimeAttributes': dateTimeAttributes.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      if (outgoingLinks != null)
        'outgoingLinks': outgoingLinks?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (incomingLinks != null)
        'incomingLinks': incomingLinks?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  static EntityInclude include({
    _i8.EntityLinkIncludeList? outgoingLinks,
    _i8.EntityLinkIncludeList? incomingLinks,
  }) {
    return EntityInclude._(
      outgoingLinks: outgoingLinks,
      incomingLinks: incomingLinks,
    );
  }

  static EntityIncludeList includeList({
    _i2.WhereExpressionBuilder<EntityTable>? where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<EntityTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<EntityTable>? orderByList,
    EntityInclude? include,
  }) {
    return EntityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Entity.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Entity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i2.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EntityImpl extends Entity {
  _EntityImpl({
    _i2.UuidValue? id,
    required (String, String) listingAttribute,
    required List<(int, String)> attributesOrder,
    required List<_i3.TextAttribute> textAttributes,
    required List<_i4.NumberAttribute> numberAttributes,
    required List<_i5.BoolAttribute> boolAttributes,
    required List<_i6.DateAttribute> dateAttributes,
    required List<_i7.DateTimeAttribute> dateTimeAttributes,
    List<_i8.EntityLink>? outgoingLinks,
    List<_i8.EntityLink>? incomingLinks,
  }) : super._(
         id: id,
         listingAttribute: listingAttribute,
         attributesOrder: attributesOrder,
         textAttributes: textAttributes,
         numberAttributes: numberAttributes,
         boolAttributes: boolAttributes,
         dateAttributes: dateAttributes,
         dateTimeAttributes: dateTimeAttributes,
         outgoingLinks: outgoingLinks,
         incomingLinks: incomingLinks,
       );

  /// Returns a shallow copy of this [Entity]
  /// with some or all fields replaced by the given arguments.
  @_i2.useResult
  @override
  Entity copyWith({
    Object? id = _Undefined,
    (String, String)? listingAttribute,
    List<(int, String)>? attributesOrder,
    List<_i3.TextAttribute>? textAttributes,
    List<_i4.NumberAttribute>? numberAttributes,
    List<_i5.BoolAttribute>? boolAttributes,
    List<_i6.DateAttribute>? dateAttributes,
    List<_i7.DateTimeAttribute>? dateTimeAttributes,
    Object? outgoingLinks = _Undefined,
    Object? incomingLinks = _Undefined,
  }) {
    return Entity(
      id: id is _i2.UuidValue? ? id : this.id,
      listingAttribute:
          listingAttribute ??
          (
            this.listingAttribute.$1,
            this.listingAttribute.$2,
          ),
      attributesOrder:
          attributesOrder ??
          this.attributesOrder
              .map(
                (e0) => (
                  e0.$1,
                  e0.$2,
                ),
              )
              .toList(),
      textAttributes:
          textAttributes ??
          this.textAttributes.map((e0) => e0.copyWith()).toList(),
      numberAttributes:
          numberAttributes ??
          this.numberAttributes.map((e0) => e0.copyWith()).toList(),
      boolAttributes:
          boolAttributes ??
          this.boolAttributes.map((e0) => e0.copyWith()).toList(),
      dateAttributes:
          dateAttributes ??
          this.dateAttributes.map((e0) => e0.copyWith()).toList(),
      dateTimeAttributes:
          dateTimeAttributes ??
          this.dateTimeAttributes.map((e0) => e0.copyWith()).toList(),
      outgoingLinks: outgoingLinks is List<_i8.EntityLink>?
          ? outgoingLinks
          : this.outgoingLinks?.map((e0) => e0.copyWith()).toList(),
      incomingLinks: incomingLinks is List<_i8.EntityLink>?
          ? incomingLinks
          : this.incomingLinks?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class EntityUpdateTable extends _i2.UpdateTable<EntityTable> {
  EntityUpdateTable(super.table);

  _i2.ColumnValue<(String, String), Map<String, dynamic>?> listingAttribute(
    (String, String) value,
  ) => _i2.ColumnValue(
    table.listingAttribute,
    _i9.Protocol().mapRecordToJson(value),
  );

  _i2.ColumnValue<List<(int, String)>, List<(int, String)>> attributesOrder(
    List<(int, String)> value,
  ) => _i2.ColumnValue(
    table.attributesOrder,
    value,
  );

  _i2.ColumnValue<List<_i3.TextAttribute>, List<_i3.TextAttribute>>
  textAttributes(List<_i3.TextAttribute> value) => _i2.ColumnValue(
    table.textAttributes,
    value,
  );

  _i2.ColumnValue<List<_i4.NumberAttribute>, List<_i4.NumberAttribute>>
  numberAttributes(List<_i4.NumberAttribute> value) => _i2.ColumnValue(
    table.numberAttributes,
    value,
  );

  _i2.ColumnValue<List<_i5.BoolAttribute>, List<_i5.BoolAttribute>>
  boolAttributes(List<_i5.BoolAttribute> value) => _i2.ColumnValue(
    table.boolAttributes,
    value,
  );

  _i2.ColumnValue<List<_i6.DateAttribute>, List<_i6.DateAttribute>>
  dateAttributes(List<_i6.DateAttribute> value) => _i2.ColumnValue(
    table.dateAttributes,
    value,
  );

  _i2.ColumnValue<List<_i7.DateTimeAttribute>, List<_i7.DateTimeAttribute>>
  dateTimeAttributes(List<_i7.DateTimeAttribute> value) => _i2.ColumnValue(
    table.dateTimeAttributes,
    value,
  );
}

class EntityTable extends _i2.Table<_i2.UuidValue?> {
  EntityTable({super.tableRelation}) : super(tableName: 'entities') {
    updateTable = EntityUpdateTable(this);
    listingAttribute = _i2.ColumnSerializable<(String, String)>(
      'listingAttribute',
      this,
    );
    attributesOrder = _i2.ColumnSerializable<List<(int, String)>>(
      'attributesOrder',
      this,
    );
    textAttributes = _i2.ColumnSerializable<List<_i3.TextAttribute>>(
      'textAttributes',
      this,
    );
    numberAttributes = _i2.ColumnSerializable<List<_i4.NumberAttribute>>(
      'numberAttributes',
      this,
    );
    boolAttributes = _i2.ColumnSerializable<List<_i5.BoolAttribute>>(
      'boolAttributes',
      this,
    );
    dateAttributes = _i2.ColumnSerializable<List<_i6.DateAttribute>>(
      'dateAttributes',
      this,
    );
    dateTimeAttributes = _i2.ColumnSerializable<List<_i7.DateTimeAttribute>>(
      'dateTimeAttributes',
      this,
    );
  }

  late final EntityUpdateTable updateTable;

  /// The attribute (the name and its value) that is presented in the listing of entities.
  late final _i2.ColumnSerializable<(String, String)> listingAttribute;

  /// The order of attributes. Each list item is a tuple of (order-idx, attribute-type).
  late final _i2.ColumnSerializable<List<(int, String)>> attributesOrder;

  late final _i2.ColumnSerializable<List<_i3.TextAttribute>> textAttributes;

  late final _i2.ColumnSerializable<List<_i4.NumberAttribute>> numberAttributes;

  late final _i2.ColumnSerializable<List<_i5.BoolAttribute>> boolAttributes;

  late final _i2.ColumnSerializable<List<_i6.DateAttribute>> dateAttributes;

  late final _i2.ColumnSerializable<List<_i7.DateTimeAttribute>>
  dateTimeAttributes;

  _i8.EntityLinkTable? ___outgoingLinks;

  _i2.ManyRelation<_i8.EntityLinkTable>? _outgoingLinks;

  _i8.EntityLinkTable? ___incomingLinks;

  _i2.ManyRelation<_i8.EntityLinkTable>? _incomingLinks;

  _i8.EntityLinkTable get __outgoingLinks {
    if (___outgoingLinks != null) return ___outgoingLinks!;
    ___outgoingLinks = _i2.createRelationTable(
      relationFieldName: '__outgoingLinks',
      field: Entity.t.id,
      foreignField: _i8.EntityLink.t.sourceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8.EntityLinkTable(tableRelation: foreignTableRelation),
    );
    return ___outgoingLinks!;
  }

  _i8.EntityLinkTable get __incomingLinks {
    if (___incomingLinks != null) return ___incomingLinks!;
    ___incomingLinks = _i2.createRelationTable(
      relationFieldName: '__incomingLinks',
      field: Entity.t.id,
      foreignField: _i8.EntityLink.t.targetId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8.EntityLinkTable(tableRelation: foreignTableRelation),
    );
    return ___incomingLinks!;
  }

  _i2.ManyRelation<_i8.EntityLinkTable> get outgoingLinks {
    if (_outgoingLinks != null) return _outgoingLinks!;
    var relationTable = _i2.createRelationTable(
      relationFieldName: 'outgoingLinks',
      field: Entity.t.id,
      foreignField: _i8.EntityLink.t.sourceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8.EntityLinkTable(tableRelation: foreignTableRelation),
    );
    _outgoingLinks = _i2.ManyRelation<_i8.EntityLinkTable>(
      tableWithRelations: relationTable,
      table: _i8.EntityLinkTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _outgoingLinks!;
  }

  _i2.ManyRelation<_i8.EntityLinkTable> get incomingLinks {
    if (_incomingLinks != null) return _incomingLinks!;
    var relationTable = _i2.createRelationTable(
      relationFieldName: 'incomingLinks',
      field: Entity.t.id,
      foreignField: _i8.EntityLink.t.targetId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8.EntityLinkTable(tableRelation: foreignTableRelation),
    );
    _incomingLinks = _i2.ManyRelation<_i8.EntityLinkTable>(
      tableWithRelations: relationTable,
      table: _i8.EntityLinkTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _incomingLinks!;
  }

  @override
  List<_i2.Column> get columns => [
    id,
    listingAttribute,
    attributesOrder,
    textAttributes,
    numberAttributes,
    boolAttributes,
    dateAttributes,
    dateTimeAttributes,
  ];

  @override
  _i2.Table? getRelationTable(String relationField) {
    if (relationField == 'outgoingLinks') {
      return __outgoingLinks;
    }
    if (relationField == 'incomingLinks') {
      return __incomingLinks;
    }
    return null;
  }
}

class EntityInclude extends _i2.IncludeObject {
  EntityInclude._({
    _i8.EntityLinkIncludeList? outgoingLinks,
    _i8.EntityLinkIncludeList? incomingLinks,
  }) {
    _outgoingLinks = outgoingLinks;
    _incomingLinks = incomingLinks;
  }

  _i8.EntityLinkIncludeList? _outgoingLinks;

  _i8.EntityLinkIncludeList? _incomingLinks;

  @override
  Map<String, _i2.Include?> get includes => {
    'outgoingLinks': _outgoingLinks,
    'incomingLinks': _incomingLinks,
  };

  @override
  _i2.Table<_i2.UuidValue?> get table => Entity.t;
}

class EntityIncludeList extends _i2.IncludeList {
  EntityIncludeList._({
    _i2.WhereExpressionBuilder<EntityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Entity.t);
  }

  @override
  Map<String, _i2.Include?> get includes => include?.includes ?? {};

  @override
  _i2.Table<_i2.UuidValue?> get table => Entity.t;
}

class EntityRepository {
  const EntityRepository._();

  final attach = const EntityAttachRepository._();

  final attachRow = const EntityAttachRowRepository._();

  final detach = const EntityDetachRepository._();

  final detachRow = const EntityDetachRowRepository._();

  /// Returns a list of [Entity]s matching the given query parameters.
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
  Future<List<Entity>> find(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<EntityTable>? where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<EntityTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<EntityTable>? orderByList,
    _i2.Transaction? transaction,
    EntityInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Entity>(
      where: where?.call(Entity.t),
      orderBy: orderBy?.call(Entity.t),
      orderByList: orderByList?.call(Entity.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Entity] matching the given query parameters.
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
  Future<Entity?> findFirstRow(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<EntityTable>? where,
    int? offset,
    _i2.OrderByBuilder<EntityTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<EntityTable>? orderByList,
    _i2.Transaction? transaction,
    EntityInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Entity>(
      where: where?.call(Entity.t),
      orderBy: orderBy?.call(Entity.t),
      orderByList: orderByList?.call(Entity.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Entity] by its [id] or null if no such row exists.
  Future<Entity?> findById(
    _i2.DatabaseSession session,
    _i2.UuidValue id, {
    _i2.Transaction? transaction,
    EntityInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Entity>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Entity]s in the list and returns the inserted rows.
  ///
  /// The returned [Entity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Entity>> insert(
    _i2.DatabaseSession session,
    List<Entity> rows, {
    _i2.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Entity>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Entity] and returns the inserted row.
  ///
  /// The returned [Entity] will have its `id` field set.
  Future<Entity> insertRow(
    _i2.DatabaseSession session,
    Entity row, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.insertRow<Entity>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Entity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Entity>> update(
    _i2.DatabaseSession session,
    List<Entity> rows, {
    _i2.ColumnSelections<EntityTable>? columns,
    _i2.Transaction? transaction,
  }) async {
    return session.db.update<Entity>(
      rows,
      columns: columns?.call(Entity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Entity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Entity> updateRow(
    _i2.DatabaseSession session,
    Entity row, {
    _i2.ColumnSelections<EntityTable>? columns,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateRow<Entity>(
      row,
      columns: columns?.call(Entity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Entity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Entity?> updateById(
    _i2.DatabaseSession session,
    _i2.UuidValue id, {
    required _i2.ColumnValueListBuilder<EntityUpdateTable> columnValues,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateById<Entity>(
      id,
      columnValues: columnValues(Entity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Entity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Entity>> updateWhere(
    _i2.DatabaseSession session, {
    required _i2.ColumnValueListBuilder<EntityUpdateTable> columnValues,
    required _i2.WhereExpressionBuilder<EntityTable> where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<EntityTable>? orderBy,
    _i2.OrderByListBuilder<EntityTable>? orderByList,
    bool orderDescending = false,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Entity>(
      columnValues: columnValues(Entity.t.updateTable),
      where: where(Entity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Entity.t),
      orderByList: orderByList?.call(Entity.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Entity]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Entity>> delete(
    _i2.DatabaseSession session,
    List<Entity> rows, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.delete<Entity>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Entity].
  Future<Entity> deleteRow(
    _i2.DatabaseSession session,
    Entity row, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Entity>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Entity>> deleteWhere(
    _i2.DatabaseSession session, {
    required _i2.WhereExpressionBuilder<EntityTable> where,
    _i2.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Entity>(
      where: where(Entity.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<EntityTable>? where,
    int? limit,
    _i2.Transaction? transaction,
  }) async {
    return session.db.count<Entity>(
      where: where?.call(Entity.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Entity] rows matching the [where] expression.
  Future<void> lockRows(
    _i2.DatabaseSession session, {
    required _i2.WhereExpressionBuilder<EntityTable> where,
    required _i2.LockMode lockMode,
    required _i2.Transaction transaction,
    _i2.LockBehavior lockBehavior = _i2.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Entity>(
      where: where(Entity.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class EntityAttachRepository {
  const EntityAttachRepository._();

  /// Creates a relation between this [Entity] and the given [EntityLink]s
  /// by setting each [EntityLink]'s foreign key `sourceId` to refer to this [Entity].
  Future<void> outgoingLinks(
    _i2.DatabaseSession session,
    Entity entity,
    List<_i8.EntityLink> entityLink, {
    _i2.Transaction? transaction,
  }) async {
    if (entityLink.any((e) => e.id == null)) {
      throw ArgumentError.notNull('entityLink.id');
    }
    if (entity.id == null) {
      throw ArgumentError.notNull('entity.id');
    }

    var $entityLink = entityLink
        .map((e) => e.copyWith(sourceId: entity.id))
        .toList();
    await session.db.update<_i8.EntityLink>(
      $entityLink,
      columns: [_i8.EntityLink.t.sourceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Entity] and the given [EntityLink]s
  /// by setting each [EntityLink]'s foreign key `targetId` to refer to this [Entity].
  Future<void> incomingLinks(
    _i2.DatabaseSession session,
    Entity entity,
    List<_i8.EntityLink> entityLink, {
    _i2.Transaction? transaction,
  }) async {
    if (entityLink.any((e) => e.id == null)) {
      throw ArgumentError.notNull('entityLink.id');
    }
    if (entity.id == null) {
      throw ArgumentError.notNull('entity.id');
    }

    var $entityLink = entityLink
        .map((e) => e.copyWith(targetId: entity.id))
        .toList();
    await session.db.update<_i8.EntityLink>(
      $entityLink,
      columns: [_i8.EntityLink.t.targetId],
      transaction: transaction,
    );
  }
}

class EntityAttachRowRepository {
  const EntityAttachRowRepository._();

  /// Creates a relation between this [Entity] and the given [EntityLink]
  /// by setting the [EntityLink]'s foreign key `sourceId` to refer to this [Entity].
  Future<void> outgoingLinks(
    _i2.DatabaseSession session,
    Entity entity,
    _i8.EntityLink entityLink, {
    _i2.Transaction? transaction,
  }) async {
    if (entityLink.id == null) {
      throw ArgumentError.notNull('entityLink.id');
    }
    if (entity.id == null) {
      throw ArgumentError.notNull('entity.id');
    }

    var $entityLink = entityLink.copyWith(sourceId: entity.id);
    await session.db.updateRow<_i8.EntityLink>(
      $entityLink,
      columns: [_i8.EntityLink.t.sourceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Entity] and the given [EntityLink]
  /// by setting the [EntityLink]'s foreign key `targetId` to refer to this [Entity].
  Future<void> incomingLinks(
    _i2.DatabaseSession session,
    Entity entity,
    _i8.EntityLink entityLink, {
    _i2.Transaction? transaction,
  }) async {
    if (entityLink.id == null) {
      throw ArgumentError.notNull('entityLink.id');
    }
    if (entity.id == null) {
      throw ArgumentError.notNull('entity.id');
    }

    var $entityLink = entityLink.copyWith(targetId: entity.id);
    await session.db.updateRow<_i8.EntityLink>(
      $entityLink,
      columns: [_i8.EntityLink.t.targetId],
      transaction: transaction,
    );
  }
}

class EntityDetachRepository {
  const EntityDetachRepository._();

  /// Detaches the relation between this [Entity] and the given [EntityLink]
  /// by setting the [EntityLink]'s foreign key `sourceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> outgoingLinks(
    _i2.DatabaseSession session,
    List<_i8.EntityLink> entityLink, {
    _i2.Transaction? transaction,
  }) async {
    if (entityLink.any((e) => e.id == null)) {
      throw ArgumentError.notNull('entityLink.id');
    }

    var $entityLink = entityLink
        .map((e) => e.copyWith(sourceId: null))
        .toList();
    await session.db.update<_i8.EntityLink>(
      $entityLink,
      columns: [_i8.EntityLink.t.sourceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Entity] and the given [EntityLink]
  /// by setting the [EntityLink]'s foreign key `targetId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> incomingLinks(
    _i2.DatabaseSession session,
    List<_i8.EntityLink> entityLink, {
    _i2.Transaction? transaction,
  }) async {
    if (entityLink.any((e) => e.id == null)) {
      throw ArgumentError.notNull('entityLink.id');
    }

    var $entityLink = entityLink
        .map((e) => e.copyWith(targetId: null))
        .toList();
    await session.db.update<_i8.EntityLink>(
      $entityLink,
      columns: [_i8.EntityLink.t.targetId],
      transaction: transaction,
    );
  }
}

class EntityDetachRowRepository {
  const EntityDetachRowRepository._();

  /// Detaches the relation between this [Entity] and the given [EntityLink]
  /// by setting the [EntityLink]'s foreign key `sourceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> outgoingLinks(
    _i2.DatabaseSession session,
    _i8.EntityLink entityLink, {
    _i2.Transaction? transaction,
  }) async {
    if (entityLink.id == null) {
      throw ArgumentError.notNull('entityLink.id');
    }

    var $entityLink = entityLink.copyWith(sourceId: null);
    await session.db.updateRow<_i8.EntityLink>(
      $entityLink,
      columns: [_i8.EntityLink.t.sourceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Entity] and the given [EntityLink]
  /// by setting the [EntityLink]'s foreign key `targetId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> incomingLinks(
    _i2.DatabaseSession session,
    _i8.EntityLink entityLink, {
    _i2.Transaction? transaction,
  }) async {
    if (entityLink.id == null) {
      throw ArgumentError.notNull('entityLink.id');
    }

    var $entityLink = entityLink.copyWith(targetId: null);
    await session.db.updateRow<_i8.EntityLink>(
      $entityLink,
      columns: [_i8.EntityLink.t.targetId],
      transaction: transaction,
    );
  }
}
