import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lab3/models/Location.dart' as location_model;

class LocationProvider with ChangeNotifier {
  late GoogleMapController mapController;
  bool isLoading = true;

  late location_model.Location currentLocation;
  late location_model.Location selectedLocation;
  late Marker locationMarker;

  LocationProvider() {
    currentLocation =
        location_model.Location(coordinates: const LatLng(0, 0), address: "");
    selectedLocation =
        location_model.Location(coordinates: const LatLng(0, 0), address: "");
    locationMarker = Marker(
      markerId: const MarkerId('initial-location'),
      position: currentLocation.coordinates,
    );

    getCurrentLocation();
    updatePickedLocationMarker(currentLocation);
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      isLoading = false;
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        isLoading = false;
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      isLoading = false;
      return;
    }

    // If permissions are granted, get the current location
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentLocation.coordinates =
          LatLng(position.latitude, position.longitude);
      await _getAddressFromCoordinates(currentLocation);

      mapController.animateCamera(
        CameraUpdate.newLatLng(currentLocation.coordinates),
      );
    } catch (e) {
      print("Error getting current location: $e");
    }

    isLoading = false;
    notifyListeners(); // Notify listeners that currentLocation has changed

    updatePickedLocationMarker(currentLocation);
  }

  Future<void> _getAddressFromCoordinates(
      location_model.Location location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.coordinates.latitude,
        location.coordinates.longitude,
      );
      location.address = placemarks.first.name ?? '';
    } catch (e) {
      print("Error getting address from coordinates: $e");
    }
  }

  void updatePickedLocationMarker(location_model.Location location) async {
    locationMarker = Marker(
      markerId: const MarkerId('picked-location'),
      position: location.coordinates,
      infoWindow: InfoWindow(
        title: 'Selected Location',
        snippet: location.address,
      ),
    );

    notifyListeners(); // Notify listeners that marker has changed
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (!isLoading) {
      mapController.animateCamera(
        CameraUpdate.newLatLng(currentLocation.coordinates),
      );
    }
  }

  void onMapTap(LatLng location) {
    selectedLocation.coordinates = location;
    selectedLocation.address = '';
    _getAddressFromCoordinates(selectedLocation);

    mapController.animateCamera(
      CameraUpdate.newLatLng(location),
    );

    updatePickedLocationMarker(selectedLocation);
  }

  void selectLocationAndPop(BuildContext context) {
    selectedLocation = location_model.Location(
      coordinates: selectedLocation.coordinates,
      address: selectedLocation.address,
    );
    Navigator.of(context).pop(selectedLocation);
  }
}
