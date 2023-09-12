import 'package:flutter/material.dart';

import 'sample_item.dart';
import '../settings/settings_controller.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
    required this.controller
  });

  static const routeName = '/';
  final List<SampleItem> items;
  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: controller.themeMode == ThemeMode.dark ? const Icon(Icons.sunny) : const Icon(Icons.nightlight),
            onPressed: () async {
              await controller.changeThemeModeValue();
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      body: Container(
        margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
        padding: EdgeInsets.all(2),
        child: ListView.builder(
          restorationId: 'sampleItemListView',
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];
            return ListTile(
                title: Text('SampleItem ${item.id}'),
                leading: const CircleAvatar(
                  foregroundImage: AssetImage('assets/images/flutter_logo.png'),
                ),
                contentPadding: const EdgeInsets.all(5),
                onTap: () {}
            );
          },
        ),
      ) 
    );
  }
}
