import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserCurrentLocation extends StatefulWidget {
  const UserCurrentLocation({super.key});

  @override
  State<UserCurrentLocation> createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {
  @override
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

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.location_on),),
      body: GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          markers: _marker,
         onMapCreated: (GoogleMapController controller){
            googleMapController=controller;
         },
      ),

    );
  }
}
