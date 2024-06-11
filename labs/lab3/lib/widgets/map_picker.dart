import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lab3/services/location_provider.dart';
import 'package:provider/provider.dart';

class MapPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocationProvider(),
      child: _MapPickerContent(),
    );
  }
}

class _MapPickerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              locationProvider.selectLocationAndPop(context);
            },
          ),
        ],
      ),
      body: Consumer<LocationProvider>(
        builder: (context, provider, child) {
          return provider.isLoading
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
                  onMapCreated: provider.onMapCreated,
                  onTap: provider.onMapTap,
                  initialCameraPosition: CameraPosition(
                    target: provider.currentLocation.coordinates,
                    zoom: 15,
                  ),
                  markers: {provider.locationMarker},
                );
        },
      ),
    );
  }
}
