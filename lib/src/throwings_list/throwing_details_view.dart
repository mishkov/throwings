import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:throwings/src/throwings_list/network_video_preview.dart';
import 'package:throwings/src/throwings_list/throwings_list_bloc.dart';

class ThrowingDetailsView extends StatefulWidget {
  const ThrowingDetailsView({
    super.key,
    required this.selectedIndex,
  });

  static const routeName = '/throwing_details';

  final int selectedIndex;

  @override
  State<ThrowingDetailsView> createState() => _ThrowingDetailsViewState();
}

class _ThrowingDetailsViewState extends State<ThrowingDetailsView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThrowingsListBloc, ThrowingsListState>(
      builder: (context, state) {
        final throwing = state.throwings[widget.selectedIndex];

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  final messenger = ScaffoldMessenger.of(context);
                  messenger.clearSnackBars();
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Скоро станет доступно!',
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.favorite_border_rounded,
                ),
              ),
              IconButton(
                onPressed: () {
                  final messenger = ScaffoldMessenger.of(context);
                  messenger.clearSnackBars();
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Скоро станет доступно!',
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.share_rounded,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    throwing.grenade.readableName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(throwing.description),
                  const SizedBox(height: 8),
                  NetworkVideoPreview(url: throwing.pathToVideo),
                  const SizedBox(height: 16),
                  Text(
                    'Позиция на карте',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                        maxHeight: 300,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ),
                      child: throwing.map != const NoneCS2Map()
                          ? AspectRatio(
                              aspectRatio: 1,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints.expand(),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    assert(constraints.hasTightHeight);
                                    assert(constraints.hasTightWidth);

                                    const pointSize = 10.0;

                                    final width = constraints.maxWidth;
                                    final height = constraints.maxHeight;

                                    return Stack(
                                      children: [
                                        Image.network(
                                          throwing.map.pathToImage,
                                        ),
                                        Positioned(
                                          left: throwing.selectedPosition.dx *
                                                  width -
                                              pointSize / 2,
                                          top: throwing.selectedPosition.dy *
                                                  height -
                                              pointSize / 2,
                                          child: Container(
                                            height: pointSize,
                                            width: pointSize,
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            )
                          : const Center(
                              child: Text('Невалидная карты'),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Бросание',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: throwing.throwingSteps.length,
                    separatorBuilder: (_, index) {
                      final step = throwing.throwingSteps[index];
                      if (step.type == ThrowingStepType.zoomedAiming) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.question_mark_rounded),
                              Expanded(
                                child: Text(
                                  throwing.howToThrowText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return const SizedBox(height: 4);
                    },
                    itemBuilder: (context, index) {
                      final step = throwing.throwingSteps[index];

                      return SizedBox(
                        height: 300,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Image.network(
                                  step.pathToNetworkImage,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Icon(
                                  step.type.icon,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

extension on Grenade {
  String get readableName => switch (this) {
        Grenade.flashbang => 'Флешка',
        Grenade.molotov => 'Молотов',
        Grenade.highExplosive => 'Хаешка',
        Grenade.smoke => 'Дым',
        Grenade.none => 'Не определено',
      };
}

extension ReadableThrowingStepType on ThrowingStepType {
  String get readableName => switch (this) {
        ThrowingStepType.positioning => 'позиционирование',
        ThrowingStepType.aiming => 'прицеливание',
        ThrowingStepType.zoomedAiming => 'приближенное прицеливание',
        ThrowingStepType.additional => 'дополнительно',
        ThrowingStepType.result => 'результат раскидки',
        ThrowingStepType.none => 'Не определено',
      };

  IconData get icon => switch (this) {
        ThrowingStepType.positioning => Icons.place_rounded,
        ThrowingStepType.aiming => Icons.my_location_rounded,
        ThrowingStepType.zoomedAiming => Icons.my_location_rounded,
        ThrowingStepType.additional => Icons.info_rounded,
        ThrowingStepType.result => Icons.done_rounded,
        ThrowingStepType.none => Icons.image_not_supported_rounded,
      };
}
