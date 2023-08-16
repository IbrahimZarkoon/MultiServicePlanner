import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {

  final Completer<GoogleMapController> _controller = Completer();
  LatLng _currentLatLng = LatLng(0, 0); // Default to (0, 0) or any other initial value

  bool _locationLoaded = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await determinePosition();

      setState(() {
        _currentLatLng = LatLng(position.latitude, position.longitude);
        _locationLoaded = true; // Mark that the location has been loaded
      });

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(_currentLatLng, 15),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();

  }

  @override
  Widget build(BuildContext context) {

    print("_currentLatLng: $_currentLatLng");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffff1f6f),
        title: Text("Select location"),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: _locationLoaded
            ? CameraPosition(target: _currentLatLng, zoom: 15)
            : CameraPosition(target: LatLng(0, 0), zoom: 15),
        onTap: (latlong)
        {
          setState(() {
            _currentLatLng = latlong;
          });
        },

        markers: {
          Marker(
            markerId: MarkerId('currentLocation'),
            position: _currentLatLng,
            icon: BitmapDescriptor.defaultMarker,
          ),
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffff1f6f),
        onPressed: () {
          _getCurrentLocation(); // Refresh the map with the current location
        },
        child: const Icon(Icons.location_searching),
      ),
    );
  }

}
