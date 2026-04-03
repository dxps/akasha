import 'package:akasha_client/akasha_client.dart';

void upsertList<T extends HasId>(List<T> list, T item) {
  final index = list.indexWhere((e) => e.id == item.id);
  if (index != -1) {
    list[index] = item;
  } else {
    list.add(item);
  }
}
