import 'package:throwings/src/throwings_list/throwings_list_bloc.dart';

extension SerializableThrowingStepType on ThrowingStepType {
  static ThrowingStepType fromString(String value) {
    return ThrowingStepType.values.singleWhere(
      (element) => element.name == value,
      orElse: () => ThrowingStepType.none,
    );
  }
}
