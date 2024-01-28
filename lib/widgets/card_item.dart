import 'package:ecohouse/widgets/elevaded_button_with_icon.dart';
import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Item $index'),
                  subtitle: Text('Description for Item $index'),
                  // Add more content as needed
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButtonWithIcon(
          onPressed: () => {},
          label: 'Add categorie',
          icon: Icons.add,
        )
      ],
    );
  }
}
