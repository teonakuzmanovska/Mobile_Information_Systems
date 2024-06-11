import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lab3/models/Exam.dart';

class MapView extends StatefulWidget {
  final List<Exam> userCourses;

  const MapView({super.key, required this.userCourses});

  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  GoogleMapController? mapController;

  final LatLng _initialPosition =
      const LatLng(39.8283, -98.5795); // Center of the map (USA)

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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _initialPosition,
        zoom: 3.0,
      ),
      markers: convertToMarkers(widget.userCourses),
    );
  }
}
