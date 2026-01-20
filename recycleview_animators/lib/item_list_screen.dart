import 'package:flutter/material.dart';
import '../model/item.dart';
import 'animated_list_view.dart';
import 'animation_type.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  AnimationType selectedAnimation = AnimationType.fade;

  final List<Item> items = List.generate(
    50,
        (i) => Item(
      image: 'assets/images/image.jpg',
      title: 'Item ${i + 1}',
      description: 'This is the description of item ${i + 1}',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recycler Animations Demo'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _animationSelector(),
          Expanded(
            child: AnimatedListView(
              itemCount: items.length,
              animationType: selectedAnimation,
              itemBuilder: (context, index) {
                return _itemCard(items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Animation Dropdown
  Widget _animationSelector() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: DropdownButtonFormField<AnimationType>(
        value: selectedAnimation,
        decoration: const InputDecoration(
          labelText: 'Select Animation',
          border: OutlineInputBorder(),
        ),
        items: AnimationType.values
            .map(
              (type) => DropdownMenuItem(
            value: type,
            child: Text(type.name),
          ),
        )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() => selectedAnimation = value);
          }
        },
      ),
    );
  }

  /// 🔹 Item UI
  Widget _itemCard(Item item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      child: ListTile(
        leading: Image.asset(
          item.image,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
        ),
        title: Text(item.title),
        subtitle: Text(item.description),
      ),
    );
  }
}
