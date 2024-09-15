import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lab3/models/Exam.dart'; // Importing the Exam model
import 'package:lab3/services/location_provider.dart'; // Importing the LocationProvider service
import 'package:provider/provider.dart'; // Importing Provider package for state management

class MapView extends StatefulWidget {
  final List<Exam> exams; // List of Exam objects to be displayed on the map.

  const MapView(
      {super.key,
      required this.exams}); // Constructor to initialize the exams list.

  @override
  State<MapView> createState() =>
      MapViewState(); // Create state for the MapView widget.
}

class MapViewState extends State<MapView> {
  GoogleMapController?
      _mapController; // Controller to interact with the Google Map.

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    locationProvider.onMapCreated(
        controller); // Notify the provider that the map is created
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: true);

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
              target: locationProvider.currentLocation.coordinates,
              zoom: 15.0,
            ),
            markers: locationProvider.extractMarkersFromExams(widget.exams),
            circles: {locationProvider.currentLocationCircle},
            polylines: locationProvider.routePolyline != null
                ? {locationProvider.routePolyline!}
                : {},
          ),

          // "Cancel Route" button, visible only when a route is active
          if (locationProvider.isRouteActive)
            Positioned(
              bottom: 20,
              left: 20, // Position the button on the left
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue, // Button color
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextButton(
                  onPressed: () {
                    // Clear the route when the button is pressed
                    locationProvider.clearRoute();
                    setState(() {});
                  },
                  child: const Text(
                    'Exit Route',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
