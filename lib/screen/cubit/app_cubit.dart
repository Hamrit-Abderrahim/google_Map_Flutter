import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map/screen/cubit/app-state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());
  static AppCubit get(context) => BlocProvider.of(context);
  //********geturrentPosition********/
  double? altitude;
  double? longitude;
  String? address;
  String? area;
//****************getYourPosirion/************* */ */
  var markers = HashSet<Marker>();
  double? lat;
  double? long;

  void getYourPosition(LatLng latLng) {
    markers.clear();
    markers.add(
      Marker(
          draggable: true,
          markerId: const MarkerId('1'),
          position: LatLng(latLng.latitude, latLng.longitude),
          infoWindow: const InfoWindow(title: 'map', snippet: 'map')),
    );
    lat = latLng.latitude;
    long = latLng.longitude;
    final coordinates = Coordinates(lat, long);

    address = null;
    Geocoder.local.findAddressesFromCoordinates(coordinates).then((value) {
      print(value.first.addressLine);
      address = '${value.first.addressLine}';
      area = '${value.first.adminArea}';
      emit(GetAddreesSuccessState());
    });
    print(lat);
    print(long);
    emit(GetPositionSuccessState());
  }

  //************** *********//

  getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }
}
