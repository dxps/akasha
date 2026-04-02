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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'access_level/access_level.dart' as _i5;
import 'access_level/access_level_api_resp.dart' as _i6;
import 'attribute/bool_attr.dart' as _i7;
import 'attribute/date_attr.dart' as _i8;
import 'attribute/datetime_attr.dart' as _i9;
import 'attribute/number_attr.dart' as _i10;
import 'attribute/text_attr.dart' as _i11;
import 'attribute/attr.dart' as _i12;
import 'attribute_template/attr_tmpl.dart' as _i13;
import 'attribute_template/attr_tmpl_api_resp.dart' as _i14;
import 'entity/ent_links.dart' as _i15;
import 'entity/entity.dart' as _i16;
import 'entity_template/entity_tmpl.dart' as _i17;
import 'entity_template/entity_tmpl_api_resp.dart' as _i18;
import 'entity_template/entity_tmpl_attribute.dart' as _i19;
import 'entity_template/entity_tmpl_link.dart' as _i20;
import 'shared/api/exceptions/api_exception.dart' as _i21;
import 'shared/model/has_id.dart' as _i22;
import 'shared/model/value_type.dart' as _i23;
import 'package:akasha_server/src/generated/access_level/access_level.dart'
    as _i24;
import 'package:akasha_server/src/generated/attribute_template/attr_tmpl.dart'
    as _i25;
import 'package:akasha_server/src/generated/entity_template/entity_tmpl.dart'
    as _i26;
export 'access_level/access_level.dart';
export 'access_level/access_level_api_resp.dart';
export 'attribute/bool_attr.dart';
export 'attribute/date_attr.dart';
export 'attribute/datetime_attr.dart';
export 'attribute/number_attr.dart';
export 'attribute/text_attr.dart';
export 'attribute/attr.dart';
export 'attribute_template/attr_tmpl.dart';
export 'attribute_template/attr_tmpl_api_resp.dart';
export 'entity/ent_links.dart';
export 'entity/entity.dart';
export 'entity_template/entity_tmpl.dart';
export 'entity_template/entity_tmpl_api_resp.dart';
export 'entity_template/entity_tmpl_attribute.dart';
export 'entity_template/entity_tmpl_link.dart';
export 'shared/api/exceptions/api_exception.dart';
export 'shared/model/has_id.dart';
export 'shared/model/value_type.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'access_levels',
      dartName: 'AccessLevel',
      schema: 'public',
      module: 'akasha',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'access_levels_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'access_levels_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'access_level_name_uniq_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'name',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'attribute_tmpls',
      dartName: 'AttributeTmpl',
      schema: 'public',
      module: 'akasha',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'valueType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'defaultValue',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'required',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'accessLevelId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'attribute_tmpls_fk_0',
          columns: ['accessLevelId'],
          referenceTable: 'access_levels',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'attribute_tmpls_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'attr_tmpl_name_desc_uniq_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'name',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'description',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'bool_attributes',
      dartName: 'BoolAttribute',
      schema: 'public',
      module: 'akasha',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'valueType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ValueType',
        ),
        _i2.ColumnDefinition(
          name: 'value',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'accessLevelId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'bool_attributes_fk_0',
          columns: ['accessLevelId'],
          referenceTable: 'access_levels',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'bool_attributes_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'date_attributes',
      dartName: 'DateAttribute',
      schema: 'public',
      module: 'akasha',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'valueType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ValueType',
        ),
        _i2.ColumnDefinition(
          name: 'value',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'accessLevelId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'date_attributes_fk_0',
          columns: ['accessLevelId'],
          referenceTable: 'access_levels',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'date_attributes_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'datetime_attributes',
      dartName: 'DateTimeAttribute',
      schema: 'public',
      module: 'akasha',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'valueType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ValueType',
        ),
        _i2.ColumnDefinition(
          name: 'value',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'accessLevelId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'datetime_attributes_fk_0',
          columns: ['accessLevelId'],
          referenceTable: 'access_levels',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'datetime_attributes_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'entities',
      dartName: 'Entity',
      schema: 'public',
      module: 'akasha',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'attributesOrder',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<(int, String,)>',
        ),
        _i2.ColumnDefinition(
          name: 'textAttributes',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:TextAttribute>',
        ),
        _i2.ColumnDefinition(
          name: 'numberAttributes',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:NumberAttribute>',
        ),
        _i2.ColumnDefinition(
          name: 'boolAttributes',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:BoolAttribute>',
        ),
        _i2.ColumnDefinition(
          name: 'dateAttributes',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:DateAttribute>',
        ),
        _i2.ColumnDefinition(
          name: 'dateTimeAttributes',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:DateTimeAttribute>',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'entities_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'entity_links',
      dartName: 'EntityLink',
      schema: 'public',
      module: 'akasha',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'orderIdx',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'sourceId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'targetId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'entity_links_fk_0',
          columns: ['sourceId'],
          referenceTable: 'entities',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'entity_links_fk_1',
          columns: ['targetId'],
          referenceTable: 'entities',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'entity_links_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'entity_tmpl_attributes',
      dartName: 'EntityTmplAttribute',
      schema: 'public',
      module: 'akasha',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'entity_tmpl_attributes_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'entityTmplId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'attributeTmplId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'orderIdx',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'entity_tmpl_attributes_fk_0',
          columns: ['entityTmplId'],
          referenceTable: 'entity_tmpls',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'entity_tmpl_attributes_fk_1',
          columns: ['attributeTmplId'],
          referenceTable: 'attribute_tmpls',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'entity_tmpl_attributes_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'entity_tmpl_attribute_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'entityTmplId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'attributeTmplId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'entity_tmpl_attribute_order_idx_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'entityTmplId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'orderIdx',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'entity_tmpl_links',
      dartName: 'EntityTmplLink',
      schema: 'public',
      module: 'akasha',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'orderIdx',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'sourceId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'targetId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'entity_tmpl_links_fk_0',
          columns: ['sourceId'],
          referenceTable: 'entity_tmpls',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'entity_tmpl_links_fk_1',
          columns: ['targetId'],
          referenceTable: 'entity_tmpls',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'entity_tmpl_links_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'entity_link_tmpl_source_name_uniq_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sourceId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'name',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'entity_tmpls',
      dartName: 'EntityTmpl',
      schema: 'public',
      module: 'akasha',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'entity_tmpls_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'entity_tmpl_name_desc_uniq_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'name',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'description',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'number_attributes',
      dartName: 'NumberAttribute',
      schema: 'public',
      module: 'akasha',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'valueType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ValueType',
        ),
        _i2.ColumnDefinition(
          name: 'value',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'accessLevelId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'number_attributes_fk_0',
          columns: ['accessLevelId'],
          referenceTable: 'access_levels',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'number_attributes_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'text_attributes',
      dartName: 'TextAttribute',
      schema: 'public',
      module: 'akasha',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'valueType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ValueType',
        ),
        _i2.ColumnDefinition(
          name: 'value',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'accessLevelId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'text_attributes_fk_0',
          columns: ['accessLevelId'],
          referenceTable: 'access_levels',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'text_attributes_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5.AccessLevel) {
      return _i5.AccessLevel.fromJson(data) as T;
    }
    if (t == _i6.AccessLevelApiResponse) {
      return _i6.AccessLevelApiResponse.fromJson(data) as T;
    }
    if (t == _i7.BoolAttribute) {
      return _i7.BoolAttribute.fromJson(data) as T;
    }
    if (t == _i8.DateAttribute) {
      return _i8.DateAttribute.fromJson(data) as T;
    }
    if (t == _i9.DateTimeAttribute) {
      return _i9.DateTimeAttribute.fromJson(data) as T;
    }
    if (t == _i10.NumberAttribute) {
      return _i10.NumberAttribute.fromJson(data) as T;
    }
    if (t == _i11.TextAttribute) {
      return _i11.TextAttribute.fromJson(data) as T;
    }
    if (t == _i12.Attribute) {
      return _i12.Attribute.fromJson(data) as T;
    }
    if (t == _i13.AttributeTmpl) {
      return _i13.AttributeTmpl.fromJson(data) as T;
    }
    if (t == _i14.AttributeTmplApiResponse) {
      return _i14.AttributeTmplApiResponse.fromJson(data) as T;
    }
    if (t == _i15.EntityLink) {
      return _i15.EntityLink.fromJson(data) as T;
    }
    if (t == _i16.Entity) {
      return _i16.Entity.fromJson(data) as T;
    }
    if (t == _i17.EntityTmpl) {
      return _i17.EntityTmpl.fromJson(data) as T;
    }
    if (t == _i18.EntityTmplApiResponse) {
      return _i18.EntityTmplApiResponse.fromJson(data) as T;
    }
    if (t == _i19.EntityTmplAttribute) {
      return _i19.EntityTmplAttribute.fromJson(data) as T;
    }
    if (t == _i20.EntityTmplLink) {
      return _i20.EntityTmplLink.fromJson(data) as T;
    }
    if (t == _i21.ApiException) {
      return _i21.ApiException.fromJson(data) as T;
    }
    if (t == _i22.HasId) {
      return _i22.HasId.fromJson(data) as T;
    }
    if (t == _i23.ValueType) {
      return _i23.ValueType.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.AccessLevel?>()) {
      return (data != null ? _i5.AccessLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AccessLevelApiResponse?>()) {
      return (data != null ? _i6.AccessLevelApiResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.BoolAttribute?>()) {
      return (data != null ? _i7.BoolAttribute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.DateAttribute?>()) {
      return (data != null ? _i8.DateAttribute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.DateTimeAttribute?>()) {
      return (data != null ? _i9.DateTimeAttribute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.NumberAttribute?>()) {
      return (data != null ? _i10.NumberAttribute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.TextAttribute?>()) {
      return (data != null ? _i11.TextAttribute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Attribute?>()) {
      return (data != null ? _i12.Attribute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.AttributeTmpl?>()) {
      return (data != null ? _i13.AttributeTmpl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.AttributeTmplApiResponse?>()) {
      return (data != null
              ? _i14.AttributeTmplApiResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i15.EntityLink?>()) {
      return (data != null ? _i15.EntityLink.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.Entity?>()) {
      return (data != null ? _i16.Entity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.EntityTmpl?>()) {
      return (data != null ? _i17.EntityTmpl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.EntityTmplApiResponse?>()) {
      return (data != null ? _i18.EntityTmplApiResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.EntityTmplAttribute?>()) {
      return (data != null ? _i19.EntityTmplAttribute.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.EntityTmplLink?>()) {
      return (data != null ? _i20.EntityTmplLink.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.ApiException?>()) {
      return (data != null ? _i21.ApiException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.HasId?>()) {
      return (data != null ? _i22.HasId.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.ValueType?>()) {
      return (data != null ? _i23.ValueType.fromJson(data) : null) as T;
    }
    if (t == List<(int, String)>) {
      return (data as List).map((e) => deserialize<(int, String)>(e)).toList()
          as T;
    }
    if (t == _i1.getType<(int, String)>()) {
      return (
            deserialize<int>(((data as Map)['p'] as List)[0]),
            deserialize<String>(data['p'][1]),
          )
          as T;
    }
    if (t == List<_i11.TextAttribute>) {
      return (data as List)
              .map((e) => deserialize<_i11.TextAttribute>(e))
              .toList()
          as T;
    }
    if (t == List<_i10.NumberAttribute>) {
      return (data as List)
              .map((e) => deserialize<_i10.NumberAttribute>(e))
              .toList()
          as T;
    }
    if (t == List<_i7.BoolAttribute>) {
      return (data as List)
              .map((e) => deserialize<_i7.BoolAttribute>(e))
              .toList()
          as T;
    }
    if (t == List<_i8.DateAttribute>) {
      return (data as List)
              .map((e) => deserialize<_i8.DateAttribute>(e))
              .toList()
          as T;
    }
    if (t == List<_i9.DateTimeAttribute>) {
      return (data as List)
              .map((e) => deserialize<_i9.DateTimeAttribute>(e))
              .toList()
          as T;
    }
    if (t == List<_i15.EntityLink>) {
      return (data as List).map((e) => deserialize<_i15.EntityLink>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i15.EntityLink>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i15.EntityLink>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i19.EntityTmplAttribute>) {
      return (data as List)
              .map((e) => deserialize<_i19.EntityTmplAttribute>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i19.EntityTmplAttribute>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i19.EntityTmplAttribute>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i20.EntityTmplLink>) {
      return (data as List)
              .map((e) => deserialize<_i20.EntityTmplLink>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i20.EntityTmplLink>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i20.EntityTmplLink>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i24.AccessLevel>) {
      return (data as List)
              .map((e) => deserialize<_i24.AccessLevel>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.AttributeTmpl>) {
      return (data as List)
              .map((e) => deserialize<_i25.AttributeTmpl>(e))
              .toList()
          as T;
    }
    if (t == List<_i26.EntityTmpl>) {
      return (data as List).map((e) => deserialize<_i26.EntityTmpl>(e)).toList()
          as T;
    }
    if (t == _i1.getType<(int, String)>()) {
      return (
            deserialize<int>(((data as Map)['p'] as List)[0]),
            deserialize<String>(data['p'][1]),
          )
          as T;
    }
    if (t == _i1.getType<(int, String)>()) {
      return (
            deserialize<int>(((data as Map)['p'] as List)[0]),
            deserialize<String>(data['p'][1]),
          )
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.AccessLevel => 'AccessLevel',
      _i6.AccessLevelApiResponse => 'AccessLevelApiResponse',
      _i7.BoolAttribute => 'BoolAttribute',
      _i8.DateAttribute => 'DateAttribute',
      _i9.DateTimeAttribute => 'DateTimeAttribute',
      _i10.NumberAttribute => 'NumberAttribute',
      _i11.TextAttribute => 'TextAttribute',
      _i12.Attribute => 'Attribute',
      _i13.AttributeTmpl => 'AttributeTmpl',
      _i14.AttributeTmplApiResponse => 'AttributeTmplApiResponse',
      _i15.EntityLink => 'EntityLink',
      _i16.Entity => 'Entity',
      _i17.EntityTmpl => 'EntityTmpl',
      _i18.EntityTmplApiResponse => 'EntityTmplApiResponse',
      _i19.EntityTmplAttribute => 'EntityTmplAttribute',
      _i20.EntityTmplLink => 'EntityTmplLink',
      _i21.ApiException => 'ApiException',
      _i22.HasId => 'HasId',
      _i23.ValueType => 'ValueType',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('akasha.', '');
    }

    switch (data) {
      case _i5.AccessLevel():
        return 'AccessLevel';
      case _i6.AccessLevelApiResponse():
        return 'AccessLevelApiResponse';
      case _i7.BoolAttribute():
        return 'BoolAttribute';
      case _i8.DateAttribute():
        return 'DateAttribute';
      case _i9.DateTimeAttribute():
        return 'DateTimeAttribute';
      case _i10.NumberAttribute():
        return 'NumberAttribute';
      case _i11.TextAttribute():
        return 'TextAttribute';
      case _i12.Attribute():
        return 'Attribute';
      case _i13.AttributeTmpl():
        return 'AttributeTmpl';
      case _i14.AttributeTmplApiResponse():
        return 'AttributeTmplApiResponse';
      case _i15.EntityLink():
        return 'EntityLink';
      case _i16.Entity():
        return 'Entity';
      case _i17.EntityTmpl():
        return 'EntityTmpl';
      case _i18.EntityTmplApiResponse():
        return 'EntityTmplApiResponse';
      case _i19.EntityTmplAttribute():
        return 'EntityTmplAttribute';
      case _i20.EntityTmplLink():
        return 'EntityTmplLink';
      case _i21.ApiException():
        return 'ApiException';
      case _i22.HasId():
        return 'HasId';
      case _i23.ValueType():
        return 'ValueType';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AccessLevel') {
      return deserialize<_i5.AccessLevel>(data['data']);
    }
    if (dataClassName == 'AccessLevelApiResponse') {
      return deserialize<_i6.AccessLevelApiResponse>(data['data']);
    }
    if (dataClassName == 'BoolAttribute') {
      return deserialize<_i7.BoolAttribute>(data['data']);
    }
    if (dataClassName == 'DateAttribute') {
      return deserialize<_i8.DateAttribute>(data['data']);
    }
    if (dataClassName == 'DateTimeAttribute') {
      return deserialize<_i9.DateTimeAttribute>(data['data']);
    }
    if (dataClassName == 'NumberAttribute') {
      return deserialize<_i10.NumberAttribute>(data['data']);
    }
    if (dataClassName == 'TextAttribute') {
      return deserialize<_i11.TextAttribute>(data['data']);
    }
    if (dataClassName == 'Attribute') {
      return deserialize<_i12.Attribute>(data['data']);
    }
    if (dataClassName == 'AttributeTmpl') {
      return deserialize<_i13.AttributeTmpl>(data['data']);
    }
    if (dataClassName == 'AttributeTmplApiResponse') {
      return deserialize<_i14.AttributeTmplApiResponse>(data['data']);
    }
    if (dataClassName == 'EntityLink') {
      return deserialize<_i15.EntityLink>(data['data']);
    }
    if (dataClassName == 'Entity') {
      return deserialize<_i16.Entity>(data['data']);
    }
    if (dataClassName == 'EntityTmpl') {
      return deserialize<_i17.EntityTmpl>(data['data']);
    }
    if (dataClassName == 'EntityTmplApiResponse') {
      return deserialize<_i18.EntityTmplApiResponse>(data['data']);
    }
    if (dataClassName == 'EntityTmplAttribute') {
      return deserialize<_i19.EntityTmplAttribute>(data['data']);
    }
    if (dataClassName == 'EntityTmplLink') {
      return deserialize<_i20.EntityTmplLink>(data['data']);
    }
    if (dataClassName == 'ApiException') {
      return deserialize<_i21.ApiException>(data['data']);
    }
    if (dataClassName == 'HasId') {
      return deserialize<_i22.HasId>(data['data']);
    }
    if (dataClassName == 'ValueType') {
      return deserialize<_i23.ValueType>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i5.AccessLevel:
        return _i5.AccessLevel.t;
      case _i7.BoolAttribute:
        return _i7.BoolAttribute.t;
      case _i8.DateAttribute:
        return _i8.DateAttribute.t;
      case _i9.DateTimeAttribute:
        return _i9.DateTimeAttribute.t;
      case _i10.NumberAttribute:
        return _i10.NumberAttribute.t;
      case _i11.TextAttribute:
        return _i11.TextAttribute.t;
      case _i13.AttributeTmpl:
        return _i13.AttributeTmpl.t;
      case _i15.EntityLink:
        return _i15.EntityLink.t;
      case _i16.Entity:
        return _i16.Entity.t;
      case _i17.EntityTmpl:
        return _i17.EntityTmpl.t;
      case _i19.EntityTmplAttribute:
        return _i19.EntityTmplAttribute.t;
      case _i20.EntityTmplLink:
        return _i20.EntityTmplLink.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'akasha';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    if (record is (int, String)) {
      return {
        "p": [
          record.$1,
          record.$2,
        ],
      };
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }

  /// Maps container types (like [List], [Map], [Set]) containing
  /// [Record]s or non-String-keyed [Map]s to their JSON representation.
  ///
  /// It should not be called for [SerializableModel] types. These
  /// handle the "[Record] in container" mapping internally already.
  ///
  /// It is only supposed to be called from generated protocol code.
  ///
  /// Returns either a `List<dynamic>` (for List, Sets, and Maps with
  /// non-String keys) or a `Map<String, dynamic>` in case the input was
  /// a `Map<String, …>`.
  Object? mapContainerToJson(Object obj) {
    if (obj is! Iterable && obj is! Map) {
      throw ArgumentError.value(
        obj,
        'obj',
        'The object to serialize should be of type List, Map, or Set',
      );
    }

    dynamic mapIfNeeded(Object? obj) {
      return switch (obj) {
        Record record => mapRecordToJson(record),
        Iterable iterable => mapContainerToJson(iterable),
        Map map => mapContainerToJson(map),
        Object? value => value,
      };
    }

    switch (obj) {
      case Map<String, dynamic>():
        return {
          for (var entry in obj.entries) entry.key: mapIfNeeded(entry.value),
        };
      case Map():
        return [
          for (var entry in obj.entries)
            {
              'k': mapIfNeeded(entry.key),
              'v': mapIfNeeded(entry.value),
            },
        ];

      case Iterable():
        return [
          for (var e in obj) mapIfNeeded(e),
        ];
    }

    return obj;
  }
}
