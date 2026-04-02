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
import '../shared/model/value_type.dart' as _i3;
import '../access_level/access_level.dart' as _i4;
import 'package:akasha_server/src/generated/protocol.dart' as _i5;

/// An attribute whose value is a number.
abstract class NumberAttribute extends _i1.Attribute
    implements _i2.TableRow<_i2.UuidValue?>, _i2.ProtocolSerialization {
  NumberAttribute._({
    this.id,
    required super.name,
    super.description,
    required super.valueType,
    required this.value,
    required this.accessLevelId,
    required this.accessLevel,
  });

  factory NumberAttribute({
    _i2.UuidValue? id,
    required String name,
    String? description,
    required _i3.ValueType valueType,
    required double value,
    required int accessLevelId,
    required _i4.AccessLevel? accessLevel,
  }) = _NumberAttributeImpl;

  factory NumberAttribute.fromJson(Map<String, dynamic> jsonSerialization) {
    return NumberAttribute(
      id: jsonSerialization['id'] == null
          ? null
          : _i2.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      valueType: _i3.ValueType.fromJson(
        (jsonSerialization['valueType'] as String),
      ),
      value: (jsonSerialization['value'] as num).toDouble(),
      accessLevelId: jsonSerialization['accessLevelId'] as int,
      accessLevel: jsonSerialization['accessLevel'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.AccessLevel>(
              jsonSerialization['accessLevel'],
            ),
    );
  }

  static final t = NumberAttributeTable();

  static const db = NumberAttributeRepository._();

  @override
  _i2.UuidValue? id;

  double value;

  int accessLevelId;

  _i4.AccessLevel? accessLevel;

  @override
  _i2.Table<_i2.UuidValue?> get table => t;

  /// Returns a shallow copy of this [NumberAttribute]
  /// with some or all fields replaced by the given arguments.
  @override
  @_i2.useResult
  NumberAttribute copyWith({
    Object? id,
    String? name,
    Object? description,
    _i3.ValueType? valueType,
    double? value,
    int? accessLevelId,
    _i4.AccessLevel? accessLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NumberAttribute',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'valueType': valueType.toJson(),
      'value': value,
      'accessLevelId': accessLevelId,
      if (accessLevel != null) 'accessLevel': accessLevel?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NumberAttribute',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'valueType': valueType.toJson(),
      'value': value,
      'accessLevelId': accessLevelId,
      if (accessLevel != null) 'accessLevel': accessLevel?.toJsonForProtocol(),
    };
  }

  static NumberAttributeInclude include({_i4.AccessLevelInclude? accessLevel}) {
    return NumberAttributeInclude._(accessLevel: accessLevel);
  }

  static NumberAttributeIncludeList includeList({
    _i2.WhereExpressionBuilder<NumberAttributeTable>? where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<NumberAttributeTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<NumberAttributeTable>? orderByList,
    NumberAttributeInclude? include,
  }) {
    return NumberAttributeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NumberAttribute.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(NumberAttribute.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i2.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NumberAttributeImpl extends NumberAttribute {
  _NumberAttributeImpl({
    _i2.UuidValue? id,
    required String name,
    String? description,
    required _i3.ValueType valueType,
    required double value,
    required int accessLevelId,
    required _i4.AccessLevel? accessLevel,
  }) : super._(
         id: id,
         name: name,
         description: description,
         valueType: valueType,
         value: value,
         accessLevelId: accessLevelId,
         accessLevel: accessLevel,
       );

  /// Returns a shallow copy of this [NumberAttribute]
  /// with some or all fields replaced by the given arguments.
  @_i2.useResult
  @override
  NumberAttribute copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    _i3.ValueType? valueType,
    double? value,
    int? accessLevelId,
    Object? accessLevel = _Undefined,
  }) {
    return NumberAttribute(
      id: id is _i2.UuidValue? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      valueType: valueType ?? this.valueType,
      value: value ?? this.value,
      accessLevelId: accessLevelId ?? this.accessLevelId,
      accessLevel: accessLevel is _i4.AccessLevel?
          ? accessLevel
          : this.accessLevel?.copyWith(),
    );
  }
}

class NumberAttributeUpdateTable extends _i2.UpdateTable<NumberAttributeTable> {
  NumberAttributeUpdateTable(super.table);

  _i2.ColumnValue<String, String> name(String value) => _i2.ColumnValue(
    table.name,
    value,
  );

  _i2.ColumnValue<String, String> description(String? value) => _i2.ColumnValue(
    table.description,
    value,
  );

  _i2.ColumnValue<_i3.ValueType, _i3.ValueType> valueType(
    _i3.ValueType value,
  ) => _i2.ColumnValue(
    table.valueType,
    value,
  );

  _i2.ColumnValue<double, double> value(double value) => _i2.ColumnValue(
    table.value,
    value,
  );

  _i2.ColumnValue<int, int> accessLevelId(int value) => _i2.ColumnValue(
    table.accessLevelId,
    value,
  );
}

class NumberAttributeTable extends _i2.Table<_i2.UuidValue?> {
  NumberAttributeTable({super.tableRelation})
    : super(tableName: 'number_attributes') {
    updateTable = NumberAttributeUpdateTable(this);
    name = _i2.ColumnString(
      'name',
      this,
    );
    description = _i2.ColumnString(
      'description',
      this,
    );
    valueType = _i2.ColumnEnum(
      'valueType',
      this,
      _i2.EnumSerialization.byName,
    );
    value = _i2.ColumnDouble(
      'value',
      this,
    );
    accessLevelId = _i2.ColumnInt(
      'accessLevelId',
      this,
    );
  }

  late final NumberAttributeUpdateTable updateTable;

  late final _i2.ColumnString name;

  late final _i2.ColumnString description;

  late final _i2.ColumnEnum<_i3.ValueType> valueType;

  late final _i2.ColumnDouble value;

  late final _i2.ColumnInt accessLevelId;

  _i4.AccessLevelTable? _accessLevel;

  _i4.AccessLevelTable get accessLevel {
    if (_accessLevel != null) return _accessLevel!;
    _accessLevel = _i2.createRelationTable(
      relationFieldName: 'accessLevel',
      field: NumberAttribute.t.accessLevelId,
      foreignField: _i4.AccessLevel.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.AccessLevelTable(tableRelation: foreignTableRelation),
    );
    return _accessLevel!;
  }

  @override
  List<_i2.Column> get columns => [
    id,
    name,
    description,
    valueType,
    value,
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

class NumberAttributeInclude extends _i2.IncludeObject {
  NumberAttributeInclude._({_i4.AccessLevelInclude? accessLevel}) {
    _accessLevel = accessLevel;
  }

  _i4.AccessLevelInclude? _accessLevel;

  @override
  Map<String, _i2.Include?> get includes => {'accessLevel': _accessLevel};

  @override
  _i2.Table<_i2.UuidValue?> get table => NumberAttribute.t;
}

class NumberAttributeIncludeList extends _i2.IncludeList {
  NumberAttributeIncludeList._({
    _i2.WhereExpressionBuilder<NumberAttributeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(NumberAttribute.t);
  }

  @override
  Map<String, _i2.Include?> get includes => include?.includes ?? {};

  @override
  _i2.Table<_i2.UuidValue?> get table => NumberAttribute.t;
}

class NumberAttributeRepository {
  const NumberAttributeRepository._();

  final attachRow = const NumberAttributeAttachRowRepository._();

  /// Returns a list of [NumberAttribute]s matching the given query parameters.
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
  Future<List<NumberAttribute>> find(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<NumberAttributeTable>? where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<NumberAttributeTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<NumberAttributeTable>? orderByList,
    _i2.Transaction? transaction,
    NumberAttributeInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<NumberAttribute>(
      where: where?.call(NumberAttribute.t),
      orderBy: orderBy?.call(NumberAttribute.t),
      orderByList: orderByList?.call(NumberAttribute.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [NumberAttribute] matching the given query parameters.
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
  Future<NumberAttribute?> findFirstRow(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<NumberAttributeTable>? where,
    int? offset,
    _i2.OrderByBuilder<NumberAttributeTable>? orderBy,
    bool orderDescending = false,
    _i2.OrderByListBuilder<NumberAttributeTable>? orderByList,
    _i2.Transaction? transaction,
    NumberAttributeInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<NumberAttribute>(
      where: where?.call(NumberAttribute.t),
      orderBy: orderBy?.call(NumberAttribute.t),
      orderByList: orderByList?.call(NumberAttribute.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [NumberAttribute] by its [id] or null if no such row exists.
  Future<NumberAttribute?> findById(
    _i2.DatabaseSession session,
    _i2.UuidValue id, {
    _i2.Transaction? transaction,
    NumberAttributeInclude? include,
    _i2.LockMode? lockMode,
    _i2.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<NumberAttribute>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [NumberAttribute]s in the list and returns the inserted rows.
  ///
  /// The returned [NumberAttribute]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<NumberAttribute>> insert(
    _i2.DatabaseSession session,
    List<NumberAttribute> rows, {
    _i2.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<NumberAttribute>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [NumberAttribute] and returns the inserted row.
  ///
  /// The returned [NumberAttribute] will have its `id` field set.
  Future<NumberAttribute> insertRow(
    _i2.DatabaseSession session,
    NumberAttribute row, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.insertRow<NumberAttribute>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [NumberAttribute]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<NumberAttribute>> update(
    _i2.DatabaseSession session,
    List<NumberAttribute> rows, {
    _i2.ColumnSelections<NumberAttributeTable>? columns,
    _i2.Transaction? transaction,
  }) async {
    return session.db.update<NumberAttribute>(
      rows,
      columns: columns?.call(NumberAttribute.t),
      transaction: transaction,
    );
  }

  /// Updates a single [NumberAttribute]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<NumberAttribute> updateRow(
    _i2.DatabaseSession session,
    NumberAttribute row, {
    _i2.ColumnSelections<NumberAttributeTable>? columns,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateRow<NumberAttribute>(
      row,
      columns: columns?.call(NumberAttribute.t),
      transaction: transaction,
    );
  }

  /// Updates a single [NumberAttribute] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<NumberAttribute?> updateById(
    _i2.DatabaseSession session,
    _i2.UuidValue id, {
    required _i2.ColumnValueListBuilder<NumberAttributeUpdateTable>
    columnValues,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateById<NumberAttribute>(
      id,
      columnValues: columnValues(NumberAttribute.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [NumberAttribute]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<NumberAttribute>> updateWhere(
    _i2.DatabaseSession session, {
    required _i2.ColumnValueListBuilder<NumberAttributeUpdateTable>
    columnValues,
    required _i2.WhereExpressionBuilder<NumberAttributeTable> where,
    int? limit,
    int? offset,
    _i2.OrderByBuilder<NumberAttributeTable>? orderBy,
    _i2.OrderByListBuilder<NumberAttributeTable>? orderByList,
    bool orderDescending = false,
    _i2.Transaction? transaction,
  }) async {
    return session.db.updateWhere<NumberAttribute>(
      columnValues: columnValues(NumberAttribute.t.updateTable),
      where: where(NumberAttribute.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NumberAttribute.t),
      orderByList: orderByList?.call(NumberAttribute.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [NumberAttribute]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<NumberAttribute>> delete(
    _i2.DatabaseSession session,
    List<NumberAttribute> rows, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.delete<NumberAttribute>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [NumberAttribute].
  Future<NumberAttribute> deleteRow(
    _i2.DatabaseSession session,
    NumberAttribute row, {
    _i2.Transaction? transaction,
  }) async {
    return session.db.deleteRow<NumberAttribute>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<NumberAttribute>> deleteWhere(
    _i2.DatabaseSession session, {
    required _i2.WhereExpressionBuilder<NumberAttributeTable> where,
    _i2.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<NumberAttribute>(
      where: where(NumberAttribute.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i2.DatabaseSession session, {
    _i2.WhereExpressionBuilder<NumberAttributeTable>? where,
    int? limit,
    _i2.Transaction? transaction,
  }) async {
    return session.db.count<NumberAttribute>(
      where: where?.call(NumberAttribute.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [NumberAttribute] rows matching the [where] expression.
  Future<void> lockRows(
    _i2.DatabaseSession session, {
    required _i2.WhereExpressionBuilder<NumberAttributeTable> where,
    required _i2.LockMode lockMode,
    required _i2.Transaction transaction,
    _i2.LockBehavior lockBehavior = _i2.LockBehavior.wait,
  }) async {
    return session.db.lockRows<NumberAttribute>(
      where: where(NumberAttribute.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class NumberAttributeAttachRowRepository {
  const NumberAttributeAttachRowRepository._();

  /// Creates a relation between the given [NumberAttribute] and [AccessLevel]
  /// by setting the [NumberAttribute]'s foreign key `accessLevelId` to refer to the [AccessLevel].
  Future<void> accessLevel(
    _i2.DatabaseSession session,
    NumberAttribute numberAttribute,
    _i4.AccessLevel accessLevel, {
    _i2.Transaction? transaction,
  }) async {
    if (numberAttribute.id == null) {
      throw ArgumentError.notNull('numberAttribute.id');
    }
    if (accessLevel.id == null) {
      throw ArgumentError.notNull('accessLevel.id');
    }

    var $numberAttribute = numberAttribute.copyWith(
      accessLevelId: accessLevel.id,
    );
    await session.db.updateRow<NumberAttribute>(
      $numberAttribute,
      columns: [NumberAttribute.t.accessLevelId],
      transaction: transaction,
    );
  }
}
