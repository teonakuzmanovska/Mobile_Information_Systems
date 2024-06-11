import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lab3/models/Exam.dart';
import 'package:lab3/services/location_provider.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  final List<Exam> exams;

  const MapView({super.key, required this.exams});

  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
  }

  Set<Marker> convertToMarkers(List<Exam> exams) {
    Set<Marker> markers = {};

    exams.forEach((exam) {
      var coordinates = exam.location.coordinates;

      markers.add(
        Marker(
          markerId: MarkerId('marker_${markers.length + 1}'),
          position: coordinates,
          infoWindow: InfoWindow(
            title: '${exam.title} Exam Location',
            snippet:
                'Lat: ${coordinates.latitude}, Lng: ${coordinates.longitude}',
          ),
        ),
      );
    });

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);
    return GoogleMap(
      onMapCreated: locationProvider.onMapCreated,
      initialCameraPosition: CameraPosition(
        target: locationProvider.currentLocation.coordinates,
        zoom: 15.0,
      ),
      markers: convertToMarkers(widget.exams),
    );
  }
}
