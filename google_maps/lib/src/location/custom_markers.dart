import 'package:flutter/material.dart';

class CustomMarkers extends StatefulWidget {
  const CustomMarkers({super.key});

  @override
  State<CustomMarkers> createState() => _CustomMarkersState();
}

class _CustomMarkersState extends State<CustomMarkers> {
  @override

  List<String> markerImages=[
    'assets/car1.png',
    'assets/car2.png',
    'assets/car3.png',
    'assets/car4.png',
    'assets/car5.png',

  ];

  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
