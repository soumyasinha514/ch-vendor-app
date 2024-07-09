import 'package:flutter/material.dart';

class ProgressAnimation extends StatefulWidget {
 const ProgressAnimation({super.key, required this.currentStep});

  final int currentStep;
  @override
  State<ProgressAnimation> createState() {
    return _ProgressAnimationState();
  }
}

class _ProgressAnimationState extends State<ProgressAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration:const Duration(seconds: 3),
      vsync: this,
    );

    _animation = ColorTween(
      begin:const Color.fromARGB(255, 217, 217, 217),
      end:const Color.fromARGB(255, 68, 68, 68),
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return AnimatedContainer(
              duration:const Duration(seconds: 2),
              color: widget.currentStep <= index
                  ?const Color.fromARGB(255, 217, 217, 217)
                  : _animation.value,
              margin:const EdgeInsets.symmetric(horizontal: 4.0),
              height: 4.0,
              width: 113.0,
            );
          },
        );
      }),
    );
  }
}
