import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkers extends StatefulWidget {
  const CustomMarkers({super.key});

  @override
  State<CustomMarkers> createState() => _CustomMarkersState();
}

class _CustomMarkersState extends State<CustomMarkers> {
  @override

  GoogleMapController? googleMapController;

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
    LatLng(24.8607, 67.0011),
    LatLng(31.5497, 74.3436),
    LatLng(33.6844, 73.0479),
    LatLng(33.6007, 73.0679),
    LatLng(31.4504, 73.1350),
    LatLng(34.0151, 71.5249),
    LatLng(30.1798, 66.9750),
    LatLng(30.1575, 71.5249),
    LatLng(25.3960, 68.3773),
    LatLng(32.4927, 74.5313),

  ];

  loadData (){

    for( int start=0; start < markerImages.length; start++ )
      {

        markers.add(
          Marker(
            icon: BitmapDescriptor.defaultMarker,
              markerId: MarkerId(start.toString()),
            infoWindow: InfoWindow(
              title: "Position : $start"
            )
          ),
        );
      }

  }


  static CameraPosition initialCameraPosition= CameraPosition(target: (LatLng(24.8607, 67.0011)),zoom: 14);

  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(markers),
          initialCameraPosition:initialCameraPosition,
        onMapCreated: (GoogleMapController controller){
          googleMapController=controller;
        },
      ),
    );
  }
}
