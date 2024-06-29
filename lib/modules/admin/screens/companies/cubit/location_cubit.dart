import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:palestine_commercial_directory/modules/admin/screens/companies/cubit/location_states.dart';
import 'package:palestine_commercial_directory/shared/widgets/custom_text_widget.dart';
import '../../../../../core/presentation/Palette.dart';
import '../../../../../core/values/constants.dart';

class LocationCubit extends Cubit<LocationStates> {
  LocationCubit() : super(LocationInitialState());

  static LocationCubit get(context) => BlocProvider.of(context);

  // Location _locationController = new Location();

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  LatLng? companyLocation;

  LatLng? currentP;

  StreamSubscription<Position>? _locationSubscription;

  Map<PolylineId, Polyline> polylines = {};

  @override
  Future<void> close() {
    if (_locationSubscription != null) {
      _locationSubscription!.cancel();
    }
    return super.close();
  }

  Future<void> _showLocationServiceDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Services Disabled'),
          content: const Text('Please enable location services to continue.'),
          actions: <Widget>[
            TextButton(
              child: const DefaultText(
                text: 'Cancel',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const DefaultText(text: 'Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openLocationSettings();
              },
            ),
          ],
        );
      },
    );
  }

  void requestPermission() async {
    const permission = Permission.location;

    if (await permission.isDenied || await permission.isPermanentlyDenied) {
      await permission.request();
    }
  }

  Future<void> checkLocationServiceIsEnabled(BuildContext context) async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled return an error message
      await _showLocationServiceDialog(context);
      emit(EnableLocationServiceState());
      print('dialog opened');
      // return Future.error('Location services are disabled.');
    }
    print('after dialog openned');

    Permission permission = Permission.location;

    if (await permission.isDenied || await permission.isPermanentlyDenied) {
      await permission.request();
    }
    if (await permission.isGranted) {
      await getUserLocation();
    }
  }

  Future<Position> _determinePosition() async {
    print('in determine position');
    Position position = await Geolocator.getCurrentPosition(
        // forceAndroidLocationManager: true,
        );
    return position;
  }

  Future<void> getUserLocation() async {
    _determinePosition().then(
      (pos) async {
        currentP = LatLng(pos.latitude, pos.longitude);
        print('current :$currentP');
        emit(UpdateLocationState());
        await _getPolylinePoints();
        // _getLocationUpdates();
      },
    );
  }

  void _getLocationUpdates() async {
    try {
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 50,
      );

      _locationSubscription =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position position) async {
        LatLng pos = LatLng(position.latitude, position.longitude);
        await _getPolylinePoints();
        if (currentP != null && currentP != pos) {
          print('check distance');
          double distance = Geolocator.distanceBetween(
            currentP!.latitude,
            currentP!.longitude,
            position.latitude,
            position.longitude,
          );
          print('distance: $distance');

          currentP = LatLng(position.latitude, position.longitude);
          print('updated: $currentP');
          if (distance < 50) {
            return; // Ignore updates if the distance is less than 100 meters
          }
        }

        await _cameraToPosition(LatLng(position.latitude, position.longitude));
        print('camera position moved');
        // emit(UpdateLocationState());
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await mapController.future;
    CameraPosition newCameraPosition =
        CameraPosition(target: pos, zoom: 13, tilt: 50.0);
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
    );
  }

  void onPressOrigin() async {
    if (currentP != null) {
      await _cameraToPosition(currentP!);
    }
  }

  void onPressDestination() async {
    if (companyLocation != null) {
      await _cameraToPosition(companyLocation!);
    }
  }

  Future<void> _getPolylinePoints() async {
    try {
      print('get poly points');
      List<LatLng> polylineCoordinates = [];
      PolylinePoints polylinePoints = PolylinePoints();
      // Get route between coordinates
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        GOOGLE_MAPS_API_KEY,
        PointLatLng(companyLocation!.latitude, companyLocation!.longitude),
        PointLatLng(currentP!.latitude, currentP!.longitude),
        travelMode: TravelMode.driving,
      );

      // Check for errors in the result
      if (result.status == 'OK' && result.points.isNotEmpty) {
        print('Points: ${result.points}');
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
        generatePolyLineFromPoints(polylineCoordinates);
      } else {
        print('Error getting polyline points: ${result.errorMessage}');
      }
    } catch (e) {
      print('Error: $e');
    }
    // print('get poly points');
    // List<LatLng> polylineCoordinates = [];
    // PolylinePoints polylinePoints = PolylinePoints();
    // polylinePoints
    //     .getRouteBetweenCoordinates(
    //   GOOGLE_MAPS_API_KEY,
    //   PointLatLng(companyLocation.latitude, companyLocation.longitude),
    //   PointLatLng(currentP!.latitude, currentP!.longitude),
    //   travelMode: TravelMode.driving,
    // )
    //     .then((result) {
    //   print('result: ${result}');
    //   if (result.points.isNotEmpty) {
    //     print('points: ${result.points}');
    //     result.points.forEach((PointLatLng point) {
    //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    //     });
    //     generatePolyLineFromPoints(polylineCoordinates);
    //   } else {
    //     print(result.errorMessage);
    //   }
    // });
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
        polylineId: id,
        color: Palette.adminPageIconsColor,
        points: polylineCoordinates,
        width: 6);
    polylines[id] = polyline;
    emit(StorePolyLineState());
  }
}
