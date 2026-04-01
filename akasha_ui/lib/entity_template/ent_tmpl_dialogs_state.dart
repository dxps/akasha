import 'package:akasha_client/akasha_client.dart';

sealed class EntityTemplatesState {}

class EntityTemplatesStateInitial extends EntityTemplatesState {}

class EntityTemplatesStateOpenModalFor extends EntityTemplatesState {
  final EntityTmpl entityTmpl;

  EntityTemplatesStateOpenModalFor({required this.entityTmpl});
}
