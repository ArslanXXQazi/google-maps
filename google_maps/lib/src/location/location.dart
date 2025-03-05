import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        
      }



  }


  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
