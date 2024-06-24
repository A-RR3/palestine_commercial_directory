import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:videos_application/modules/admin/screens/companies/cubit/location_cubit.dart';

class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget(
      {super.key, required this.companyLat, required this.locationCubit});
  final LatLng companyLat;
  final LocationCubit locationCubit;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      onMapCreated: ((GoogleMapController controller) =>
          locationCubit.mapController.complete(controller)),
      initialCameraPosition: CameraPosition(
        target: locationCubit.currentP!,
        zoom: 13,
      ),
      markers: {
        Marker(
            markerId: const MarkerId("_currentLocation"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: locationCubit.currentP!,
            infoWindow: const InfoWindow(title: 'origin')),
        Marker(
            markerId: const MarkerId("_companyLocation"),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: companyLat,
            infoWindow: const InfoWindow(title: 'destination')),
      },
      polylines: Set<Polyline>.of(locationCubit.polylines.values),
    );
  }
}
