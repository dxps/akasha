/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class AttributeTmpl
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  AttributeTmpl._({
    this.id,
    required this.name,
    this.description,
    required this.valueType,
    required this.defaultValue,
    required this.required,
  });

  factory AttributeTmpl({
    _i1.UuidValue? id,
    required String name,
    String? description,
    required String valueType,
    required String defaultValue,
    required bool required,
  }) = _AttributeTmplImpl;

  factory AttributeTmpl.fromJson(Map<String, dynamic> jsonSerialization) {
    return AttributeTmpl(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      valueType: jsonSerialization['valueType'] as String,
      defaultValue: jsonSerialization['defaultValue'] as String,
      required: _i1.BoolJsonExtension.fromJson(jsonSerialization['required']),
    );
  }

  static final t = AttributeTmplTable();

  static const db = AttributeTmplRepository._();

  @override
  _i1.UuidValue? id;

  String name;

  String? description;

  String valueType;

  String defaultValue;

  bool required;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [AttributeTmpl]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AttributeTmpl copyWith({
    _i1.UuidValue? id,
    String? name,
    String? description,
    String? valueType,
    String? defaultValue,
    bool? required,
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
    };
  }

  static AttributeTmplInclude include() {
    return AttributeTmplInclude._();
  }

  static AttributeTmplIncludeList includeList({
    _i1.WhereExpressionBuilder<AttributeTmplTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AttributeTmplTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AttributeTmplTable>? orderByList,
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
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AttributeTmplImpl extends AttributeTmpl {
  _AttributeTmplImpl({
    _i1.UuidValue? id,
    required String name,
    String? description,
    required String valueType,
    required String defaultValue,
    required bool required,
  }) : super._(
         id: id,
         name: name,
         description: description,
         valueType: valueType,
         defaultValue: defaultValue,
         required: required,
       );

  /// Returns a shallow copy of this [AttributeTmpl]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AttributeTmpl copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    String? valueType,
    String? defaultValue,
    bool? required,
  }) {
    return AttributeTmpl(
      id: id is _i1.UuidValue? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      valueType: valueType ?? this.valueType,
      defaultValue: defaultValue ?? this.defaultValue,
      required: required ?? this.required,
    );
  }
}

class AttributeTmplUpdateTable extends _i1.UpdateTable<AttributeTmplTable> {
  AttributeTmplUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> valueType(String value) => _i1.ColumnValue(
    table.valueType,
    value,
  );

  _i1.ColumnValue<String, String> defaultValue(String value) => _i1.ColumnValue(
    table.defaultValue,
    value,
  );

  _i1.ColumnValue<bool, bool> required(bool value) => _i1.ColumnValue(
    table.required,
    value,
  );
}

class AttributeTmplTable extends _i1.Table<_i1.UuidValue?> {
  AttributeTmplTable({super.tableRelation})
    : super(tableName: 'attributes_tmpls') {
    updateTable = AttributeTmplUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    valueType = _i1.ColumnString(
      'valueType',
      this,
    );
    defaultValue = _i1.ColumnString(
      'defaultValue',
      this,
    );
    required = _i1.ColumnBool(
      'required',
      this,
    );
  }

  late final AttributeTmplUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString valueType;

  late final _i1.ColumnString defaultValue;

  late final _i1.ColumnBool required;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    description,
    valueType,
    defaultValue,
    required,
  ];
}

class AttributeTmplInclude extends _i1.IncludeObject {
  AttributeTmplInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => AttributeTmpl.t;
}

class AttributeTmplIncludeList extends _i1.IncludeList {
  AttributeTmplIncludeList._({
    _i1.WhereExpressionBuilder<AttributeTmplTable>? where,
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
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => AttributeTmpl.t;
}

class AttributeTmplRepository {
  const AttributeTmplRepository._();

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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AttributeTmplTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AttributeTmplTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AttributeTmplTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AttributeTmpl>(
      where: where?.call(AttributeTmpl.t),
      orderBy: orderBy?.call(AttributeTmpl.t),
      orderByList: orderByList?.call(AttributeTmpl.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AttributeTmplTable>? where,
    int? offset,
    _i1.OrderByBuilder<AttributeTmplTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AttributeTmplTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AttributeTmpl>(
      where: where?.call(AttributeTmpl.t),
      orderBy: orderBy?.call(AttributeTmpl.t),
      orderByList: orderByList?.call(AttributeTmpl.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AttributeTmpl] by its [id] or null if no such row exists.
  Future<AttributeTmpl?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AttributeTmpl>(
      id,
      transaction: transaction,
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
    _i1.DatabaseSession session,
    List<AttributeTmpl> rows, {
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    AttributeTmpl row, {
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    List<AttributeTmpl> rows, {
    _i1.ColumnSelections<AttributeTmplTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    AttributeTmpl row, {
    _i1.ColumnSelections<AttributeTmplTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<AttributeTmplUpdateTable> columnValues,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AttributeTmplUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AttributeTmplTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AttributeTmplTable>? orderBy,
    _i1.OrderByListBuilder<AttributeTmplTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    List<AttributeTmpl> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AttributeTmpl>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AttributeTmpl].
  Future<AttributeTmpl> deleteRow(
    _i1.DatabaseSession session,
    AttributeTmpl row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AttributeTmpl>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AttributeTmpl>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AttributeTmplTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AttributeTmpl>(
      where: where(AttributeTmpl.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AttributeTmplTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AttributeTmpl>(
      where: where?.call(AttributeTmpl.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AttributeTmpl] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AttributeTmplTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AttributeTmpl>(
      where: where(AttributeTmpl.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
