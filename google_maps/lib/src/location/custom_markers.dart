import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';
import 'dart:ui';
import 'dart:ui'as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    LatLng(24.8607, 67.0011),  // Karachi
    LatLng(31.5497, 74.3436),  // Lahore
    LatLng(33.6844, 73.0479),  // Islamabad
    LatLng(33.6007, 73.0679),  // Rawalpindi
    LatLng(31.4504, 73.1350),  // Faisalabad
    LatLng(34.0151, 71.5249),  // Peshawar
    LatLng(30.1798, 66.9750),  // Quetta
    LatLng(30.1575, 71.5249),  // Multan
    LatLng(25.3960, 68.3773),  // Hyderabad
    LatLng(32.4927, 74.5313),  // Sialkot

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData (){

    for( int start=0; start < markerImages.length; start++ )
      {

        markers.add(
          Marker(
            icon: BitmapDescriptor.defaultMarker,
              markerId: MarkerId(start.toString()),
            infoWindow: InfoWindow(
              title: getCityNames(start)
            )
          ),
        );
        setState(() {
          
        });
      }

  }

  String getCityNames(int index)
  {
    switch (index){
      case 0:
        return "Karachi";
      case 1:
        return "Lahore";
      case 2:
        return "Islamabad";
      case 3:
        return "Rawalpindi";
      case 4:
        return "Faisalabad";
      case 5:
        return "Peshawar";
      case 6:
        return "Quetta";
      case 7:
        return "Multan";
      case 8:
        return "Hyderabad";
      case 9:
        return "Sialkot";
      default:
        return "Position: $index";
    }
  }


  Future<Uint8List?> getBytesFromAssets(String path, int width) async {

    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();

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
