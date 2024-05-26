import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:throwings/src/throwings_list/throwings_list_bloc.dart';

import '../settings/settings_view.dart';
import 'throwing_details_view.dart';

/// Displays a list of SampleItems.
class ThrowingsListView extends StatefulWidget {
  const ThrowingsListView({
    super.key,
  });

  static const routeName = '/throwings';

  @override
  State<ThrowingsListView> createState() => _ThrowingsListViewState();
}

class _ThrowingsListViewState extends State<ThrowingsListView> {
  @override
  void initState() {
    super.initState();

    context.read<ThrowingsListBloc>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Throwings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: BlocBuilder<ThrowingsListBloc, ThrowingsListState>(
        builder: (context, state) {
          return ListView.builder(
            // Providing a restorationId allows the ListView to restore the
            // scroll position when a user leaves and returns to the app after it
            // has been killed while running in the background.
            restorationId: 'sampleItemListView',
            itemCount: state.throwings.length,
            itemBuilder: (BuildContext context, int index) {
              final item = state.throwings[index];

              return ListTile(
                title: Text(
                  item.description,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: item.map != const NoneCS2Map()
                    ? Image.network(item.map.pathToImage)
                    : null,
                onTap: () {
                  // Navigate to the details page. If the user leaves and returns to
                  // the app after it has been killed while running in the
                  // background, the navigation stack is restored.
                  Navigator.restorablePushNamed(
                    context,
                    ThrowingDetailsView.routeName,
                    arguments: index,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
