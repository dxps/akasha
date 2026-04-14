import 'package:akasha_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('EntityTmplEndpoint', (sessionBuilder, endpoints) {
    test(
      'read includes attribute template details for template attributes',
      () async {
        final suffix = DateTime.now().microsecondsSinceEpoch;
        final accessLevelResponse = await endpoints.accessLevel.create(
          sessionBuilder,
          AccessLevel(name: 'Test access $suffix'),
        );
        final accessLevelId = accessLevelResponse.data!.id!;

        final attrTemplateResponse = await endpoints.attrTmpls.create(
          sessionBuilder,
          AttributeTmpl(
            name: 'Weight $suffix',
            valueType: ValueType.number.name,
            defaultValue: '42',
            required: true,
            accessLevelId: accessLevelId,
            accessLevel: null,
          ),
        );
        final attrTemplate = attrTemplateResponse.data!;

        final entityTemplateResponse = await endpoints.entityTmpl.create(
          sessionBuilder,
          EntityTmpl(
            name: 'Box $suffix',
            attributes: [
              EntityTmplAttribute(
                entityTmplId: UuidValue.fromString(
                  '00000000-0000-0000-0000-000000000000',
                ),
                attributeTmplId: attrTemplate.id!,
                orderIdx: 0,
              ),
            ],
          ),
        );

        final entityTemplate = await endpoints.entityTmpl.read(
          sessionBuilder,
          entityTemplateResponse.data!.id!,
        );
        final templateAttribute =
            entityTemplate!.attributes!.single.attributeTmpl;

        expect(templateAttribute, isNotNull);
        expect(templateAttribute!.name, 'Weight $suffix');
        expect(templateAttribute.valueType, ValueType.number.name);
      },
    );
  });
}
