import 'dart:math';
import 'package:flutter/material.dart';
import 'animation_type.dart';

class AnimationWrapper extends StatelessWidget {
  final Widget child;
  final int index;
  final AnimationType type;
  final Duration? duration;
  final Curve curve;

  const AnimationWrapper({
    super.key,
    required this.child,
    required this.index,
    required this.type,
    this.duration,
    this.curve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    final animDuration =
        duration ?? Duration(milliseconds: 300 + index * 30);

    switch (type) {
      case AnimationType.fade:
        return _fade(animDuration);

      case AnimationType.slideLeft:
        return _slide(animDuration, const Offset(-1, 0));

      case AnimationType.slideRight:
        return _slide(animDuration, const Offset(1, 0));

      case AnimationType.slideUp:
        return _slide(animDuration, const Offset(0, 1));

      case AnimationType.slideDown:
        return _slide(animDuration, const Offset(0, -1));

      case AnimationType.scale:
        return _scale(animDuration, 0.8);

      case AnimationType.fadeSlide:
        return _fadeSlide(animDuration);

      case AnimationType.rotate:
        return _rotate(animDuration);

      case AnimationType.flipX:
        return _flip(animDuration, true);

      case AnimationType.flipY:
        return _flip(animDuration, false);

      case AnimationType.bounce:
        return _bounce(animDuration);
    }
  }

  /// 🔹 Animations

  Widget _fade(Duration duration) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      curve: curve,
      builder: (_, value, __) =>
          Opacity(opacity: value, child: child),
    );
  }

  Widget _slide(Duration duration, Offset begin) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: begin, end: Offset.zero),
      duration: duration,
      curve: curve,
      builder: (_, value, __) =>
          Transform.translate(offset: value * 100, child: child),
    );
  }

  Widget _scale(Duration duration, double begin) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: begin, end: 1),
      duration: duration,
      curve: curve,
      builder: (_, value, __) =>
          Transform.scale(scale: value, child: child),
    );
  }

  Widget _fadeSlide(Duration duration) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      curve: curve,
      builder: (_, value, __) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, (1 - value) * 40),
          child: child,
        ),
      ),
    );
  }

  Widget _rotate(Duration duration) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -pi / 12, end: 0),
      duration: duration,
      curve: curve,
      builder: (_, value, __) =>
          Transform.rotate(angle: value, child: child),
    );
  }

  Widget _flip(Duration duration, bool isX) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: pi, end: 0),
      duration: duration,
      curve: curve,
      builder: (_, value, __) => Transform(
        alignment: Alignment.center,
        transform: isX
            ? Matrix4.rotationX(value)
            : Matrix4.rotationY(value),
        child: child,
      ),
    );
  }

  Widget _bounce(Duration duration) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.7, end: 1),
      duration: duration,
      curve: Curves.elasticOut,
      builder: (_, value, __) =>
          Transform.scale(scale: value, child: child),
    );
  }
}
