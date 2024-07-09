import 'package:bma_cars/screens/login.dart';
import 'package:bma_cars/widgets/progress_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Positioned(
                    width: 46.87,
                    height: 54.15,
                    top: 124,
                    left: 172.57,
                    child: Image.asset('assets/images/carhome.png')),
                Positioned(
                    width: 300,
                    height: 115.76,
                    top: 320,
                    left: 47,
                    child: Image.asset('assets/images/mechanic.png')),
                const Positioned(
                    top: 475,
                    left: 12,
                    child: ProgressAnimation(currentStep: 1)),
                Positioned(
                    width: 280,
                    height: 69,
                    top: 559,
                    left: 57,
                    child: Column(
                      children: [
                        const Text(
                          'Let' 's get started',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Color.fromARGB(255, 22, 38, 37),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          lorem(paragraphs: 1, words: 12),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color.fromARGB(255, 128, 128, 128),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
                Positioned(
                    height: 49,
                    width: 310,
                    top: 658,
                    left: 41.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 239, 110, 49),
                        //padding:const EdgeInsets.fromLTRB(15, 110, 15, 110),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ));
                      },
                    ))
              ],
            )));
  }
}
