import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiContainer extends StatefulWidget {
  const ConfettiContainer({super.key});

  @override
  State<ConfettiContainer> createState() => _ConfettiContainerState();
}

class _ConfettiContainerState extends State<ConfettiContainer> {
  late ConfettiController _confettiController;
  @override
  void initState() {
    // TODO: implement initState
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 4000));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Align(
        alignment: Alignment.center,
        child: ConfettiWidget(
          minBlastForce: 15,
          numberOfParticles: 30,
          emissionFrequency: 0.05,
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality
              .explosive, // don't specify a direction, blast randomly
          shouldLoop: false, // start again as soon as the animation is finished
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple,
            Colors.white,
            Colors.black,
            Colors.yellow
          ], // manually specify the colors to be used
          createParticlePath: drawStar, // define a custom shape/path.
        ),
      ),
    );
  }
}
