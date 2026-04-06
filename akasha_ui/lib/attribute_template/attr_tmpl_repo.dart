import 'package:akasha_client/akasha_client.dart';

class AttributeTemplateRepo {
  final Client client;

  AttributeTemplateRepo({required this.client});

  Future<List<AttributeTmpl>> getAll() async {
    return await client.attrTmpls.readAll();
  }

  Future<AttributeTmplApiResponse> create(AttributeTmpl item) async {
    return await client.attrTmpls.create(item);
  }

  Future<AttributeTmplApiResponse> update(AttributeTmpl item) async {
    return await client.attrTmpls.update(item);
  }

  Future<bool> delete(UuidValue id) async {
    return await client.attrTmpls.delete(id);
  }
}
