import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    'assets/bike1.png',
    'assets/bike2.png',
    'assets/bike3.png',
    'assets/bike4.png',
    'assets/bike5.png',
  ];

  List<Marker> markers =[];

  List<LatLng> cordinates=[
    LatLng(2323, 2324),
    LatLng(2323, 2324),
    LatLng(2323, 2324),
    LatLng(2323, 2324),
    LatLng(2323, 2324),
    LatLng(2323, 2324),
    LatLng(2323, 2324),
    LatLng(2323, 2324),
    LatLng(2323, 2324),
    LatLng(2323, 2324),
  ];

  loadData (){

    for( int start=0; start < markerImages.length; start++ )
      {
        markers.add(
          Marker(markerId: (sta),
            infoWindow: InfoWindow(
              title: ""
            )
          ),

        );
      }

  }

  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
