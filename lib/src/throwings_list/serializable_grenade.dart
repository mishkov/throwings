import 'package:throwings/src/throwings_list/throwings_list_bloc.dart';

extension SerializableGrenade on Grenade {
  static Grenade fromString(String value) {
    return Grenade.values.singleWhere(
      (element) => element.name == value,
      orElse: () => Grenade.none,
    );
  }
}
