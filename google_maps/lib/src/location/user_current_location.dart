import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserCurrentLocation extends StatefulWidget {
  const UserCurrentLocation({super.key});

  @override
  State<UserCurrentLocation> createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {
  @override
  String streetAdress='0';
  GoogleMapController? googleMapController;
  Set<Marker> _marker={};

  static CameraPosition _initialCameraPosition=CameraPosition(target: LatLng(33.6844, 73.0479),zoom: 14);

  Future<Position> userCurrentLocation () async
  {
    await Geolocator.requestPermission().
    then((value){}).
    catchError((error){
      print("Error $error");
    });

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _getLocationNames(double lat, double long) async
  {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      if (placemarks.isNotEmpty) {
        setState(() {
          streetAdress = placemarks[0].street ?? "";
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {

      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Position position = await userCurrentLocation();
          LatLng userlatLng=LatLng(position.latitude, position.longitude);

          setState(() {
            _marker.add(
              Marker(
                markerId: MarkerId('1'),
                position: userlatLng,
                infoWindow: InfoWindow(
                  title: "$streetAdress"
                )
              )
            );
          });

          googleMapController!.animateCamera(
            CameraUpdate.newLatLngZoom(userlatLng, 13),
          );

        },child: Icon(Icons.location_on),),


      body: GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          markers: _marker,
         onMapCreated: (GoogleMapController controller){
            googleMapController=controller;
         },
        zoomControlsEnabled: false,
      ),

    );
  }
}
