import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map/screen/components.dart';
import 'package:google_map/screen/cubit/app-state.dart';
import 'package:google_map/screen/cubit/app_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatelessWidget {
  var longitudeController = TextEditingController();
  var altitudeController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getGeoLocationPosition(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is GetAddreesSuccessState) {
            addressController.text = '${AppCubit.get(context).address}';
            altitudeController.text = '${AppCubit.get(context).lat}';
            longitudeController.text = '${AppCubit.get(context).long}';
            cityController.text = '${AppCubit.get(context).area}';
          }
        },
        builder: (context, states) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: const Text('Google Map'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //********address ************//
                    const Text('Address:', style: TextStyle(fontSize: 20.0)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(context,
                        fillColor: Colors.transparent,
                        controller: addressController,
                        type: TextInputType.text,
                        prifixColor: Colors.red,
                        prefix: Icons.location_on,
                        label: ''),
                    const SizedBox(
                      height: 10.0,
                    ),
                    //********address ************//
                    const Text('City:', style: TextStyle(fontSize: 20.0)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(context,
                        fillColor: Colors.transparent,
                        controller: cityController,
                        type: TextInputType.text,
                        prifixColor: Colors.red,
                        prefix: Icons.location_city,
                        label: ''),
                    const SizedBox(
                      height: 10.0,
                    ),
                    //********address ************//
                    const Text('altitude:', style: TextStyle(fontSize: 20.0)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(context,
                        fillColor: Colors.transparent,
                        controller: altitudeController,
                        type: TextInputType.text,
                        prifixColor: Colors.red,
                        prefix: Icons.location_on_outlined,
                        label: ''),
                    const SizedBox(
                      height: 10.0,
                    ),
                    //********address ************//
                    const Text('longitude:', style: TextStyle(fontSize: 20.0)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(context,
                        fillColor: Colors.transparent,
                        controller: longitudeController,
                        type: TextInputType.text,
                        prifixColor: Colors.red,
                        prefix: Icons.location_on_outlined,
                        label: ''),
                    const SizedBox(
                      height: 10.0,
                    ),

//******************************Map *********************//
                    SizedBox(
                      height: 300.0,
                      child: GoogleMap(
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        onLongPress: (LatLng latLng) {
                          cubit.getYourPosition(
                            latLng,
                          );
                        },
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(36.749439144408605, 3.123196100791499),
                          zoom: 5,
                        ),
                        markers: cubit.markers,
                        zoomGesturesEnabled: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
