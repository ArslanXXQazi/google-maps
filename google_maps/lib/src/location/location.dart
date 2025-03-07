import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  String placeName="";
  String locality="";
  String adminstrativeArea="";
  String cordinates='';
  double lat=0;
  double long=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentLocation();
  }

  Future<void> _currentLocation ()async
  {
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnable)
      {
      setState(() {
        // _cordinates="blbvcjklbvsjkvb";
      });
      return;
      }

    permission= await Geolocator.checkPermission();
    if(permission==LocationPermission.denied)
      {
        permission= await Geolocator.requestPermission();
        if(permission==LocationPermission.denied)
          {
            setState(() {
              cordinates='Location Perimission Denied';
            });
            return;
          }
      }

    if(permission== LocationPermission.deniedForever)
      {
        setState(() {
          cordinates='Location Permission Denied Forever';
        });
        return ;
      }

    Position position= await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,);

    setState(() {
      lat=position.latitude;
      long=position.longitude;
      cordinates ='Let : ${position.latitude}, lan : ${position.longitude}';
    });

    await _getLocationNames( position.longitude, position.latitude);

    Future<void> _getLocationNames(double lat, double long) async
    {
      try
          {
            List<Placemark> placemark= await placemarkFromCoordinates(lat, long);
            if(placemark.isNotEmpty)
              {

              }
          }
          catch(e){

          }
    }



  }


  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
