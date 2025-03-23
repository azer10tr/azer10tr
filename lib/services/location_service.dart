import 'package:employee_attendance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationService{
  Location location = Location();
  late LocationData _locData;

  Future<Map<String,double?>?> initializedAndGetLocation(
    BuildContext context) async {
      bool serviceEnabled;
      PermissionStatus permissionGranted;

      // first check whether location is enabled or not in the device
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled){
        serviceEnabled = await location.requestService();
        if (!serviceEnabled){
          Utils.showSnackBar("Please Enable location Service",context);
          return null;
        }
      }
      // if service is enabled then ask permission for location from user
      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied){
        permissionGranted = await location.requestPermission();
        if(permissionGranted != PermissionStatus.granted){
          Utils.showSnackBar("please Allow Location Access", context);
          return null;
        }
      }
      // after permission is granted then return the cordinates
      _locData= await location.getLocation();
      return {
        'latitude':_locData.latitude,
        'longitude': _locData.longitude,
      };




    }
}
