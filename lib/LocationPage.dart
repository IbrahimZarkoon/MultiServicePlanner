import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Enums/Colors.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {

  final Completer<GoogleMapController> _controller = Completer();
  LatLng _currentLatLng = LatLng(0, 0); // Default to (0, 0) or any other initial value

  bool _locationLoaded = false;

  String loc = "Select location";

  bool _showSearchBar = false;

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
        loc = "${_currentLatLng.latitude}, ${_currentLatLng.longitude}";
      });

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(_currentLatLng, 18),
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
        backgroundColor: appPrimary,
        leadingWidth: 30,
        automaticallyImplyLeading: true,
        title: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: _showSearchBar
              ? TextField( // Replace this with your desired search bar widget
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white,fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white),
            ),
          )
              : Text(
            loc,
            style: TextStyle(fontSize: 14),
          ),
        ),
        actions: [
          IconButton(
            icon: _showSearchBar ? Icon(Icons.close) : Icon(Icons.search),
            onPressed: () {
              setState(() {
                _showSearchBar = !_showSearchBar;
              });
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        initialCameraPosition: _locationLoaded
            ? CameraPosition(target: _currentLatLng, zoom: 15)
            : CameraPosition(target: LatLng(0, 0), zoom: 15),
        onTap: (latlong)
        {
          setState(() {
            _currentLatLng = latlong;
          });
        },
        mapType: MapType.normal,
        markers: {
          Marker(
            markerId: MarkerId('currentLocation'),
            position: _currentLatLng,
            icon: BitmapDescriptor.defaultMarker,
          ),
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [

          FloatingActionButton(
            backgroundColor: appPrimary,
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newLatLngZoom(_currentLatLng, 18),
              ); // Refresh the map with the current location
            },
            child: const Icon(CupertinoIcons.location),
          ),

          const SizedBox(height: 20,),

          FloatingActionButton(
            backgroundColor: appPrimary,
            onPressed: () {
              _getCurrentLocation(); // Refresh the map with the current location
            },
            child: const Icon(Icons.location_searching),
          ),
        ],
      ),

      bottomNavigationBar: _currentLatLng == LatLng(0,0)?
      SizedBox()
      :
      InkWell(
        onTap: ()
        {
          Navigator.pop(context,_currentLatLng);
        },
        child: Container(
          padding: EdgeInsets.only(top: 20,bottom: 20),
          //margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color:  appPrimary,
            //borderRadius: BorderRadius.circular(15)
          ),

          child: Text("Continue",style: TextStyle(color: Color(0xffffffff),fontSize: 12),textAlign: TextAlign.center,),
        ),
      ),
    );
  }

}
