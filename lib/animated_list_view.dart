import 'package:flutter/material.dart';

import 'animation_type.dart';
import 'animation_wrapper.dart';

class AnimatedListView extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final AnimationType animationType;

  const AnimatedListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.animationType,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final child = itemBuilder(context, index);
        return AnimationWrapper(
          index: index,
          type: animationType,
          child: child,
        );
      },
    );
  }
}
