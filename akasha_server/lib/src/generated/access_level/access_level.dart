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

abstract class AccessLevel
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AccessLevel._({
    this.id,
    required this.name,
    this.description,
  });

  factory AccessLevel({
    int? id,
    required String name,
    String? description,
  }) = _AccessLevelImpl;

  factory AccessLevel.fromJson(Map<String, dynamic> jsonSerialization) {
    return AccessLevel(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
    );
  }

  static final t = AccessLevelTable();

  static const db = AccessLevelRepository._();

  @override
  int? id;

  String name;

  String? description;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AccessLevel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AccessLevel copyWith({
    int? id,
    String? name,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AccessLevel',
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AccessLevel',
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
    };
  }

  static AccessLevelInclude include() {
    return AccessLevelInclude._();
  }

  static AccessLevelIncludeList includeList({
    _i1.WhereExpressionBuilder<AccessLevelTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccessLevelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccessLevelTable>? orderByList,
    AccessLevelInclude? include,
  }) {
    return AccessLevelIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AccessLevel.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AccessLevel.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AccessLevelImpl extends AccessLevel {
  _AccessLevelImpl({
    int? id,
    required String name,
    String? description,
  }) : super._(
         id: id,
         name: name,
         description: description,
       );

  /// Returns a shallow copy of this [AccessLevel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AccessLevel copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
  }) {
    return AccessLevel(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
    );
  }
}

class AccessLevelUpdateTable extends _i1.UpdateTable<AccessLevelTable> {
  AccessLevelUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );
}

class AccessLevelTable extends _i1.Table<int?> {
  AccessLevelTable({super.tableRelation}) : super(tableName: 'access_levels') {
    updateTable = AccessLevelUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
  }

  late final AccessLevelUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    description,
  ];
}

class AccessLevelInclude extends _i1.IncludeObject {
  AccessLevelInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AccessLevel.t;
}

class AccessLevelIncludeList extends _i1.IncludeList {
  AccessLevelIncludeList._({
    _i1.WhereExpressionBuilder<AccessLevelTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AccessLevel.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AccessLevel.t;
}

class AccessLevelRepository {
  const AccessLevelRepository._();

  /// Returns a list of [AccessLevel]s matching the given query parameters.
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
  Future<List<AccessLevel>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AccessLevelTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccessLevelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccessLevelTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AccessLevel>(
      where: where?.call(AccessLevel.t),
      orderBy: orderBy?.call(AccessLevel.t),
      orderByList: orderByList?.call(AccessLevel.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AccessLevel] matching the given query parameters.
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
  Future<AccessLevel?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AccessLevelTable>? where,
    int? offset,
    _i1.OrderByBuilder<AccessLevelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccessLevelTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AccessLevel>(
      where: where?.call(AccessLevel.t),
      orderBy: orderBy?.call(AccessLevel.t),
      orderByList: orderByList?.call(AccessLevel.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AccessLevel] by its [id] or null if no such row exists.
  Future<AccessLevel?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AccessLevel>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AccessLevel]s in the list and returns the inserted rows.
  ///
  /// The returned [AccessLevel]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AccessLevel>> insert(
    _i1.DatabaseSession session,
    List<AccessLevel> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AccessLevel>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AccessLevel] and returns the inserted row.
  ///
  /// The returned [AccessLevel] will have its `id` field set.
  Future<AccessLevel> insertRow(
    _i1.DatabaseSession session,
    AccessLevel row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AccessLevel>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AccessLevel]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AccessLevel>> update(
    _i1.DatabaseSession session,
    List<AccessLevel> rows, {
    _i1.ColumnSelections<AccessLevelTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AccessLevel>(
      rows,
      columns: columns?.call(AccessLevel.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AccessLevel]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AccessLevel> updateRow(
    _i1.DatabaseSession session,
    AccessLevel row, {
    _i1.ColumnSelections<AccessLevelTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AccessLevel>(
      row,
      columns: columns?.call(AccessLevel.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AccessLevel] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AccessLevel?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AccessLevelUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AccessLevel>(
      id,
      columnValues: columnValues(AccessLevel.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AccessLevel]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AccessLevel>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AccessLevelUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AccessLevelTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccessLevelTable>? orderBy,
    _i1.OrderByListBuilder<AccessLevelTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AccessLevel>(
      columnValues: columnValues(AccessLevel.t.updateTable),
      where: where(AccessLevel.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AccessLevel.t),
      orderByList: orderByList?.call(AccessLevel.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AccessLevel]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AccessLevel>> delete(
    _i1.DatabaseSession session,
    List<AccessLevel> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AccessLevel>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AccessLevel].
  Future<AccessLevel> deleteRow(
    _i1.DatabaseSession session,
    AccessLevel row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AccessLevel>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AccessLevel>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AccessLevelTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AccessLevel>(
      where: where(AccessLevel.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AccessLevelTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AccessLevel>(
      where: where?.call(AccessLevel.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AccessLevel] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AccessLevelTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AccessLevel>(
      where: where(AccessLevel.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
