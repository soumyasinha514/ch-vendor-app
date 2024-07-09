import 'package:flutter/material.dart';





class CarHomeText extends StatefulWidget {
  const CarHomeText({super.key});
  @override
  State<CarHomeText> createState() {
   return _CarHomeTextState();
  }
}

class _CarHomeTextState extends State<CarHomeText> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
 late List<Animation<double>> _animations;
 final String _text = "CARHOME";

  @override
  void initState() {
    super.initState();

    _controllers = List<AnimationController>.generate(_text.length, (index) {
      return AnimationController(
        vsync: this,
        duration:const Duration(milliseconds: 500),
      );
    });

    _animations = _controllers.map((controller) {
      return CurvedAnimation(
        parent: controller,
        curve: Curves.bounceInOut,
      );
    }).toList();

    _playAnimations();
  }

  Future<void> _playAnimations() async {
    for (var controller in _controllers) {
      await Future.delayed(const Duration(milliseconds: 500));
      controller.forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_text.length, (index) {
            return ScaleTransition(
              scale: _animations[index],
              child: Text(
                _text[index],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(249, 239, 109, 49)
                ),
              ),
            );
          }),
        );
     
  }
}