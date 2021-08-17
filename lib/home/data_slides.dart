import 'package:flutter/material.dart';
import 'package:pro_final/home/cards/card_temperature.dart';
import 'package:pro_final/home/cards/card_electricity.dart';
import 'package:pro_final/home/cards/card_Humidity.dart';
import 'package:pro_final/home/cards/card_lights.dart';
class DataSlides extends StatelessWidget {
  DataSlides({ Key? key }) : super(key: key);

  final gTempSlide = const CardTemperature();
  final gElectricitySlide = const CardElectricity();
  final gHumidity = const CardHumidity();
  final gLights = const CardLights();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            gTempSlide,
            const SizedBox(height: 20.0,),
            gElectricitySlide,
          ],
        ),
        const SizedBox(width: 30.0,),

        Column(
          children: [
            gLights,
            const SizedBox(
              height: 20.0,
            ),
            gHumidity,
          ],
        ),
      ],
    );
  }
}