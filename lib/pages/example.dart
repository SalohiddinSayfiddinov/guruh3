import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};

  Future<Position> _determinePosition() async {
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

  Future<void> _setCurrentLocation() async {
    Position position = await _determinePosition();
    LatLng userLatLng = LatLng(position.latitude, position.longitude);

    setState(() {
      _markers = {
        Marker(
          markerId: MarkerId("me"),
          position: userLatLng,
          infoWindow: InfoWindow(title: "You are here"),
        ),
      };
    });

    _mapController.animateCamera(
      CameraUpdate.newLatLng(userLatLng),
    );
  }

  @override
  void initState() {
    super.initState();
    _setCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) => _mapController = controller,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: _markers,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            50.30234608100745,
            80.26852962988664,
          ),
          zoom: 15.0,
        ),
      ),
    );
  }
}
