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
import '../access_level/access_level.dart' as _i3;
import 'package:akasha_server/src/generated/protocol.dart' as _i4;

abstract class AttributeTmpl extends _i1.HasId
    implements _i2.TableRow<_i2.UuidValue?>, _i2.ProtocolSerialization {
  AttributeTmpl._({
    this.id,
    required this.name,
    this.description,
    required this.valueType,
    required this.defaultValue,
    required this.required,
    required this.accessLevelId,
    required this.accessLevel,
  });

  factory AttributeTmpl({
    _i2.UuidValue? id,
    required String name,
    String? description,
    required String valueType,
    required String defaultValue,
    required bool required,
    required int accessLevelId,
    required _i3.AccessLevel? accessLevel,
  }) = _AttributeTmplImpl;

  factory AttributeTmpl.fromJson(Map<String, dynamic> jsonSerialization) {
    return AttributeTmpl(
      id: jsonSerialization['id'] == null
          ? null
          : _i2.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      valueType: jsonSerialization['valueType'] as String,
      defaultValue: jsonSerialization['defaultValue'] as String,
      required: _i2.BoolJsonExtension.fromJson(jsonSerialization['required']),
      accessLevelId: jsonSerialization['accessLevelId'] as int,
      accessLevel: jsonSerialization['accessLevel'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.AccessLevel>(
              jsonSerialization['accessLevel'],
            ),
    );
  }

  static final t = AttributeTmplTable();

  static const db = AttributeTmplRepository._();

  @override
  _i2.UuidValue? id;

  String name;

  String? description;

  String valueType;

  String defaultValue;

  bool required;

  int accessLevelId;

  _i3.AccessLevel? accessLevel;

  @override
  _i2.Table<_i2.UuidValue?> get table => t;

  /// Returns a shallow copy of this [AttributeTmpl]
  /// with some or all fields replaced by the given arguments.
  @override
  @_i2.useResult
  AttributeTmpl copyWith({
    Object? id,
    String? name,
    String? description,
    String? valueType,
    String? defaultValue,
    bool? required,
    int? accessLevelId,
    _i3.AccessLevel? accessLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AttributeTmpl',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'valueType': valueType,
      'defaultValue': defaultValue,
      'required': required,
      'accessLevelId': accessLevelId,
      if (accessLevel != null) 'accessLevel': accessLevel?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AttributeTmpl',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'valueType': valueType,
      'defaultValue': defaultValue,
      'required': required,
      'accessLevelId': accessLevelId,
      if (accessLevel != null) 'accessLevel': accessLevel?.toJsonForProtocol(),
    };
  }

  static AttributeTmplInclude include({_i3.AccessLevelInclude? accessLevel}) {
    return AttributeTmplInclude._(accessLevel: accessLevel);
  }

  static AttributeTmplIncludeList includeList({
    _i2.WhereExpressionBuilder<AttributeTmplTable>? where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<AttributeTmplTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<AttributeTmplTable>? orderByList,
    AttributeTmplInclude? include,
  }) {
    return AttributeTmplIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AttributeTmpl.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AttributeTmpl.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i2.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AttributeTmplImpl extends AttributeTmpl {
  _AttributeTmplImpl({
    _i2.UuidValue? id,
    required String name,
    String? description,
    required String valueType,
    required String defaultValue,
    required bool required,
    required int accessLevelId,
    required _i3.AccessLevel? accessLevel,
  }) : super._(
         id: id,
         name: name,
         description: description,
         valueType: valueType,
         defaultValue: defaultValue,
         required: required,
         accessLevelId: accessLevelId,
         accessLevel: accessLevel,
       );

  /// Returns a shallow copy of this [AttributeTmpl]
  /// with some or all fields replaced by the given arguments.
  @_i2.useResult
  @override
  AttributeTmpl copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    String? valueType,
    String? defaultValue,
    bool? required,
    int? accessLevelId,
    Object? accessLevel = _Undefined,
  }) {
    return AttributeTmpl(
      id: id is _i2.UuidValue? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      valueType: valueType ?? this.valueType,
      defaultValue: defaultValue ?? this.defaultValue,
      required: required ?? this.required,
      accessLevelId: accessLevelId ?? this.accessLevelId,
      accessLevel: accessLevel is _i3.AccessLevel?
          ? accessLevel
          : this.accessLevel?.copyWith(),
    );
  }
}

class AttributeTmplUpdateTable extends _i2.UpdateTable<AttributeTmplTable> {
  AttributeTmplUpdateTable(super.table);

  _i2.ColumnValue<String, String> name(String value) => _i2.ColumnValue(
    table.name,
    value,
  );

  _i2.ColumnValue<String, String> description(String? value) => _i2.ColumnValue(
    table.description,
    value,
  );

  _i2.ColumnValue<String, String> valueType(String value) => _i2.ColumnValue(
    table.valueType,
    value,
  );

  _i2.ColumnValue<String, String> defaultValue(String value) => _i2.ColumnValue(
    table.defaultValue,
    value,
  );

  _i2.ColumnValue<bool, bool> required(bool value) => _i2.ColumnValue(
    table.required,
    value,
  );

  _i2.ColumnValue<int, int> accessLevelId(int value) => _i2.ColumnValue(
    table.accessLevelId,
    value,
  );
}

class AttributeTmplTable extends _i2.Table<_i2.UuidValue?> {
  AttributeTmplTable({super.tableRelation})
    : super(tableName: 'attribute_tmpls') {
    updateTable = AttributeTmplUpdateTable(this);
    name = _i2.ColumnString(
      'name',
      this,
    );
    description = _i2.ColumnString(
      'description',
      this,
    );
    valueType = _i2.ColumnString(
      'valueType',
      this,
    );
    defaultValue = _i2.ColumnString(
      'defaultValue',
      this,
    );
    required = _i2.ColumnBool(
      'required',
      this,
    );
    accessLevelId = _i2.ColumnInt(
      'accessLevelId',
      this,
    );
  }

  late final AttributeTmplUpdateTable updateTable;

  late final _i2.ColumnString name;

  late final _i2.ColumnString description;

  late final _i2.ColumnString valueType;

  late final _i2.ColumnString defaultValue;

  late final _i2.ColumnBool required;

  late final _i2.ColumnInt accessLevelId;

  _i3.AccessLevelTable? _accessLevel;

  _i3.AccessLevelTable get accessLevel {
    if (_accessLevel != null) return _accessLevel!;
    _accessLevel = _i2.createRelationTable(
      relationFieldName: 'accessLevel',
      field: AttributeTmpl.t.accessLevelId,
      foreignField: _i3.AccessLevel.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.AccessLevelTable(tableRelation: foreignTableRelation),
    );
    return _accessLevel!;
  }

  @override
  List<_i2.Column> get columns => [
    id,
    name,
    description,
    valueType,
    defaultValue,
    required,
    accessLevelId,
  ];

  @override
  _i2.Table? getRelationTable(String relationField) {
    if (relationField == 'accessLevel') {
      return accessLevel;
    }
    return null;
  }
}

class AttributeTmplInclude extends _i2.IncludeObject {
  AttributeTmplInclude._({_i3.AccessLevelInclude? accessLevel}) {
    _accessLevel = accessLevel;
  }

  _i3.AccessLevelInclude? _accessLevel;

  @override
  Map<String, _i2.Include?> get includes => {'accessLevel': _accessLevel};

  @override
  _i2.Table<_i2.UuidValue?> get table => AttributeTmpl.t;
}

class AttributeTmplIncludeList extends _i2.IncludeList {
  AttributeTmplIncludeList._({
    _i2.WhereExpressionBuilder<AttributeTmplTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AttributeTmpl.t);
  }

  @override
  Map<String, _i2.Include?> get includes => include?.includes ?? {};

  @override
  _i2.Table<_i2.UuidValue?> get table => AttributeTmpl.t;
}

class AttributeTmplRepository {
  const AttributeTmplRepository._();

  final attachRow = const AttributeTmplAttachRowRepository._();

  /// Returns a list of [AttributeTmpl]s matching the given query parameters.
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
  Future<List<AttributeTmpl>> find(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<AttributeTmplTable>? where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<AttributeTmplTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<AttributeTmplTable>? orderByList,
    _i2.Transaction? transaction,
    AttributeTmplInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AttributeTmpl>(
      where: where?.call(AttributeTmpl.t),
      orderBy: orderBy?.call(AttributeTmpl.t),
      orderByList: orderByList?.call(AttributeTmpl.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AttributeTmpl] matching the given query parameters.
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
  Future<AttributeTmpl?> findFirstRow(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<AttributeTmplTable>? where,
    int? offset,
    _i2.OrderByBuilder<AttributeTmplTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<AttributeTmplTable>? orderByList,
    _i2.Transaction? transaction,
    AttributeTmplInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AttributeTmpl>(
      where: where?.call(AttributeTmpl.t),
      orderBy: orderBy?.call(AttributeTmpl.t),
      orderByList: orderByList?.call(AttributeTmpl.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AttributeTmpl] by its [id] or null if no such row exists.
  Future<AttributeTmpl?> findById(
    _i2.DatabaseSession session,
    _i2.UuidValue id, {
    _i2.Transaction? transaction,
    AttributeTmplInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AttributeTmpl>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AttributeTmpl]s in the list and returns the inserted rows.
  ///
  /// The returned [AttributeTmpl]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AttributeTmpl>> insert(
    _i2.DatabaseSession session,
    List<AttributeTmpl> rows, {
    _i2.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AttributeTmpl>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AttributeTmpl] and returns the inserted row.
  ///
  /// The returned [AttributeTmpl] will have its `id` field set.
  Future<AttributeTmpl> insertRow(
    _i2.DatabaseSession session,
    AttributeTmpl row, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.insertRow<AttributeTmpl>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AttributeTmpl]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AttributeTmpl>> update(
    _i2.DatabaseSession session,
    List<AttributeTmpl> rows, {
    _i2.ColumnSelections<AttributeTmplTable>? columns,
    _i2.Transaction? transaction,
  }) async {
    return session.db.update<AttributeTmpl>(
      rows,
      columns: columns?.call(AttributeTmpl.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AttributeTmpl]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AttributeTmpl> updateRow(
    _i2.DatabaseSession session,
    AttributeTmpl row, {
    _i2.ColumnSelections<AttributeTmplTable>? columns,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateRow<AttributeTmpl>(
      row,
      columns: columns?.call(AttributeTmpl.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AttributeTmpl] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AttributeTmpl?> updateById(
    _i2.DatabaseSession session,
    _i2.UuidValue id, {
    required _i2.ColumnValueListBuilder<AttributeTmplUpdateTable> columnValues,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateById<AttributeTmpl>(
      id,
      columnValues: columnValues(AttributeTmpl.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AttributeTmpl]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AttributeTmpl>> updateWhere(
    _i2.DatabaseSession session, {
    required _i2.ColumnValueListBuilder<AttributeTmplUpdateTable> columnValues,
    required _i2.WhereExpressionBuilder<AttributeTmplTable> where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<AttributeTmplTable>? orderBy,
    _i2.OrderByListBuilder<AttributeTmplTable>? orderByList,
    bool orderDescending = false,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AttributeTmpl>(
      columnValues: columnValues(AttributeTmpl.t.updateTable),
      where: where(AttributeTmpl.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AttributeTmpl.t),
      orderByList: orderByList?.call(AttributeTmpl.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AttributeTmpl]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AttributeTmpl>> delete(
    _i2.DatabaseSession session,
    List<AttributeTmpl> rows, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.delete<AttributeTmpl>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AttributeTmpl].
  Future<AttributeTmpl> deleteRow(
    _i2.DatabaseSession session,
    AttributeTmpl row, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AttributeTmpl>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AttributeTmpl>> deleteWhere(
    _i2.DatabaseSession session, {
    required _i2.WhereExpressionBuilder<AttributeTmplTable> where,
    _i2.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AttributeTmpl>(
      where: where(AttributeTmpl.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<AttributeTmplTable>? where,
    int? limit,
    _i2.Transaction? transaction,
  }) async {
    return session.db.count<AttributeTmpl>(
      where: where?.call(AttributeTmpl.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AttributeTmpl] rows matching the [where] expression.
  Future<void> lockRows(
    _i2.DatabaseSession session, {
    required _i2.WhereExpressionBuilder<AttributeTmplTable> where,
    required _i2.LockMode lockMode,
    required _i2.Transaction transaction,
    _i2.LockBehavior lockBehavior = _i2.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AttributeTmpl>(
      where: where(AttributeTmpl.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AttributeTmplAttachRowRepository {
  const AttributeTmplAttachRowRepository._();

  /// Creates a relation between the given [AttributeTmpl] and [AccessLevel]
  /// by setting the [AttributeTmpl]'s foreign key `accessLevelId` to refer to the [AccessLevel].
  Future<void> accessLevel(
    _i2.DatabaseSession session,
    AttributeTmpl attributeTmpl,
    _i3.AccessLevel accessLevel, {
    _i2.Transaction? transaction,
  }) async {
    if (attributeTmpl.id == null) {
      throw ArgumentError.notNull('attributeTmpl.id');
    }
    if (accessLevel.id == null) {
      throw ArgumentError.notNull('accessLevel.id');
    }

    var $attributeTmpl = attributeTmpl.copyWith(accessLevelId: accessLevel.id);
    await session.db.updateRow<AttributeTmpl>(
      $attributeTmpl,
      columns: [AttributeTmpl.t.accessLevelId],
      transaction: transaction,
    );
  }
}
