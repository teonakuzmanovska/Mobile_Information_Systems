import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lab3/models/Location.dart' as location_model;

class MapPicker extends StatefulWidget {
  @override
  _MapPickerState createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  late GoogleMapController mapController;
  LatLng _pickedLocation = const LatLng(0, 0);
  String _pickedAddress = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // If permissions are granted, get the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _pickedLocation = LatLng(position.latitude, position.longitude);
      _isLoading = false;
    });

    _getAddressFromLatLng();
    mapController.animateCamera(
      CameraUpdate.newLatLng(_pickedLocation),
    );
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _pickedLocation.latitude,
        _pickedLocation.longitude,
      );
      setState(() {
        _pickedAddress = placemarks.first.name ?? '';
      });
    } catch (e) {
      print("Error getting address from coordinates: $e");
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (!_isLoading) {
      mapController.animateCamera(
        CameraUpdate.newLatLng(_pickedLocation),
      );
    }
  }

  void _onMapTap(LatLng location) {
    setState(() {
      _pickedLocation = location;
      _pickedAddress = '';
    });
    _getAddressFromLatLng();
    mapController.animateCamera(
      CameraUpdate.newLatLng(location),
    );
  }

  void _selectLocation() {
    location_model.Location location = location_model.Location(
        coordinates: _pickedLocation, address: _pickedAddress);
    Navigator.of(context)
        .pop(location); // Return selected location to previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _selectLocation,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              onTap: _onMapTap,
              initialCameraPosition: CameraPosition(
                target: _pickedLocation,
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('picked-location'),
                  position: _pickedLocation,
                ),
              },
            ),
    );
  }
}
