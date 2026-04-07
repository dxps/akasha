import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/entity_template/ent_tmpl_repo.dart';

class EntityTemplatesState {
  List<EntityTmpl> items = [];
  bool? isLoading;

  EntityTemplatesState();
  EntityTemplatesState.initial();

  (EntityTmpl? item, bool isEmpty) getItemById(UuidValue id) {
    final item = items.firstWhere((ent) => ent.id == id, orElse: () => EntityTmpl(name: ''));
    return (isEmpty(item) ? (null, true) : (item, false));
  }

  EntityTemplatesState copyWith({List<EntityTmpl>? items, bool? isLoading}) {
    final newState = EntityTemplatesState();
    newState.items = items ?? this.items;
    newState.isLoading = isLoading ?? this.isLoading;
    return newState;
  }
}

class EntityTemplatesStateOpenModalFor extends EntityTemplatesState {
  final EntityTmpl forItem;

  EntityTemplatesStateOpenModalFor({required this.forItem});
}

class EntityTemplatesStateLoading extends EntityTemplatesState {
  EntityTemplatesStateLoading() : super() {
    isLoading = true;
  }
}

class EntityTemplatesStateLoaded extends EntityTemplatesState {
  EntityTemplatesStateLoaded(List<EntityTmpl> items) : super() {
    this.items = items;
    isLoading = false;
  }
}

class EntityTemplatesStateError extends EntityTemplatesState {
  final String errorMessage;

  EntityTemplatesStateError({required this.errorMessage}) : super() {
    isLoading = false;
  }
}
