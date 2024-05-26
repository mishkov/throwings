import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:throwings/src/throwings_list/serializable_grenade.dart';
import 'package:throwings/src/throwings_list/serializable_throwing_step_type.dart';

class ThrowingsListBloc extends Cubit<ThrowingsListState> {
  ThrowingsListBloc() : super(const ThrowingsListState());

  Future<void> init() async {
    await fetchMaps();
    await fetchThrowings();
  }

  Future<void> fetchMaps() async {
    try {
      final db = FirebaseFirestore.instance;
      final event = await db.collection("maps").get();

      List<CS2Map> result = [];
      for (final doc in event.docs) {
        final data = doc.data();
        result.add(
          CS2Map(
            id: doc.id,
            name: data['name'],
            pathToImage: data['url'],
          ),
        );
      }

      emit(state.copyWith(maps: result));
    } catch (error) {
      emit(state.copyWith(message: 'Ошибка получения карт: $error'));
      throwInDebug(error);
    }
  }

  Future<void> fetchThrowings() async {
    try {
      final db = FirebaseFirestore.instance;
      final event = await db.collection("throwings").get();

      List<Throwing> result = [];
      for (final doc in event.docs) {
        final data = doc.data();
        result.add(
          Throwing(
            description: data['description'] ?? '',
            howToThrowText: data['howToThrowText'] ?? '',
            grenade: SerializableGrenade.fromString(data['grenade']),
            selectedPosition: Offset(
              data['position']['dx'] ?? 0,
              data['position']['dy'] ?? 0,
            ),
            pathToVideo: data['videoUrl'] ?? '',
            map: state.maps.singleWhere(
              (element) => element.id == data['map'],
              orElse: () => const NoneCS2Map(),
            ),
            throwingSteps: ((data['steps'] ?? []) as List)
                .map(
                  (e) => ThrowingStep(
                    pathToNetworkImage: e['pathToImage'],
                    type: SerializableThrowingStepType.fromString(
                      e['type'],
                    ),
                  ),
                )
                .toList(),
          ),
        );
      }

      emit(state.copyWith(throwings: result));
    } catch (error) {
      emit(state.copyWith(message: 'Ошибка получения карт: $error'));
      throwInDebug(error);
    }
  }

  void markMessageAsHandler() {
    emit(state.copyWith(message: ''));
  }
}

class ThrowingsListState extends Equatable {
  final List<CS2Map> maps;
  final List<Throwing> throwings;
  final String message;

  const ThrowingsListState({
    this.maps = const [],
    this.throwings = const [],
    this.message = '',
  });

  @override
  List<Object> get props => [maps, throwings, message];

  ThrowingsListState copyWith({
    List<CS2Map>? maps,
    List<Throwing>? throwings,
    String? message,
  }) {
    return ThrowingsListState(
      maps: maps ?? this.maps,
      throwings: throwings ?? this.throwings,
      message: message ?? this.message,
    );
  }
}

class Throwing extends Equatable {
  final CS2Map map;
  final Grenade grenade;
  final String description;
  final String howToThrowText;
  final Offset selectedPosition;

  final String pathToVideo;
  final List<ThrowingStep> throwingSteps;

  const Throwing({
    required this.map,
    required this.grenade,
    required this.description,
    required this.howToThrowText,
    required this.selectedPosition,
    required this.pathToVideo,
    required this.throwingSteps,
  });

  @override
  List<Object> get props {
    return [
      map,
      grenade,
      description,
      howToThrowText,
      selectedPosition,
      pathToVideo,
      throwingSteps,
    ];
  }
}

class CS2Map extends Equatable {
  final String id;

  final String name;

  final String pathToImage;

  const CS2Map({
    required this.id,
    required this.name,
    required this.pathToImage,
  });

  @override
  List<Object> get props => [id, name, pathToImage];
}

/// Use this class to indicate that no map is selected.
class NoneCS2Map extends CS2Map {
  const NoneCS2Map() : super(name: '', id: '', pathToImage: '');
}

enum Grenade {
  flashbang,
  smoke,
  highExplosive,
  molotov,

  /// Use it to indicate that no one grenade is selected.
  none,
}

class ThrowingStep extends Equatable {
  final String pathToNetworkImage;
  final ThrowingStepType type;

  const ThrowingStep({
    required this.pathToNetworkImage,
    required this.type,
  });

  @override
  List<Object> get props => [pathToNetworkImage, type];

  ThrowingStep copyWith({
    String? pathToNetworkImage,
    ThrowingStepType? type,
  }) {
    return ThrowingStep(
      pathToNetworkImage: pathToNetworkImage ?? this.pathToNetworkImage,
      type: type ?? this.type,
    );
  }
}

enum ThrowingStepType {
  positioning,
  aiming,
  zoomedAiming,
  additional,
  result,
  none,
}

void throwInDebug(Object error) {
  assert(() {
    throw error;
  }());
}
