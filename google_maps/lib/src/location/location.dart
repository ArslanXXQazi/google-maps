import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  String placeName = "";
  String locality = "";
  String administrativeArea = "";
  String country = "";
  String coordinates = '';
  double? lat;
  double? long;

  @override
  void initState() {
    super.initState();
    _currentLocation();
  }

  Future<void> _currentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        coordinates = 'Location services are disabled.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          coordinates = 'Location Permission Denied';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        coordinates = 'Location Permission Denied Forever';
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      lat = position.latitude;
      long = position.longitude;
      coordinates = 'Lat: ${position.latitude}, Lng: ${position.longitude}';
    });

    await _getLocationNames(position.latitude, position.longitude);
  }

  Future<void> _getLocationNames(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      if (placemarks.isNotEmpty) {
        setState(() {
          placeName = placemarks[0].name ?? "";
          locality = placemarks[0].locality ?? "";
          administrativeArea = placemarks[0].administrativeArea ?? "";
          country = placemarks[0].country ?? "";
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        placeName = 'Error';
        locality = 'Error';
        administrativeArea = 'Error';
        country = 'Error';
      });
    }
  }

  //  final CameraPosition  cameraPosition= CameraPosition(target: LatLng(lat, long),
  //     zoom: 14,
  // );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GeoLocator Example'),
        centerTitle: true,
      ),
       body: lat==null || long==null? Center(child: Text('Fetching Current Location'),):
       GoogleMap(
         initialCameraPosition: CameraPosition(
             target: LatLng(lat!, long!),
            zoom: 14,
         ),
       )
      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 20),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       SizedBox(height: 30,),
      //       Text(
      //         "Coordinates: $coordinates",
      //         style: TextStyle(
      //           fontSize: 15,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.black,
      //         ),
      //       ),
      //       SizedBox(height: 30,),
      //       Text(
      //         "Place: $placeName",
      //         style: TextStyle(
      //           fontSize: 15,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.black,
      //         ),
      //       ),
      //       SizedBox(height: 30,),
      //       Text(
      //         "Locality: $locality",
      //         style: TextStyle(
      //           fontSize: 15,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.black,
      //         ),
      //       ),
      //       SizedBox(height: 30,),
      //       Text(
      //         "Administrative Area: $administrativeArea",
      //         style: TextStyle(
      //           fontSize: 15,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.black,
      //         ),
      //       ),
      //       SizedBox(height: 30,),
      //       Text(
      //         "Country: $country",
      //         style: TextStyle(
      //           fontSize: 15,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.black,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
