import 'package:flutter/material.dart';
import 'package:ecohouse/core/features/shop/models/item.dart';

import 'shop_card.dart';

class ShopListView extends StatefulWidget {
  final List<ItemModule> items;
  final List<ItemModule> selectedItems;
  const ShopListView({
    Key? key,
    required this.items,
    required this.selectedItems,
  }) : super(key: key);

  @override
  State<ShopListView> createState() => _ShopListViewState();
}

class _ShopListViewState extends State<ShopListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                ),
                child: const Icon(Icons.search),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return ShopCard(
                item: widget.items[index],
                selected: widget.selectedItems.contains(widget.items[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
